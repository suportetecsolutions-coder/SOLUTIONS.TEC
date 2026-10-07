# v75t (138 / 7.5t) — carimbo de 24h

Base: smali da v75q/v75s (`ImportStreamsActivity` e `ImportStreamsActivity$c`).
Uma mudança por build: só o carimbo. Os dois `.smali` desta pasta já estão com o patch aplicado.

## Causa (confirmada no smali)
- `ImportStreamsActivity->e(...)I` devolve o campo **`h`**.
- `h` só é incrementado dentro dos callbacks de **falha** (`a(String)`, `b(String)`, `c(String)`..., e o ramo `p1 == null` de `a(List)`, `b(List)`...). Nos caminhos de sucesso (AsyncTask `$d`, ...) ninguém mexe em `h`.
- Logo `h` é um **contador de erros**, e:
  - `$c.a(Boolean)` só grava `last_full_sync` se `h > 0` (`if-lez v1, :cond_2`) -> **só grava quando deu erro**;
  - `onDestroy` tem o mesmo teste invertido;
  - `tvaquiMarkSync()` (v75b) é chamado nos 12 pontos de falha.
- Importação sem erro nunca grava o carimbo -> o portão de 24h nunca segura -> baixa tudo toda vez.

## Mudanças
1. `$c.a(Boolean)` linha ~182: `if-lez v1, :cond_2` -> `if-gtz v1, :cond_2` (grava só quando **não** houve erro, no fim da cadeia, passo 8 "Finished").
2. `ImportStreamsActivity`: removidas as 12 chamadas `invoke-direct {p0}, ...->tvaquiMarkSync()V` (falha não carimba; a próxima abertura tenta de novo). O método fica, sem uso.
3. `onDestroy`: inserido `const/4 v0, 0x0` antes do `if-lez v0, :cond_1` -> nunca grava (destruir a tela no meio da importação não pode carimbar).

## Para aplicar
Substitua os dois arquivos na árvore decodificada da v75q (`smali_classes2/.../view/activity/`) ou aplique `carimbo-24h.patch` (`git apply -p2`, a partir dessa pasta). Depois: versionCode 138 / 7.5t, build, assinatura e conferência método a método contra a v75q (devem diferir só `ImportStreamsActivity.onDestroy`, `ImportStreamsActivity` nos 12 callbacks e `$c.a(Boolean)`).

## Efeito esperado / como testar
- 1ª abertura do dia: importa tudo e, **sem erro**, grava o carimbo.
- Reabrir 2x seguidas: toast "GATE: ultimo sync ha 0h" e "OK 24H - sem atualizar", entra direto (~5 s).
- Trocar de usuário: reimporta (carimbo amarrado ao usuário).
- Contrapartida: se um passo falhar de forma permanente (ex.: provedor sem séries), o app volta a importar em toda abertura até esse passo funcionar. Se preferir carimbar mesmo assim, é só trocar `if-gtz` por um `goto` incondicional no `$c`.

## Ainda NÃO coberto
- No `onCreate`, ação que começa com `redirect_` **pula o portão** (`if-nez v1, :cond_5`). Se algum chamador abrir a `ImportStreamsActivity` com `redirect_*` na abertura do app ou ao tocar numa seção, ele importa de novo mesmo com carimbo válido. Preciso ver `NewDashboardActivity.e(String)` e `miscelleneious/b/d.g(...)` para saber se isso acontece.
- Item "atualizar canais, filmes e séries" nos 3 pontinhos (precisa do `res/menu` e do tratador do clique).
