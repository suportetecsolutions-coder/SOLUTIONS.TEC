# TVAQUI.PRO — Diagnóstico da lentidão (adicionar usuário / entrar)

*Registrado em 30/09/2026.*

> ⚠️ **ESTE ARQUIVO VAI ATÉ A v75f.** O estado COMPLETO (v75g → v75n, todos os diagnósticos fechados, hashes de todas as builds, ferramentas, regras e os próximos passos exatos) está em **`HANDOFF-06-10-2026.md`** — **leia aquele primeiro**.

## 🚀 JANELA ATUAL — 05/10/2026 (v75b entregue)

**Versão entregue agora:** **`TVAQUI.PRO.v75b.apk` (120 / 7.5b)** — instala por cima da v75a.
- MD5 `5fafff9aade3c2c00ba970bd9af2054f` · SHA-256 `f6184e2511059a4aa1c7a9485dd2def939ce6031e46912ad43cb2bfbccf98d0f`
- 76 238 516 bytes · certificado `cdc87c7f…22076` ✓ · `public.xml` **idêntico** ✓ · `res` com **3 873** arquivos ✓
- `check_wide.py` = **0 problemas**; `check_touched.py` = os **77 avisos pré-existentes** (reuso de `p1`) ✓
- As 5 partes (part0–part4) refazem o APK **idêntico** ✓
- Comando do Termux:
  ```
  cat TVAQUI.PRO.v75b.part0.bin TVAQUI.PRO.v75b.part1.bin TVAQUI.PRO.v75b.part2.bin TVAQUI.PRO.v75b.part3.bin TVAQUI.PRO.v75b.part4.bin > TVAQUI.PRO.v75b.apk
  ```

**Versão seguinte, pronta na mesma sessão:** **`TVAQUI.PRO.v75c.apk` (121 / 7.5c)** — traz a **memória da seleção** (item 2 dos pedidos do cliente, ver adiante).
- MD5 `3480cc8c7375380d853d72353c1e39c0` · SHA-256 `4257250af093a4a4aab402734c0ea95656d3aa01f1fcaf184fd03b6bd3e9c32b`
- 76 242 612 bytes · mesmo certificado `cdc87c7f…22076` ✓ · `public.xml` **idêntico** ✓ · `res` com **3 873** arquivos ✓
- `check_wide.py` = **0 problemas** ✓ · as 5 partes refazem o APK **idêntico** ✓
  ```
  cat TVAQUI.PRO.v75c.part0.bin TVAQUI.PRO.v75c.part1.bin TVAQUI.PRO.v75c.part2.bin TVAQUI.PRO.v75c.part3.bin TVAQUI.PRO.v75c.part4.bin > TVAQUI.PRO.v75c.apk
  ```
- ⚠️ **Mandar a v75c só DEPOIS de o cliente testar a v75b** — não misturar duas mudanças no mesmo teste.

**2ª rodada de ajustes, já sobre o retorno da v75b:** **`TVAQUI.PRO.v75d.apk` (122 / 7.5d)**
- MD5 `15c3009a914bc989cd4b161958d0c443` · SHA-256 `1ace34d30d4bb4fb8afc9e7c24fc7075248332e68344f212702baa8f2b149afa`
- 76 242 612 bytes · certificado `cdc87c7f…22076` ✓ · manifesto com `7.5d` ✓ · 5 partes refazem o APK ✓ · `res` 3 873 e `public.xml` idêntico ✓
  ```
  cat TVAQUI.PRO.v75d.part0.bin TVAQUI.PRO.v75d.part1.bin TVAQUI.PRO.v75d.part2.bin TVAQUI.PRO.v75d.part3.bin TVAQUI.PRO.v75d.part4.bin > TVAQUI.PRO.v75d.apk
  ```
- **O que o cliente reclamou da v75b (com os textos vermelhos nas fotos):** (a) grupos **"grosso demais"** e **"sumindo as laterais"**; (b) LUPA/3 PONTINHOS **laranja mas "grosso demais"** (o destaque funcionou ✓ — "APARECE EM TODOS AGORA"); (c) o **conteúdo parou** de atualizar e deu `OK 24H` ✓, **mas a guia de TV ainda baixa toda abertura**; (d) o **foco** continua voltando pro primeiro (ele testou a **v75b**, que ainda não tinha a memória — e pediu que valha **dentro dos catálogos** também).
- **O que a v75d muda:** `selector_list_categories` = **1dp branco no normal / 4dp laranja + fundo claro no focado** (fino e sem comer as laterais); `selector_vod_layout` virou uma shape **inline de 3dp** (some o "grosso" da lupa/3 pontinhos **sem mexer nos cards**, que continuam com o `shape_vod_layout_focused` de 6dp); portão de **24h para a guia de TV** no `ImportEPGActivity.onCreate` (usa `last_full_sync`; só age quando a Intent **não tem ação** — ATUALIZAR e guia vencida continuam baixando na hora); **memória de foco estendida para dentro dos catálogos** — `onPause`/restauração também em `VodActivityNewFlowSubCategories` (`vod_sub`), `VodActivityNewFlowSecondSubCategories` (`vod_sub2`) e `SeriesActivitNewFlowSubCat` (`series_sub`).
- `tvaquiRestorePos` agora faz **sempre** `scrollToPosition(pos)` e **reafirma o foco 400 ms depois** — era o ganho de foco da janela que jogava o foco para o canto superior da tela (o sintoma exato que ele descreveu).
- ⚠️ Se ainda faltar, o ajuste fino seguinte é a espessura (2dp) e/ou a **opção 2** que ele ofereceu: nenhuma moldura no normal e só a selecionada acende.

## ⛔ ATENÇÃO — v75c E v75d ESTÃO QUEBRADAS (06/10/2026) — NÃO USAR

O cliente instalou a **v75d** e **o app passou a falhar**: ao entrar em TV/FILMES/SÉRIES a **tela fica branca e volta** para a home (com foco em TV AO VIVO) e em **SÉRIES o app fechou**. A guia de TV também baixou de novo.
**Conclusão:** foi o **código de memória de foco** que eu adicionei (os `onPause` novos + as chamadas de `tvaquiSavePos`/`tvaquiRestorePos` nas activities e os 2 métodos/1 campo novos no `TvaquiFix`) — provavelmente o classe não verifica/passa no aparelho. **Descartar v75c e v75d.**
(O portão da guia de TV na v75d tinha também um **erro de polaridade meu**: `if-eqz` no lugar de `if-nez` na checagem da ação da Intent — por isso baixou de novo.)

**Rollback bom:** **`TVAQUI.PRO.v75e.apk` (123 / 7.5e)** — reconstruída a partir da árvore da **v75b** (a que funcionava), trocando **só os 3 drawables** (molduras finas: 1dp branco normal / 4dp laranja no focado; lupa/3 pontinhos com 3dp).
- MD5 `b4e015acde307ced123533e69796201c` · SHA-256 `bf141bd02b32a1ac4f925f0c2615bbcd4af5116c359331fe5759fa2579b8ac94`
- 76 238 516 bytes — **exatamente o tamanho da v75b** ⇒ o **dex é o da v75b** (o código que funcionou); só as molduras mudam.
- Conferido: **0** ocorrências de `tvaquiSavePos`/`tvaquiRestorePos`/`tvaqui_epg_go` nessa árvore; `res` 3 873; certificado ✓; 5 partes refazem o APK ✓.
- O portão de 24h do **conteúdo** continua funcionando (`OK 24H`); o da **guia de TV** não está nesta build (o EPG volta a baixar toda abertura).

**Próximo passo obrigatório:** reimplementar a memória de foco **uma tela por vez**, compilando e conferindo entre cada passo, para isolar o defeito — e só então entregar de novo.

**CAUSA do "a seleção não fica laranja" (achada em 06/10/2026):** a linha **interna** (`@id/rl_list_of_categories`) tem `android:duplicateParentState="true"`, e o pai dela é o `@id/testing` — um `RelativeLayout` que **nunca recebe foco**. Ou seja: o estado `state_focused` **nunca chega** ao fundo que a linha desenha; o foco vive na view externa (`rl_outer`) ou num filho, e o item focado desenhava o estado **normal** (branco). Era por isso que, desde a v72T, **nenhuma** versão conseguiu deixar o grupo selecionado colorido — só a lupa/3 pontinhos (que não usam esse desenho).
**Correção (v75f):** o atributo `android:duplicateParentState="true"` foi **removido** das 6 variantes do item de grupo (`layout` / `layout-land` / `layout-large-land` × `live` / `vod`). Assim cada uma das duas views usa o **próprio** estado e o item focado acende por inteiro (a de fora **ou** a de dentro, tanto faz).

**`TVAQUI.PRO.v75f.apk` (124 / 7.5f)** — base v75b (código idêntico: mesmo tamanho 76 238 516) + molduras finas + a remoção acima.
- MD5 `eacc0eff8571a47c8a3b2b1dff74a844` · SHA-256 `8cc82de64671b51c9a387f9a75849aa7a2576544d4e0abb9b1d79aa676f86d78`
- `res` 3 873 ✓ · `7.5f` no manifesto ✓ · 5 partes refazem o APK ✓ · **nenhum smali tocado** (só resources) — o risco de crash é o mesmo da v75b, que funcionou.

### RESULTADO DO TESTE DA v75a (cliente, 05/10/2026 — com fotos)

| Item | Resultado |
|---|---|
| LUPA / 3 PONTINHOS com laranja | ❌ **NÃO apareceu** — na foto ampliada os dois ícones estão brancos puros ⇒ a travessia do `TvaquiFix.a(Toolbar)` **não alcança** os ícones |
| Grupo selecionado | ❌ o laranja ficou em **TODOS** os grupos, o tempo todo ("selecionou tudo o tempo todo") |
| Download 1x por dia | ❌ baixou tudo em 3 aberturas seguidas; Toast **`GATE: ultimo sync ha 106h`** |
| Visor da versão | ✅ `v:7.5a` confirmado (instalou a certa) |
| App abre / botões da home / SÉRIES "ÚLTIMOS ASSISTIDOS" | ✅ seguem OK |

**Pedidos novos do cliente:**
1. Grupos: **brancos como estavam** (sem laranja permanente) e **só o selecionado** com destaque — *"o mesmo tipo de seleção dos cards das capas de filme e séries"*.
2. **Ao voltar de um grupo, a seleção deve ficar onde estava** (hoje volta no primeiro) — vale para os grupos **e** para TV/FILMES/SÉRIES da tela inicial.

### O QUE A v75b CORRIGE

**1. Grupos (laranja em todos) — CAUSA ENTENDIDA E CORRIGIDA.**
- Causa: `res/drawable-v21/selector_list_categories.xml` era um **`<ripple>`**. O `RippleDrawable` estende `LayerDrawable`: **todos** os `<item>` são camadas desenhadas e os atributos `android:state_*` **não escolhem** qual desenhar. Como o preenchimento escuro é recuado pelo padding do traço, o **traço do item "focado" aparecia em TODAS as linhas**. (É também por isso que antes todas ficavam brancas.)
- Correção: os **dois** `selector_list_categories` (base e `-v21`) viraram um **`<selector>` de verdade**: normal = fundo `live_text_box` + traço **branco 6dp** (como estava); focado = fundo `live_text_box` + traço **laranja 6dp** (`@color/colorPrimaryFocus` = `#fffc8210`) — o **mesmo estilo dos cards de capa** (`shape_vod_layout_focused`).
- ⚠️ Vale para todos os lugares que usam esse desenho (grupos de CANAIS/FILMES/SÉRIES, botões `<` `>` do player, listas de gravações, MULTI-TELA): voltam ao visual anterior.

**2. LUPA / 3 PONTINHOS — resolvido por caminho declarativo (sem travessia).**
- A travessia em código (`TvaquiFix.a(Toolbar)` → recursão → `setBackground`) já falhou **5 vezes** e o teste do laranja permanente provou que **não alcança** os ícones (o código *está* no APK assinado — conferido no `classes2.dex`). Foi abandonada como mecanismo.
- Agora o destaque vem do **tema**: `<item name="actionBarItemBackground">@drawable/selector_vod_layout</item>` no `AppTheme` — cobre a **LUPA** (`ActionMenuItemView`, via `actionButtonStyle`) **e** os **3 PONTINHOS** (botão de overflow, criado por código, via `actionOverflowButtonStyle`). Reforço em `res/layout/abc_action_menu_item_layout.xml` (mesmo `android:background`).
- `selector_vod_layout` = **só** o item `state_focused` → `shape_vod_layout_focused` (traço **laranja 6dp**, sem fundo): **nada** quando não está focado, moldura laranja quando o controle chega nele.
- O laranja permanente do desenho de runtime do `TvaquiFix` foi **removido** (estado padrão agora transparente) — se a travessia acertar em algum aparelho, o efeito também fica só no foco.

**3. Download 1x por dia — 3 correções no carimbo.**
- **`apply()` → `commit()`** nas 2 gravações do carimbo (`ImportStreamsActivity$c` e `onDestroy`): `apply()` grava em disco de forma assíncrona e o box fraco pode matar o processo antes do arquivo ser gravado — o carimbo se perdia.
- **Gravação já no 1º passo concluído**: novo método `ImportStreamsActivity->tvaquiMarkSync()` chamado nos **12** pontos que incrementam o contador `h`. Antes o carimbo só era gravado no fim (ou no `onDestroy`); se o box interrompia a importação, **nada** era gravado e ele reimportava tudo na abertura seguinte. Auto-recuperação preservada: se **nenhum** passo completar (servidor fora), ninguém grava e ele tenta de novo.
- **Usuário vazio não derruba mais o prazo**: no portão, se o `last_full_sync_user` gravado estiver vazio, a comparação com o `username` atual é considerada igual (antes um valor vazio forçava reimportação para sempre).
- Análise do `GATE: 106h`: `now - last = 106h ≥ 24h` ⇒ o portão **está correto**, ele baixou porque **o carimbo não estava sendo atualizado** (a última gravação bem-sucedida foi ~4,4 dias antes).

**4. Toasts de diagnóstico desligados** (o `show()` foi comentado; o código ficou):
`PAINEL:` (`a/d`), `MENU OK (borda ligada)` (`TvaquiFix`), `SELECIONADO (foco chegou)` (`TvaquiFocus`), `RECENTE: N itens` e `RAMO -4 (recém-assistidos)` (`SeriesActivitNewFlowSubCat`).
**MANTIDOS de propósito** (são a medição do item 3): **`GATE: ultimo sync ha Xh`** e **`OK 24H - sem atualizar`**.

### O QUE PEDIR NO TESTE DA v75b
1. **Grupos** (CANAIS, FILMES, SÉRIES): as linhas voltaram a ter **moldura branca** e **só a selecionada** fica **laranja**?
2. **LUPA e 3 PONTINHOS**: com o foco neles, aparece a **moldura laranja**? E some quando o foco sai?
3. **Download**: abrir o app **2 vezes seguidas** →
   - na 2ª, o Toast diz **`GATE: ultimo sync ha 0h`** (ou poucas horas) **e não baixa**?
   - apareceu **`OK 24H - sem atualizar`**?
   - se continuar baixando, anotar o **X exato** de cada abertura.
4. Apareceu algum Toast estranho durante o uso? (foi tudo desligado, menos os 2 do portão)

### v75c (121 / 7.5c) — MEMÓRIA DA SELEÇÃO (pedido 2 do cliente) — IMPLEMENTADO

**Causa raiz (levantada na árvore, não é chute):**
- Os 3 adapters de grupo **já têm** campo de posição de foco (`LiveAdapterNewFlow->m`, `VodAdapterNewFlow->n`, `SeriesAdapterNewFlow->n`) usado pelo `onBindViewHolder` — mas ele é gravado **só no clique**, começa em **0**, e no **TV AO VIVO** o adapter é **recriado no `onResume`** (`LiveActivityNewFlow$a`), então o campo volta a 0. (Os campos são `private` e ficam em outro pacote — não dá para escrevê-los de fora do adapter.)
- Em FILMES/SÉRIES o adapter sobrevive, mas o `RecyclerView.requestFocus()` do `AsyncTask` (`VodActivityNewFlow$b:170/254`, `SeriesActivtyNewFlow$b:128`) e o `onBind` rodando antes de o item ser anexado fazem o foco cair no 1º filho.
- Na **tela inicial**, o bloco que lê `tvaqui_section`/`last_section` no `TvaquiFix.run()` fica atrás do **modo 4**, e o `onResume` só postava o **modo 0**; o modo 4 só era alcançado pela cadeia `0→1→4`, que **retorna antes** em layout saudável (`TvaquiFix.smali:278-280`) ⇒ em layout normal **a preferência nunca era aplicada**. Sobrava a leitura do `onCreate`, que roda antes da árvore ser medida ⇒ foco no `live_tv`.

**O que foi feito (só código; nenhum recurso novo):**
1. `TvaquiFix` ganhou 2 métodos estáticos + 1 campo estático (`tvaquiArmado`):
   - `tvaquiSavePos(RecyclerView, String)` — grava em `tvaqui_focus` o **índice do item focado** (`getFocusedChild` + `getChildAdapterPosition`) e **arma** a chave;
   - `tvaquiRestorePos(RecyclerView, String)` — só age se a chave estiver **armada pela mesma tela** (evita abrir a lista já num item antigo em entrada fria). Foca o **item exato** via `LayoutManager.findViewByPosition(pos)`; se ele não estiver visível, faz `scrollToPosition(pos)` + foco atrasado (`TvaquiFocus`, que já tem retry).
2. **`onPause` novo** em `LiveActivityNewFlow` (`"live"`), `VodActivityNewFlow` (`"vod"`) e `SeriesActivtyNewFlow` (`"series"`), todos chamando o `onPause` do super.
3. **Restauração**: em `VodActivityNewFlow.onResume` e `SeriesActivtyNewFlow.onResume` (no fim do fluxo normal, depois de `:cond_2`) e em `LiveActivityNewFlow$a`, no fim do `onPostExecute` (depois do `setAdapter` — o TV recria o adapter).
4. **Tela inicial**: `NewDashboardActivity.onResume` agora também posta **`TvaquiFix` modo 4** (900 ms) — é o bloco que lê `tvaqui_section`/`last_section` e devolve o foco na última seção usada (fallback TV AO VIVO) — e ainda agenda o modo 5 como 2ª tentativa.

**Roteiro de teste da v75c:** ir até o 5º grupo em CANAIS, FILMES e SÉRIES → entrar → voltar (BACK): o foco deve voltar **no 5º** e não no 1º. Na home, focar **SÉRIES** → entrar → voltar: deve voltar em **SÉRIES**. E em **entrada fria** (abrir o app e entrar numa lista) o foco deve cair no **1º item** (prova que o "armado" funciona).

**Ainda em aberto (não é bloqueio):** por que a travessia do `TvaquiFix.a(Toolbar)` não alcança os `ActionMenuItemView` mesmo com o código presente no APK assinado. Ficou sem uso agora que o destaque vem do tema.

---

## 🚀 (histórico) PRÓXIMA JANELA — v75a, 04/10/2026

**Onde estamos:** versão entregue **`TVAQUI.PRO.v75a.apk` (119 / 7.5a)**.
- MD5 `56c8047e6db231360fcf991d95cb716c` · SHA-256 `489bb7749ba4b74df5f2411324823da74ef67ef76d881e5ffb6359b3530ef466`

**O que já está CONFIRMADO funcionando (testes do cliente):**
- ✅ app abre (sem fechar) · ✅ botões da tela inicial · ✅ SÉRIES "ÚLTIMOS ASSISTIDOS"
  marca o 1º item · ✅ tela inicial lembra a última seção (implementado na v72V)

**O que a v75a mudou (vs v75):**
1. **Grupos**: contorno do selecionado agora é **LARANJA** (`@color/colorPrimaryFocus`
   = `#fffc8210`, 8dp) — o cliente disse que o branco "misturava" e pediu "de outra
   coisa". (arquivos: `res/drawable/selector_list_categories.xml` e `-v21`)
2. **LUPA/3 PONTINHOS**: contorno **LARANJA** 3px **permanente** (sempre visível) +
   5px no foco. Objetivo duplo: dar o destaque pedido E diagnosticar — se o laranja
   aparecer, o código alcança os ícones; se não aparecer, a travessia não chega neles.
3. **Re-aplicação atrasada**: nova classe `TvaquiMenu` (Runnable) + `postDelayed 500ms`
   dentro de `TvaquiFix.a(Toolbar)` — re-aplica o destaque depois de o menu ser
   populado (o menu pode montar os filhos assíncronos).
4. **Download em toda abertura**: no portão de 24h, o caso "relógio para trás"
   (`now-last < 0`, comum em box sem bateria de RTC) agora **PULA** a atualização em
   vez de forçar. (antes forçava a cada abertura)

**1º passo da nova janela:** pedir o resultado do teste da **v75a**:
1. Aparece um contorno **LARANJA** na LUPA e nos 3 PONTINHOS? (o teste decisivo)
2. O **grupo selecionado** tem moldura **LARANJA**?
3. **Download**: abrir o app 2x seguidas → baixou na 2ª? Apareceu o Toast
   **"GATE: ultimo sync ha Xh"** → **qual X?** (X negativo = relógio para trás, agora
   pula; X 0-23 sem baixar = prazo OK; X ≥ 24 = janela diária normal)

**Fotos do cliente (texto):** `FOTOS-CLIENTE-04-10.md` · **Auditoria:** `AUDITORIA-v72.md`

**Pendências conhecidas:**
- Remover os Toasts de diagnóstico antes do release (lista: "SELECIONADO", "MENU OK",
  "RECENTE: N itens", "RAMO -4", "GATE: ultimo sync ha", "OK 24H - sem atualizar").
- Se a lupa ainda não mostrar NADA (nem o laranja): a travessia do `TvaquiFix.a(Toolbar)`
  não está alcançando os `ActionMenuItemView` — investigar por que (talvez o menu
  `menu_search_text_icon` não seja o inflado nessa tela, ou o Toolbar usado é outro).

**Ferramentas e caminhos (recompilar):**
- árvore: `_trabalho\decoded` · apktool: `_trabalho\apktool_2.9.3.jar`
- assinar: `_trabalho\uber-apk-signer-1.3.0.jar` + `mykey.keystore` (alias `tvaqui`,
  senha `[SENHA-REMOVIDA]`)
- verificação: `_trabalho\check_touched.py`, `_trabalho\check_wide.py`, `_trabalho\axmlver.py`;
  descompilar o assinado e conferir (ex.: `_trabalho\verify75`)
- 5 partes + comando `cat` do Termux · **versão sempre nova** (próxima: 120 / 7.5b)

**REGRAS DO CLIENTE (relembrar):**
- `public.xml` idêntico e `res` com **3 873** arquivos (não criar recurso novo)
- operações largas **sempre em par dentro de `.locals`** — rodar `check_wide.py` no
  método exato; **revisar a polaridade de `if-eqz`/`if-nez`** (a v72Z quebrou por 1 char,
  a v72X quebrou por registrador largo)
- conferir SEMPRE dentro do APK **assinado** · não mexer em layout/aparência sem pedido

**LIÇÕES DESTA SESSÃO (erros MEUS que quebraram builds):**
- v72W: `isLaidOut` trocado por `getWidth>0 && getHeight>0` (E em vez de OU) → botões
  da tela inicial sumiram no box fraco. **No TvaquiFix, preservar semântica exata.**
- v72X: `const-wide/32 v7` em método `.locals 8` → par v7,v8 inexistente → VerifyError.
- v72Z: `if-nez` em vez de `if-eqz` ao checar ação nula → NPE → fechava.

---


## 🔄 HANDOFF — estado em 04/10/2026 (fim de tarde, 7ª rodada) — para continuar em nova janela

### Versão ATUAL entregue: `TVAQUI.PRO.v72Y.apk` (versionCode 116 / versionName 7.4Y)
- MD5 `5f99d46225c3825640653032fb4bfbd8`
- SHA-256 `43de1564ef5eecfb98c381c971518ad1fa7dc593d5eeca7a7b61d3e870f6115d`
- 76 238 516 bytes · certificado `cdc87c7f…22076` ✓ (instala por cima)

#### O que a v72Y corrige (vs v72X)
- **[CRÍTICO — CRASH na abertura] a v72X quebrava ao abrir a tela de atualização.**
  Causa: no Toast de diagnóstico do portão de 24h, usei `const-wide/32 v7, 0x36ee80`
  num método com `.locals 8` — a constante LARGA grava no par **v7,v8** e **v8 não
  existe** → `VerifyError` → o app fechava. **Corrigido:** o divisor agora usa o par
  `v4,v5` (`const-wide/32 v4, 0x36ee80` + `div-long/2addr v6, v4`). Verificado no
  APK assinado: **zero** registradores `v8+` no onCreate.
  ⚠️ LIÇÃO DUPLA: (1) operações largas SEMPRE em par dentro de `.locals`; (2) rodar o
  verificador de par-largo no MÉTODO EXATO antes de compilar (a v72X não foi
  verificada nesse ponto — foi o descuido).
- **Mantidos da v72X:** botões da tela inicial restaurados (semântica OU do resgate)
  e os 2 Toasts do portão ("IMPORT-GATE: Xh" / "OK 24H - sem atualizar").

#### Verificações da v72Y (dentro do APK **assinado**)
- `versionCode 116 / versionName 7.4Y` ✓ · certificado ✓
- `public.xml` **idêntico** ✓ · 3 873 arquivos ✓
- onCreate do ImportStreamsActivity conferido no assinado: `const-wide/32 v4, 0x36ee80`
  + `div-long/2addr v6, v4` + `long-to-int v6, v6` ✓, **0 registradores v8+** ✓
- auditoria de pares largos no onCreate: 0 problemas ✓
- 5 partes refazem o APK idêntico ✓



### Versão ATUAL entregue: `TVAQUI.PRO.v72X.apk` (versionCode 115 / versionName 7.4X)
- MD5 `561fa993f361bf2042e0bb6cadb9446d`
- SHA-256 `77e89d1d492c68c61ed880d20a2eb93e5d562cf0941aecad982e7f0f4d48f0a3`
- 76 238 516 bytes · certificado `cdc87c7f…22076` ✓ (instala por cima)

#### O que a v72X corrige (resultado do teste da v72W pelo cliente)
1. **[CRÍTICO — CAUSA ENCONTRADA] Botões da tela inicial sumiram de novo (ATUALIZAR DNS/VPN/etc).**
   Foi REGRESSÃO MINHA da v72W: ao substituir `isLaidOut()` (API 19+) por
   `getWidth()>0 && getHeight()>0`, mudei a semântica de **OU** para **E** — no box
   fraco do cliente o container tem largura>0 mas altura==0 na hora do resgate,
   então o `TvaquiFix` passou a **desistir sem consertar a tela**. Restaurada a
   semântica OU (`getWidth()>0 || getHeight()>0`) — igual ao original. **Os botões
   voltam.** (Isso também travava o teste da LUPA e deixava o foco "sempre no sininho".)
2. **[DIAGNÓSTICO — regressão "baixa tudo a cada abertura"]** o portão de 24h existe e
   está intacto (verificado), mas para saber POR QUE ele não está segurando no box do
   cliente, a v72X mostra 2 Toasts no portão:
   - **"IMPORT-GATE: Xh desde o ultimo"** — aparece quando o app está DENTRO do prazo
     de 24h (X = horas desde o último sync completo). Se mostrar 0h e mesmo assim
     baixar → o carimbo não está sendo gravado (importação não termina no box fraco /
     rede bloqueada). Se mostrar 23h → é a janela diária normal.
   - **"OK 24H - sem atualizar"** — aparece quando o app PULA a atualização.
   **PEDIR AO CLIENTE:** anotar qual Toast aparece (e o valor de X) ao abrir o app.

#### Histórico imediato (v72W)
- v72W (114/7.4W) = v72V + correções da auditoria de 5 agentes (ver `AUDITORIA-v72.md`).
  Achado principal: o `aput` que usava a cor como índice de array → a borda da LUPA
  nunca era criada (corrigido). Mas a v72W introduziu a regressão do `isLaidOut`
  (item 1 acima) — **corrigida na v72X**.
- ⚠️ LIÇÃO: ao "melhorar" código de resgate (TvaquiFix), preservar a SEMÂNTICA exata
  (OU vs E). O TvaquiFix conserta boxes fracos — qualquer mudança nele é de altíssimo
  risco e exige teste do cliente imediato.

#### Verificações da v72X (dentro do APK assinado)
- `versionCode 115 / versionName 7.4X` ✓ · `public.xml` idêntico ✓ · 3 873 arquivos ✓
- strings "IMPORT-GATE:" e "OK 24H" e "SELECIONADO" presentes no dex ✓
- 5 partes refazem o APK idêntico ✓



### Versão ATUAL entregue: `TVAQUI.PRO.v72W.apk` (versionCode 114 / versionName 7.4W)
- MD5 `c2f20592efdbb820428f4b8c522ad3b5`
- SHA-256 `96f1c1da2b75823c6632d30ea8f16b0a7152284584d7faba034a63d6c3261327`
- 76 238 516 bytes · certificado `cdc87c7f…22076` ✓ (instala por cima)

#### v72W = v72V + CORREÇÕES DA AUDITORIA (5 agentes: Auditor, Sênior, Microsoft, Meta, Google)
Detalhe completo em **`AUDITORIA-v72.md`**. Resumo do que mudou:
1. **[CRÍTICO] LUPA: `aput` usava a COR (0x22ffffff) como índice do array** →
   exceção silenciosa → a borda nunca era criada na v72V. **Era a causa da LUPA
   nunca funcionar.** Corrigido (`const/4 v1, 0x0` antes dos `aput`).
2. **[MAIOR] filtro de classes da recursão INVERTIDO** (pintava borda em views
   errados) → corrigido (não-contém → próximo check; contém → setBackground).
3. **[MAIOR] Toast "SELECIONADO" com guarda invertida** (`if-ge`→`if-lt`).
4. **[MAIOR] Toast "MENU OK" com guarda invertida** (`if-eqz`→`if-nez`) — nunca disparava.
5. **[MENOR] Toast "RAMO -4" incondicional** → movido para dentro do ramo "-4".
6. **[UX] escala dos ícones 1.25→1.125** (evita corte no ActionMenuView).
7. **[UX] StateListDrawable ganhou estado padrão transparente**; desfoco não limpa o fundo.
8. **[Compat] `isLaidOut()` (API 19+) trocado por `getWidth/getHeight > 0`** (pré-existente).
9. **[UX] foco atrasado com retry único (+300ms)** se os itens ainda não chegaram.
10. **Google CONFIRMOU:** fluxo "-4" das SÉRIES é consistente (o() enche U → q() exibe U);
    `ActionMenuItemView` não re-aplica fundo (o setBackground pega); o foco da LUPA cai no
    `SearchAutoComplete` interno (alcançado pela recursão); `onPrepareOptionsMenu` roda a cada
    `invalidateOptionsMenu`. **Com o item 1 corrigido, a LUPA deve finalmente acender.**

#### O que pedir ao cliente no teste da v72W
1. LUPA / 3 PONTINHOS: navegar até eles → **Toast "SELECIONADO (foco chegou)"** (máx. 2x) e
   **borda branca**? Em CANAIS, FILMES e SÉRIES.
2. Toast **"MENU OK (borda ligada)"** aparece 1x ao abrir cada tela? (confirma o código rodando)
3. SÉRIES "ÚLTIMOS ASSISTIDOS" → Toast **"RECENTE: N itens"** (qual N?) e o 1º item selecionado?
4. Tela inicial volta na última seção usada?
5. Download: 1ª abertura do dia ou todas? (para fechar a análise da "regressão" — a lógica de
   24h está intacta; ver AUDITORIA-v72.md, seção Sênior)
6. Grupos: destaque forte (fundo azulado + borda branca 6dp) aprovado?

#### Regras e avisos
- `public.xml` **idêntico** ao da v72R ✓ · `res` com **3 873** arquivos ✓ (nenhum recurso novo)
- 5 partes refazem o APK idêntico ✓
- verificador de registrador: só os 77 avisos pré-existentes (reuso de `p1`) ✓
- **Próxima versão SEMPRE nova** (115 / 7.4X)
- Toasts de diagnóstico DEVEM ser removidos antes do release final (lista em AUDITORIA-v72.md)



### Versão ATUAL entregue: `TVAQUI.PRO.v72V.apk` (versionCode 113 / versionName 7.4V)
- MD5 `59666302454a732a4f81de0f4893a097`
- SHA-256 `187c853a5c51f7f6e1a79a67534d093e5cd149063bd4b5f69460452621591604`
- 76 238 516 bytes · certificado `cdc87c7f…22076` ✓ (instala por cima)

#### O que a v72V mudou (vs v72U)
1. **LUPA/3 PONTINHOS — destaque reforçado + DIAGNÓSTICO POR TOAST.**
   - Borda de 4px + fundo semi-transparente branco (0x22ffffff) — mais visível.
   - `TvaquiFocus.onFocusChange` agora mostra **Toast "SELECIONADO (foco chegou)"**
     (máx. 2x por processo) — **se o Toast NÃO aparecer ao navegar até a lupa, o
     foco NÃO está chegando nela** (problema de rota do direcional, não de desenho).
   - `TvaquiFix.a(Toolbar)` mostra **Toast "MENU OK (borda ligada)"** (1x) — confirma
     que o código de borda rodou.
   - ⚠️ **O QUE PEDIR AO CLIENTE NO TESTE:** anotar quais dos 2 Toasts aparecem ao
     entrar em FILMES e navegar até a lupa/3 pontinhos. Isso fecha o diagnóstico.
2. **GRUPOS — destaque BEM mais forte (pedido: "mudar a cor do selecionado").**
   - Nos 2 `selector_list_categories` (base + v21): focado agora = **fundo
     `#ff54626f` (azul-acinzentado claro) + borda branca de 6dp**. Antes era
     3dp e fundo igual ao normal.
3. **SÉRIES "ÚLTIMOS ASSISTIDOS" — fluxo auditado linha a linha + diagnóstico.**
   - **AUDITORIA COMPLETA DO FLUXO "-4"** (ver abaixo) — a cadeia de carregamento
     está CORRETA no app original (doInBackground→o() enche U; onPostExecute→q()
     mostra U via EpisodeDetailAdapter). O elo que faltava (chamar `a()` no ramo
     "-4") já foi ligado na v72U e está MANTIDO.
   - `q()` agora: Toast **"RECENTE: N itens"** + foco atrasado no 1º cartão.
   - O ramo "-4" mostra Toast **"RAMO -4 (recém-assistidos)"**.
   - ⚠️ **SE O TOAST DISSER "RECENTE: 0 itens"**: o box do cliente NÃO TEM séries
     assistidas recentemente (a lista está vazia mesmo) — aí o defeito é outro
     (tela vazia sem mensagem). Se disser "N itens" e mesmo assim não navegar,
     o problema é o foco da EpisodeDetailAdapter.
4. **TELA INICIAL — LEMBRA A ÚLTIMA SEÇÃO (pedido do cliente).**
   - `NewDashboardActivity.onClick` grava o id clicado em prefs
     **"tvaqui_section"/"last_section"**.
   - `onCreate` e o `TvaquiFix.run()` (etapa 4) agora restauram o foco na seção
     salva (com `findViewById` + `requestFocus`), com fallback para TV AO VIVO.
5. **REGRESSÃO "baixa tudo a cada abertura" — AUDITADO, lógica INTACTA.**
   - Conferido no código: o portão de 24h em `ImportStreamsActivity.onCreate`
     (prefs `tvaqui_sync`/`last_full_sync`/`last_full_sync_user`, janela
     `0x5265c00`) e a gravação em `ImportStreamsActivity$c` (`if-lez`, grava quando
     o contador > 0) **estão intactos desde a v72K — nada meu tocou nisso**.
   - Causas prováveis do sintoma (pedir ao cliente observar): (a) a janela de 24h
     expirou de verdade entre as sessões de teste; (b) box fraco interrompe a
     importação antes do fim → o carimbo NÃO é gravado (por projeto: falha parcial
     re-tenta na próxima abertura); (c) relógio do box sem RTC volta para trás →
     forçar re-importação (também por projeto).
   - **PEDIR AO CLIENTE:** "o download aparece na PRIMEIRA abertura do dia, ou em
     TODAS as aberturas do mesmo dia?" — a resposta distingue (a) de (b)/(c).

#### Verificações da v72V (dentro do APK **assinado**)
- `versionCode 113 / versionName 7.4V` ✓ · certificado correto ✓
- `public.xml` **idêntico** ao da v72R ✓ · `res` com **3 873** arquivos ✓
- strings dos Toasts + `tvaqui_section` + `TvaquiFocus` presentes no `classes2.dex` ✓
- os 2 `selector_list_categories` do assinado com `state_focused`+`stroke` ✓
- verificador de registrador: 29 métodos alterados checados; os 77 avisos são todos
  pré-existentes (reuso de `p1`, padrão do app) ✓
- 5 partes refazem o APK idêntico ✓

#### AUDITORIA DO FLUXO "ÚLTIMOS ASSISTIDOS" DE SÉRIES (registro completo)
- Grupo "-4" (título `R.string.recent_watch` 0x7f110331) é criado em
  `SeriesActivtyNewFlow.b()` (linha ~772) e o clique é tratado por
  `SeriesAdapterNewFlow$5` → abre `SeriesActivitNewFlowSubCat` com
  `category_id="-4"`.
- Em `SeriesActivitNewFlowSubCat.b()` (público): x="-4" → `t.d("-4")` =
  `SELECT ... WHERE paent_id='-4'` → **vazio** → ramo `:cond_4/:cond_5`: layout
  `activity_vod_new_flow_subcategories` (0x7f0d0070), `VodSubCatAdpaterNew` vazio,
  `d=true`. **AQUI estava o elo solto: ninguém chamava `a()`** (o launcher do
  recém-assistidos — código morto). v72U ligou; v72V mantém + Toast.
- `a()` → `$a("get_recent_watch")` → doInBackground case 2 → `pswitch_0` →
  `o()` (enche `U`, retorna "get_recent_watch") → onPostExecute case 2 →
  `pswitch_0` → `l(static)` → `q()` → `U` não vazio → `EpisodeDetailAdapter(U)` +
  setAdapter. (Os pares estavam CORRETOS — a falha era só o chamador.)
- `q()` em lista vazia → `a(false)` → esconde grid e mostra `tvNoStream`.
- Itens: `EpisodeDetailAdapter` usa `vod_grid_layout`/`vod_linear_layout` (focáveis ✓).



### Versão ATUAL entregue: `TVAQUI.PRO.v72T.apk` (versionCode 111 / versionName 7.4T)
- MD5 `c1a68e302c8835155c36b664f1be19a0`
- SHA-256 `c782ba28c78a20cf9cdd21ad50bf7c73251a87b36dc8acdb7b857da3cb94e850`

#### RESULTADO DO TESTE DO CLIENTE (v72T, 03/10 noite)
- ✅ **Bordas dos grupos**: FUNCIONARAM ("gostei das bordas dos botões")
- ✅ FILMES continua OK · ✅ visor `v:7.4T`
- ❌ **LUPA / 3 PONTINHOS**: continua SEM NENHUM destaque (nem borda, nem nada) —
  em CANAIS, FILMES e SÉRIES, em todos os lugares.
- ❌ **SÉRIES "ÚLTIMOS ASSISTIDOS"**: pior do que se pensava — o direcional **não
  move NADA** (cima/baixo/lados/OK não fazem nada); **só o mouse** navega.
- 🆕 **PEDIDO NOVO**: ao voltar para a tela inicial do app, **sempre volta no TV AO
  VIVO** — cliente quer que **lembre a última seção** (FILMES/SÉRIES/CANAIS/EPG) e
  volte nela selecionada.

#### DIAGNÓSTICO (feito nesta rodada, 3ª rodada de auditoria manual)
**LUPA / 3 PONTINHOS:**
- `TvaquiFix.a(Toolbar)` usa `setBackground` com `StateListDrawable` — está correto,
  mas pode ser **perdido** se o menu for **reconstruído depois** (o menu tem
  `media_route_menu_item` com MediaRouteActionProvider; o Cast pode invalidar o menu
  e o `ActionMenuPresenter.updateMenuView` recria os `ActionMenuItemView`).
- `View.setForeground` (usado na v72S) só existe no API 23+ — provável causa no box.
- **PLANO v72U:** criar `TvaquiFocus` implementando **também** `OnFocusChangeListener`
  (foco → `setBackground`(borda) + `setScaleX/Y 1.2`; perda de foco → limpa e volta
  a escala 1.0). Ligar o listener em **todo filho focável** da `ActionMenuView` e
  chamar `TvaquiFix.a(toolbar)` também num `onPrepareOptionsMenu` **novo** em cada
  atividade (re-aplica se o menu for recriado). Assim o destaque é aplicado **no
  evento de foco**, não no momento da inflação — não há como "perder".

**SÉRIES "ÚLTIMOS ASSISTIDOS" — CAUSA RAIZ ENCONTRADA (a lista NUNCA carrega):**
- O grupo "-4" abre `SeriesActivitNewFlowSubCat` com `category_id="-4"`.
- Em `b()` (público), o ramo do "-4" faz `t.d("-4")` = `SELECT * FROM
  iptv_movie_category WHERE paent_id='-4'` → **vazio** → cai no ramo `:cond_4`:
  troca o layout para `activity_vod_new_flow_subcategories` (0x7f0d0070), monta
  `VodSubCatAdpaterNew` **com lista VAZIA** e marca `d=true`.
- **Quem deveria carregar o recém-assistidos é o método público `a()`** (lança o
  `$a` com `"get_recent_watch"` → `onPostExecute` → `d()` → `SeriesAdapter` + foco)
  — **mas `a()` NÃO É CHAMADO DE LUGAR NENHUM** (código morto!). Resultado: a tela
  fica com a grade VAZIA — nada para o direcional focar/clicar (sintoma exato do
  cliente: "não move nada, OK não faz nada, só o mouse navega").
- **PLANO v72U:** no ramo `:cond_4` de `b()`, se `x` for "-4", **chamar `a()`**.
  Isso carrega a lista de verdade; o foco atrasado (`TvaquiFocus`) então seleciona o
  1º item. Também reforçar `TvaquiFocus`: se o alvo for `RecyclerView` com filhos,
  focar o **filho 0** em vez do container.
- ⚠️ Por que o FILMES funciona: em `VodActivityNewFlowSubCategories` o ramo do
  recém-assistidos é o `i()`, que **monta o VodAdapter com a lista real** — o
  equivalente a `a()` está ligado lá. A série é que tinha o elo solto.

**TELA INICIAL SEMPRE VOLTA NO TV AO VIVO:**
- Causa: `TvaquiFix.run()` (linha ~183) e `NewDashboardActivity` (linha ~4620)
  chamam `requestFocus()` no `LinearLayout` da seção TV AO VIVO (é o resgate das
  etapas 4/5 do TvaquiFix). **PLANO v72U:** guardar a última seção num
  `SharedPreferences` e pedir foco nela em vez do TV AO VIVO. (Ver campos das seções
  em `NewDashboardActivity` — mapeamento ainda por fechar.)

### Verificações obrigatórias antes de entregar (relembrar)
- `public.xml` idêntico e 3 873 arquivos em `res` (não criar recurso novo)
- verificador de registrador nos métodos alterados (`_trabalho\check_touched.py`)
- conferir dentro do APK **assinado** (descompilar com apktool)
- 5 partes + comando `cat` do Termux
- **versão SEMPRE nova** (próxima: 112 / 7.4U)
- prévias: `PREVIA-1-FILMES-LUPA-E-GRUPO.png` e `PREVIA-2-SERIES-ULTIMOS-ASSISTIDOS.png`
  (script `_trabalho\previa.py`)

---

### Versão anterior: `TVAQUI.PRO.v72S.apk` (versionCode 110 / versionName 7.4S)
- MD5 `167a71cf994c3bede6c59d9e6c113b42`
- SHA-256 `5ac6cf4f195867c9f7aada5f9a8b04f626e3cb39fde8f4039b9501225e8e0a8d`
- **Resultado do teste do cliente em 03/10:** grupos com **borda branca OK** ✔ ·
  LUPA/3 PONTINHOS **sem borda** ✘ · SÉRIES "ÚLTIMOS ASSISTIDOS" **sem seleção** ✘ ·
  FILMES OK ✔ · visor `v:7.4S` OK ✔ · versão antiga (v72R) — tentativa de foco em
  `SeriesActivtyNewFlow$b` (caminho errado) e `setForeground` (só API 23+).

### Versão anterior: `TVAQUI.PRO.v72R.apk` (versionCode 109 / versionName 7.4R)
- MD5 `20c832959ad06130adda6c451f7ab860`
- SHA-256 `8094fadb3247048fee13d51392422a374c6d42328b128326fd4dd8fe06d7eae2`
- Rollback bom: `TVAQUI.PRO.v71.apk` (versão original, 76 238 516 bytes)
- Árvore de trabalho: `_trabalho\decoded` (apktool 2.9.3 em `_trabalho\apktool_2.9.3.jar`,
  assinador `_trabalho\uber-apk-signer-1.3.0.jar`, chave `mykey.keystore` alias `tvaqui`
  senha `[SENHA-REMOVIDA]`)
- Versões anteriores arquivadas em `_trabalho\_anterior-v72*`
- **`_trabalho\verifyS`** = APK assinado da v72S já descompilado (para conferência)
- Scripts de apoio criados: `_trabalho\axmlver.py` (lê `versionCode`/`versionName` do
  manifesto binário do APK assinado) e `_trabalho\check_touched.py` (verificador de
  registrador focado só nos métodos alterados)

### ✅ RESOLVIDO E COMPROVADO PELO CLIENTE
1. **Causa raiz do "baixa tudo toda vez"**: condição invertida (`if-gtz`) ao gravar o
   carimbo em `ImportStreamsActivity$c` → corrigido (`if-lez`) + gravação no
   `onDestroy` + prazo de **24 h** (`0x5265c00`). Cliente confirmou: **entra rápido**.
2. **Segundo plano**: foi implementado (v72M) e depois **REMOVIDO a pedido do cliente**
   (v72R) — o download em segundo plano **derrubava TV Box fraco** (erro "fechar o app"
   na abertura). Decisão do cliente: **baixar na frente, 1x por dia**, e no resto do dia
   abrir rápido sem atualizar. **NÃO reimplementar segundo plano.**
3. **Foco (parcial)**: FILMES OK — inserido `RecyclerView;->requestFocus()` depois de
   `setAdapter` em `SeriesActivtyNewFlow$b.smali` e `VodActivityNewFlow$b.smali`.
4. Visor de versão na tela inicial (`v:7.4R`), descendo para a linha de baixo;
   aviso de servidores (diagnóstico) **desligado**; "Resumo"→"Continuar";
   botões da série → `TRAILER` / `FAVORITOS`; texto `ÚLTIMOS ASSISTIDOS`.

### ⚠️ PENDENTE (ordem de prioridade)

**1. ✅ FEITO na v72S (FALTA O TESTE DO CLIENTE) — SÉRIES: foco no 1º item em "ÚLTIMOS ASSISTIDOS"**
- **CAUSA ENCONTRADA:** essa tela **não** passa pelo `SeriesActivtyNewFlow$b` (que já
  estava corrigido). O grupo "ÚLTIMOS ASSISTIDOS" das SÉRIES é a tela
  **`SeriesActivitNewFlowSubCat`**, que recebe `get_recent_watch` e monta a lista no
  método **`d()`** — e ali **nunca havia `requestFocus()`**. É exatamente por isso que
  só esse grupo falhava e os outros não.
- **CORREÇÃO:** `RecyclerView;->requestFocus()` depois do `setAdapter` em
  `SeriesActivitNewFlowSubCat.d()` (recém-assistidos) e `.e()` (todos),
  `VodActivityNewFlowSubCategories.i()` (recém-assistidos de filmes) e nos 3 pontos de
  `VodActivityNewFlowSecondSubCategories`.

**2. DESTAQUE VISUAL DE SELEÇÃO — 3 pontos (cliente pediu explicitamente)**
*(todos são o mesmo tipo de defeito: falta/é fraco o estado visual `state_focused`)*

**(2a) ✅ FEITO na v72S (FALTA O TESTE DO CLIENTE) — LUPA e 3 PONTINHOS com borda BRANCA**
- **ONDE:** apenas nos **2 ícones do topo** — a **LUPA** (busca) e os **3 PONTINHOS** (opções).
- **IGUAL nas 3 telas:** **CANAIS**, **FILMES** e **SÉRIES** (dentro e fora de grupo).
- O foco **CHEGA** neles: dando **OK a busca abre** ✓ (o visual de "selecionado" não era desenhado).
- **CLIENTE CONFIRMOU NAS FOTOS (03/10): nesses 2 ícones NÃO APARECE NADA quando o foco
  chega — nem "vem para frente", nem borda, nem qualquer indicativo. Zero.**
- **CAUSA APURADA (não é regressão nossa):** no API 21+ o fundo desses itens é
  `abc_action_bar_item_background_material`, que é um **ripple** com
  `?android:colorControlHighlight`. O tema do app usa `colorAccent1 = #ff9e9494`
  (cinza) — então **sempre existiu** um efeito de foco, mas fraco demais para se ver
  na TV. Ou seja: não foi nenhuma versão nossa que apagou.
- **CORREÇÃO (v72S):** método novo `TvaquiFix.a(Toolbar)` — monta um
  `StateListDrawable` com `state_focused` e `state_pressed` apontando para um
  `GradientDrawable` **transparente com traço branco de 2px**, e aplica via
  `View.setForeground` na árvore do `Toolbar`. Ligado depois do `inflateMenu` em
  `VodActivityNewFlow`, `LiveActivityNewFlow`, `SeriesActivtyNewFlow`,
  `VodActivityNewFlowSubCategories` (2 ramos), `VodActivityNewFlowSecondSubCategories`
  e `SeriesActivitNewFlowSubCat`. **Não cria recurso novo** (não mexe em `public.xml`
  nem na contagem de `res`).
- ⚠️ **LIMITE CONHECIDO:** `setForeground` no `View` só existe do **API 23 (Android 6)**
  para cima — abaixo disso o método sai sem tocar em nada (de propósito, para não
  quebrar). **Se o TV Box do cliente for Android 5/6/7 e a borda não aparecer, a
  próxima tentativa é aplicar no FUNDO (`setBackground`) em vez do foreground.**

**(2b) ✅ FEITO na v72S (FALTA O TESTE DO CLIENTE) — GRUPOS com BORDA BRANCA**
- **CAUSA RAIZ (dupla, e nenhuma é regressão nossa):**
  1. `res/drawable-v21/selector_list_categories.xml` (usado pelo Android 5+, que é o
     caso do box do cliente) era **só um `<ripple>`, sem `state_focused`** → o foco
     não desenhava absolutamente nada.
  2. No caminho antigo (`res/drawable/selector_list_categories.xml`), o foco apontava
     para `shape_list_categories_focused`, cujo `solid` é `live_box_focus` =
     **`#96000000`** — exatamente **o mesmo preto** do fundo normal
     `live_text_box` = `#96000000`. Ou seja, mesmo quando "funcionava", **a cor não
     mudava nada**.
- **CORREÇÃO:** os dois arquivos ganharam `state_focused` com
  `<stroke android:width="3.0dip" android:color="@color/white" />` (**borda branca**).
  No `-v21` o item focado ficou **dentro do `<ripple>`** (o efeito de toque continua).
  **Sem criar arquivo/recurso novo** → `public.xml` idêntico, `res` segue com 3 873.
- **ONDE APARECE:** os grupos usam `layout_vod_new_flow_list_item.xml` (FILMES),
  `layout_live_new_flow_list_item.xml` (CANAIS) e variantes em `layout-land` /
  `layout-large-land`. **SÉRIES** usa o mesmo par de desenhos → deve ficar igual.
- ⚠️ **Se ainda não aparecer em alguma das 3 telas**, o próximo passo é conferir se
  aquela tela usa outro drawable de fundo (procurar o `android:background` do
  `rl_outer` no layout daquela tela).

**(2c) ANTES DE MEXER em qualquer um:** comparar com `TVAQUI.PRO.v71.apk` para saber se é
**regressão nossa** ou defeito antigo (o cliente disse "antes não era assim").
Fotos do cliente já recebidas em 03/10/2026 (TV AO VIVO, TOP10 +ASSISTIDOS, GLOBOS CAPITAIS).

**3. App VOLTA SOZINHO para a tela inicial** ao sair de **VPN / configurações**.
O cliente esclareceu que é a **tela inicial do APP** (não a do Android) — pode ser o
comportamento normal dessas telas (finish()). Gravidade menor que o item 4.
(NÃO confundir com o item 4 abaixo.)

**4. (já mitigado na v72R) Box fraco não abria** — erro com opção "fechar o app" durante
a abertura/atualização de entrada. Resolvido ao remover o download em segundo plano.

**5. Opção A — contagem dos grupos zerada** (fazer a tela adotar a lista contada `z`
mesmo quando o laço sai cedo em `LiveActivityNewFlow.a()Z`). Ainda não implementado.

### REGRAS DO CLIENTE (não esquecer)
- **NÃO alterar layout/aparência** sem ele pedir; sempre conferir `res/values/public.xml`
  **idêntico** e a contagem de arquivos de `res` (3 873) entre builds.
- **Registrador**: SEMPRE rodar o verificador de escrita de 64 bits antes de assinar
  (com `.locals N` os parâmetros começam em `vN` — já quebrou o app uma vez).
- **Auditoria com agentes antes de compilar** quando a mudança for de lógica.
  ATENÇÃO: agentes **falham** ao ler arquivos smali gigantes (`MultiUserAdapter`,
  `ImportStreamsActivity`, `SeriesActivtyNewFlow`) — nesses casos, auditar manualmente.
- Sempre entregar em **5 partes** + comando `cat` do Termux.
- Verificar SEMPRE **dentro do APK assinado** (descompilar e conferir).


## 📋 NOVAS PENDÊNCIAS (cliente, 01/10/2026 — tarde)

1. **Baixar a GUIA DE TV (EPG) em segundo plano, 1x por dia, e continuar mesmo com o
   app FECHADO.** Pedido explícito. Vários TV Box fracos **fecham o app** quando o
   download roda em segundo plano — a solução certa no Android é um
   **agendador + serviço em primeiro plano** (`WorkManager`/`JobScheduler`), que roda
   periodicamente e **sobrevive ao app fechado**. Quando o cliente entrar, já está pronto.
2. **APP FECHA SOZINHO ao sair da VPN / das configurações**, voltando para a tela
   inicial. O cliente **já viu isso em clientes com a versão anterior** — provável
   **exceção (crash)**. INVESTIGAR. (No box de teste o VPN ainda não está configurado.)
3. **Trocar o texto** `ASSISTIDOS POR ÚLTIMO` → **`ÚLTIMOS ASSISTIDOS`**
   (recurso `recent_watch`, `values-pt/strings.xml` ~linha 640).
4. **Foco: SÉRIES ainda não seleciona o 1º item** (FILMES já corrigido na v72Q).
   Ao entrar em SÉRIES nada fica selecionado; o direcional "aparece à direita".
   Investigar: pode haver **outro caminho** de `setAdapter` para séries, ou os
   cartões de séries **não são focáveis** no layout.

### Confirmações do cliente (v72P)
- ✅ `v:7.4P` **desceu para a linha de baixo** do vencimento
- ✅ A **lista de servidores não aparece mais**
- ✅ Botão **VPN abre**
- ✅ **Foco corrigido em FILMES** (v72Q): "ASSISTIDOS POR ÚLTIMO" e o grupo AÇÃO já
  selecionam o **primeiro item** com o direcional


## v72K — a CAUSA RAIZ do "baixa tudo toda vez" (30/09/2026)

**Descoberto por auditoria.** O app tem um carimbo de controle em `tvaqui_sync`
(`last_full_sync` + `last_full_sync_user`) para pular a importação. Mas a
gravação em `ImportStreamsActivity$c` estava com a **condição invertida**:

```
if-gtz v1, :cond_2      ← "if-gtz" = se MAIOR que zero, PULA
```

Como o contador é o de **passos concluídos**, isso significa que o app gravava o
carimbo **apenas quando NADA foi baixado** — ou seja, lembrava das **falhas** e
**esquecia dos sucessos**. Resultado: toda abertura depois de uma importação
bem-sucedida **rebaixava tudo de novo**. Era esse o defeito, e não o aparelho.
**Correção aplicada (v72K):**

1. `ImportStreamsActivity$c`: `if-gtz` → **`if-lez`** (grava quando houve
   download) — a polaridade certa.
2. `ImportStreamsActivity.onDestroy`: passou a **também** gravar o carimbo quando
   o contador é maior que zero. Assim uma importação **parcial** (que não chega
   ao último passo) fica **lembrada** e não rebaixa tudo na próxima abertura.
3. Janela do prazo: **12 h → 24 h** (`0x2932e00` → `0x5265c00` = 86.400.000 ms),
   a pedido do cliente (1x por dia).
4. **ATUALIZAR DNS** e os menus "Atualizar" continuam **forçando na hora** —
   eles levam o marcador `tvaqui_auto` / `tvaqui_auto_dns` e passam por outro
   caminho, que ignora o prazo.

Auto-recuperação preservada: se a importação **não trouxer nada** (contador 0),
**ninguém grava o carimbo** → ele tenta de novo na próxima abertura.

## 🎯 PRÓXIMO ALVO: foco do controle (anotado em 01/10/2026)

**Sintomas relatados pelo cliente:**
1. Tela **"ASSISTIDOS POR ÚLTIMO"** (recém-assistidos): o **direcional do controle não
   navega** — só funciona com mouse. Num TV Box isso **inutiliza a tela**.
2. Na **lista de episódios** de uma série, ao entrar **o 1º episódio não fica marcado**:
   o foco cai **à direita** em vez de cair no episódio 1.

**O que já foi apurado:**
- O título dessas telas vem do recurso `R.string.recent_watch`
  (`ASSISTIDOS POR ÚLTIMO`, id `0x7f110331`).
- No código, esse id é usado em **`SeriesActivtyNewFlow`** (linha ~780) e
  **`VodActivityNewFlow`** (linha ~774) — são essas as telas de recém-assistidos.
- As telas NORMAIS (FILMES/SÉRIES) navegam bem com o controle; o problema é
  específico do modo **recém-assistidos**. Logo, a diferença está no **adapter /
  configuração de foco da tela**, não no layout do cartão
  (`vod_grid_layout.xml` / `vod_linear_layout.xml` são os mesmos usados nas telas
  que funcionam).

**CAUSA PROVÁVEL ENCONTRADA (01/10/2026) — comparação de foco:**

| Tela | Chamada de foco |
|---|---|
| `SettingsActivity` (navega bem) | `CardView;->requestFocus()` ✓ |
| `SeriesDetailActivity` (navega bem) | `TextView;->requestFocus()` ✓ |
| `ViewDetailsActivity` (navega bem) | `TextView;->requestFocus()` ✓ |
| **`SeriesActivtyNewFlow`** (recém-assistidos) | **só `PopupWindow;->setFocusable`** ✗ |
| **`VodActivityNewFlow`** (recém-assistidos) | **só `PopupWindow;->setFocusable`** ✗ |

As duas telas de recém-assistidos **não chamam `requestFocus()` em nenhum item**.
Sem foco, o **direcional do controle não tem onde agir** — e o **mouse funciona**
porque clique não depende de foco. Isso explica o sintoma e explica por que o
MESMO layout de cartão funciona nas telas de FILMES/SÉRIES.

**CORREÇÃO A FAZER:** após o adapter receber os dados (no `onPostExecute`/`notifyDataSetChanged`),
pedir foco no **primeiro item** da grade — mesmo padrão das telas que funcionam.
Para o episódio: a lista de episódios deve pedir foco no **item 0** (hoje o foco cai à direita).


- Comparar a configuração de foco da tela de recém-assistidos com a da tela normal:
  procurar `setFocusable`, `setDescendantFocusability`, `setItemsCanFocus`,
  `requestFocus` e o uso de `RecyclerView`/`ViewPager` no modo recente.
- Para o episódio: verificar se o adapter da lista de episódios chama
  `requestFocus()` no item 0 (ou qual item recebe o foco inicial).

## ⚠️ PENDÊNCIAS APROVADAS PELO CLIENTE (não esquecer)

1. **Atualização em SEGUNDO PLANO** (etapa maior, combinada para depois da
   correção da importação): entrar na tela inicial **na hora** e baixar o
   conteúdo por trás, em vez de segurar o cliente na tela de download.
   É a solução definitiva para a espera.
2. **Contagem dos grupos zerada (Opção A)** — fazer a tela adotar a lista
   contada (`z`) mesmo quando o laço de contagem sai cedo em
   `LiveActivityNewFlow.a()Z`. Falta implementar com auditoria.
3. **Prazo da importação: 24 h (1x por dia)**, com o botão **ATUALIZAR DNS** e
   os menus "Atualizar" **forçando na hora** (eles já passam por outro caminho,
   que ignora o prazo).

---

## O sintoma

- Em TV Box de **clientes** (redes variadas), o "Aguarde" demora muito ao
  **adicionar usuário** e também ao **clicar no usuário salvo**.
- No celular testado **na rede do revendedor**, é rápido.
- Conclusão: o problema é a **rede do cliente** (caminho até o painel/servidores
  do fornecedor), não o aparelho.

## Causas confirmadas no código (v71)

### 1. Chamada ao painel do fornecedor com timeout longo

- Ao adicionar usuário, o app faz **um único POST** `action=dns` (levando `m=gu`,
  usuário e senha) para `https://sm.wctvapp.com/aq/api/home.php?`
  (constante em `a/g$a.smali`).
- Timeout: **30s conectar + 30s ler** (`a/a.smali`, `const-wide/16 v3, 0x1e`).
- O "Aguarde" (`MultiUserActivity.b()` mostra / `c()` fecha) **só fecha quando
  essa resposta chega**.
- Rede lenta ou bloqueada até o painel = "Aguarde" de até ~60s.

### 2. Seleção de servidor em fila

- A resposta `su` (14 servidores, separados por vírgula) é guardada **inteira,
  numa string só**, na preferência `url`/`serverUrl` (`a/f.smali`).
- O app tenta **um servidor por vez, na ordem da lista** (o primeiro sempre
  primeiro). Servidor morto/lento na frente = espera antes do próximo.
- É a pendência anotada como *"~12s de aguarde — endereço morto tentado primeiro"*.

## O que foi entregue

- **`TVAQUI.PRO.v72E.apk`** — versionCode **96**, versionName **7.4E** — versão
  de **DIAGNÓSTICO**. Mostra um Toast **`PAINEL: Xms`** com o tempo da chamada ao
  painel. Instala **por cima** da v71 (mesma chave). **Não distribuir.**

> **Histórico (importante):** a primeira tentativa desta instrumentação saiu como
> `v72D` (95) e **derrubava o app** — erro meu: usei o registrador `v5/v6` com
> `.locals 6`, e nesse caso o **v6 é o próprio `p0` (o `this`)**, então a leitura
> do tempo sobrescrevia o `this` e o Android recusava a classe. Corrigido na
> `v72E`: o cálculo foi para um método auxiliar (`tm`) e **nenhuma escrita em
> registrador de parâmetro** é feita. Os arquivos da v72D foram movidos para
> `_trabalho\_quebrado-v72D` — **não usar**.

## RESULTADO DO TESTE NO CLIENTE (30/09/2026)

- **`PAINEL:871ms`** → a chamada ao painel respondeu em **menos de 1 segundo**.
  **O painel NÃO é o gargalo.** Era o principal suspeito e foi **descartado com
  dado**, não com opinião.
- Em seguida o app mostrou **"URL do servidor inválido"** (HTTP 404 no
  `player_api.php`) e **"Erro de rede! Verifique sua conexão"** (falha de conexão).

### O que isso significa

- O app **tenta todos os servidores da lista, um por um**, e só mostra o erro
  quando a lista **acaba** — confirmado em `MultiUserAdapter.b(ArrayList,String)`:
  se ainda sobrar servidor, ele chama o próximo.
- Logo, no box do cliente **todos os servidores falharam**. Testados daqui
  (conexão limpa), **8 dos 14 respondem HTTP 200** no `player_api.php`; 2 dão 404,
  1 não resolve e 3 dão outros erros.
- Conclusão: **a internet do cliente está bloqueando/interceptando os servidores
  de IPTV.** O painel (site comum) passa; os servidores não.
- **É isso que explica o "Aguarde" longo:** cada servidor bloqueado segura o app
  até o tempo limite antes de ir para o próximo — percorrer a lista inteira leva
  minutos.

### Testes baratos que confirmam (e podem resolver)

1. Trocar o **DNS do TV Box** para `1.1.1.1` (ou `8.8.8.8`) e tentar de novo —
   se a operadora bloqueia por DNS, resolve na hora.
2. Ligar o box no **hotspot do celular** e tentar — se funcionar no celular e não
   no Wi-Fi da casa, o bloqueio está confirmado.

### Saídas quando o bloqueio se confirma

- **Rota VPN do app** (o recurso já existe; falta o servidor de proxy real — é a
  VPS Oracle ainda pendente) ou VPN no roteador do cliente.
- Trocar DNS / operadora.

## v72F — melhorias no login (30/09/2026)

Com o diagnóstico fechado (painel rápido; servidores bloqueados/recusados no
cliente), foram feitas duas mudanças:

1. **Mostrar o servidor na tela** — a cada tentativa aparece o aviso
   **`Servidor: <endereço>`**, para ver qual servidor está em uso e qual é
   recusado. (`MultiUserAdapter.dg`, chamado dentro de `MultiUserAdapter.c`)
2. **Lista mais rápida** — o tempo limite de **conexão** do cliente de API caiu de
   **10s para 5s** (`miscelleneious/b/d.a(Context)`, `const-wide/16 v4, 0x5`).
   Cada servidor que não responde deixa de segurar o app por 10s: a lista roda
   cerca de **2× mais rápido**.

Versão: **v72F — versionCode 97 / versionName 7.4F**. Não mexe em layout nem em
nada visual — só nos dois pontos acima.

## v72G — correção da trava do download (30/09/2026)

Fecha o "furo" da trava de segurança documentado abaixo.

- **Antes:** o app só saía da tela "Download de canais, Filmes e séries" se
  **nenhum** passo tivesse completado. Se um passo completasse e o seguinte
  travasse, a tela ficava **presa para sempre**.
- **Agora** (`ImportWatchdog.run`): o 1º prazo (150 s) grava o contador de passos
  numa estática `c0`; o 2º prazo (600 s) só sai da tela se o contador **não
  cresceu** desde então. Ou seja: **sai se nada completou** (como antes) **e
  também se parou de progredir**, e **nunca corta** uma importação que está
  andando.
- Correções defensivas vindas da auditoria: `c0` é reiniciada no construtor
  (evita valor obsoleto se a tela for recriada) e o método ficou com `.locals 5`
  — **uma margem de registrador** em relação a `p0` (o descuido que já quebrou o
  app uma vez).

Versão: **v72G — versionCode 98 / versionName 7.4G**. Só código: nenhum layout,
imagem ou texto mudou (`public.xml` idêntico, 3873 arquivos de `res` iguais).

## A tela "Download de canais, Filmes e séries" (trava de segurança)

Conferido no código (`ImportWatchdog.smali` + `ImportStreamsActivity`):

- Dois prazos são agendados ao entrar nessa tela: **150 s (2min30)** e **600 s (10 min)**.
- O disparo é **condicional**: o watchdog lê o contador de passos concluídos
  (`ImportStreamsActivity.e(...)`) e só age **se ele estiver zerado** — ou seja,
  só tira o cliente da tela se **nenhum** passo respondeu. Aí mostra
  *"O servidor não respondeu. Abrindo o aplicativo."* e vai para a tela inicial.
- **Consequência prática:** se **um** passo já completou e outro trava, o prazo
  não age — a tela segue esperando (cada chamada tem seu próprio tempo limite de
  leitura). É por isso que "esperar 2min30" nem sempre resolve.
- Melhoria possível para depois: trocar o critério de "contador zerado" por
  **"não houve progresso nos últimos X segundos"** — pega travamento no meio sem
  cortar importação que está andando devagar (é a regra que o
  `GUIA-APPS-SMARTERS.md`, seção 9o, recomenda).

## Como fechar a causa (aguardando teste no cliente)

Instalar a v72E no TV Box do cliente e anotar o valor `PAINEL: Xms`:

| Valor | Significado | Correção |
|---|---|---|
| < 2s | painel rápido; o gargalo é importação/servidor | atacar importação + seleção de servidor |
| 10–30s | rede lenta até o painel do fornecedor | cachear DNS / não travar a tela / painel próprio |
| 30s+ (timeout) | bloqueio da operadora | timeout menor + rota VPN |

## Correção da documentação

- O recurso **"3 endereços + espelhos"** descrito no `ESTADO-ATUAL.md` **NÃO
  existe na v71** (não há campo `SEM` nem campo `espelhos` no smali). É etapa
  futura, não "já escrito e compilando".

## Ferramentas prontas (para recompilar)

- apktool 2.9.3 — `_trabalho\apktool_2.9.3.jar`
- uber-apk-signer 1.3.0 — `_trabalho\uber-apk-signer-1.3.0.jar`
- `mykey.keystore` (alias `tvaqui`; senha no `ESTADO-ATUAL.md`)

## Verificação feita na v72E (APK assinado)

- Versão: `versionCode 96`, `versionName 7.4E` ✓
- Certificado: `cdc87c7fc63d66bdae181beffe950ea488932561d0df7e7a755a1cca82f22076` ✓
- `public.xml` idêntico ao da v71 (nenhum ID de recurso mudou) ✓
- Instrumentação presente no APK **assinado** (`PAINEL:`, `tm`, campo `k`) ✓
- **Verificador de registrador**: 0 problemas (na v72D acusava
  `iget-wide v5` com `.locals 6` — par `v5,v6` invadindo `p0`; é exatamente a
  causa do crash) ✓
- 5 partes refazem o APK idêntico ✓

### Como evitar esse erro de novo

O compilador **não avisa** quando uma escrita de 64 bits (`iget-wide`,
`move-result-wide`, `const-wide`, `sub-long`…) invade o par de registradores dos
parâmetros: com `.locals N`, os parâmetros começam em `vN`. Regra prática:
**toda operação larga deve usar registradores `< .locals`**, e o ideal é isolar o
cálculo num método auxiliar próprio (como o `tm`), onde `p0`/`p1` só são lidos.
