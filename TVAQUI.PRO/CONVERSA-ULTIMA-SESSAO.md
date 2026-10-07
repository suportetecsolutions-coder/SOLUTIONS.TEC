# TVAQUI.PRO — resumo da última sessão (conversa "PRO - EDIÇÕES E ACERTOS")

Registrado em 07/10/2026 a partir do trecho copiado pelo cliente. Estado técnico completo em `HANDOFF-06-10-2026.md`.

## Onde a sessão parou

Versão boa: **v75q (versionCode 135)**. Foi proposto atacar, por partes:

- Guia de TV (EPG) baixando toda abertura
- Memória de foco nas telas de subcategoria
- Remover os 3 avisos de diagnóstico (versão limpa para clientes)
- Direcional da tela de novo usuário (depende do raio-x via ADB: `COMO-TIRAR-O-RAIO-X-DA-TELA.md`)
- Hospedar o painel de atualização (lado do cliente)

## Correção sobre o EPG

O portão da guia de TV **já existe e está correto**: pula o download se já baixou nas últimas 24 h, tem trava por sessão e intervalo mínimo de 8 s. A polaridade dos testes foi conferida um a um. O EPG baixa no máximo 1× por dia. Possível melhoria futura: baixar só quando a guia guardada estiver acabando (o ganho depende de o provedor mandar guia de vários dias).

Anotação antiga ainda não resolvida: "~12 s de aguarde causados por um endereço morto tentado primeiro".

## Queixa real do cliente (o que ele quer)

Tempo de abertura:
- Depois da primeira instalação: ~40 a 60 s (atualiza tudo) é o esperado.
- Nas aberturas seguintes: ~5 s.
- Hoje: 40 a 60 s **sempre**, porque atualiza tudo sempre. Já foi corrigido algumas vezes, mas volta a acontecer com as mudanças.

Comportamento desejado:
1. Atualizar **tudo 1× por dia**; depois entrar sem atualizar.
2. Botão **ATUALIZAR DNS**: atualiza apenas o DNS.
3. **3 pontinhos (canto superior direito) → "atualizar canais, filmes e séries"**: reimporta o conteúdo na hora. A opção já existe no menu.

## Causa confirmada (por leitura de código, na sessão anterior)

O carimbo de "já sincronizei hoje" só é gravado quando a importação **dá erro**. Quando termina certo, não grava, e na abertura seguinte o app baixa tudo de novo.

```
invoke-static {v0}, ...->e(...)I     ← contador de ERROS
if-lez v1, :cond_2                   ← se NÃO teve erro, PULA a gravação
```

Os 12 pontos que gravam o carimbo estão todos dentro dos ramos de erro.

A sessão ia confirmar o caminho dos 3 pontinhos antes de mexer quando o limite de uso acabou.

## Pendência de verificação

O HANDOFF (v75b) diz que `ImportStreamsActivity->tvaquiMarkSync()` grava o carimbo no 1º passo concluído, chamado nos 12 pontos que incrementam o contador `h`, e a auditoria da v72V leu o `if-lez` de `ImportStreamsActivity$c` como "contador > 0". A leitura nova diz que o contador é de erros. Só o smali de `ImportStreamsActivity` e `ImportStreamsActivity$c` decide qual está certa.

Correção provável: gravar o carimbo quando a importação termina **sem erro** (mantendo a gravação do usuário e o tratamento de relógio para trás), e conferir que ATUALIZAR e o item dos 3 pontinhos forcem a reimportação.

## Nota de segurança

A senha da `mykey.keystore` foi removida dos documentos deste repositório. Não commitar a keystore nem a senha.
