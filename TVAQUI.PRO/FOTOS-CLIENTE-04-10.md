# FOTOS DO CLIENTE — 04/10/2026 (descrição em texto, para janelas sem leitura de imagem)

**Por que este arquivo existe:** as fotos que o cliente mandou no WhatsApp em 04/10/2026
foram analisadas numa janela que conseguia ver imagens. As janelas seguintes (modelos sem
entrada de imagem) **não conseguem abrir os arquivos** — então a descrição fica registrada
aqui, em texto, para não perder o contexto.

**Origem da descrição:** (a) o que o **cliente escreveu** junto de cada foto — fonte
primária e verificável; (b) o que **sabemos do código/layouts** do app (IDs e arquivos
dentro do APK). O que for dedução está marcado como **[dedução]**.

Arquivos originais (5 fotos, WhatsApp, 04/10/2026): 16.21.43 · 16.22.10 · 16.26.11 ·
16.28.56 · 16.31.14 (1599×899 px, JPEG).

---

## Foto 1 — 16:21:43 — CANAIS, lista de um grupo ("GLOBOS CAPITAIS")
- **Legenda do cliente:** *"parte de canais ainda sem selecção na lupa e nos 3 pontinhos
  mesmo estando selecionados... nada visual"*
- **Tela [dedução a partir do código]:** `LiveActivityNewFlow` (tela TV AO VIVO) com um
  grupo aberto — cabeçalho com o nome do grupo e setas `<` `>`, lista de canais numerada
  (ícone de canal + nome), e no canto superior direito **a LUPA (busca)** e os
  **3 PONTINHOS (opções)**. No lado direito, o mini-player/EPG dos programas do canal.
- **O que a foto comprova:** o foco estava em um dos ícones do topo e **nada** aparecia
  (nem borda, nem brilho) — o defeito que o cliente chama de "nada visual".
- **Layout do item de grupo:** `res/layout/layout_live_new_flow_list_item.xml`, fundo
  `@drawable/selector_list_categories`.

## Foto 2 — 16:22:10 — TV AO VIVO, tela de GRUPOS (grade de 2 colunas)
- **Legenda do cliente:** *"parte de grupos de canais... mesma coisa la em cima... nada de
  visual pra lupa e 3 pontinhos... e quando esta selecionado o grupo ainda nao tem nenhum
  outro destaque a nao ser trazer o botao pra frente... gostaria de um contorno em led ou
  algo que modifique o botao selecionado..."*
- **Tela [dedução]:** `LiveActivityNewFlow` na tela de grupos, em 2 colunas de linhas
  (MOSTRAR TODOS, PROGRAMACAO, A FAZENDA 18, GLOBO SUDESTE, GLOBO CENTRO OESTE,
  GLOBO NORTE, SBT+ / FAVORITOS, JOGOS DO DIA, GLOBOS CAPITAIS, GLOBO SUL,
  GLOBO NORDESTE, SBT, MOSTRAR TODOS), cada linha com ícone, nome e contagem + seta `>`.
  Cabeçalho "TV AO VIVO", lupa e 3 pontinhos no topo direito.
- **O que a foto comprova:** (1) o grupo selecionado **só "vem para frente"** (sem contorno
  visível); (2) a lupa e os 3 pontinhos sem nenhum destaque. **Pedido explícito:** contorno
  tipo "LED" ou algo que mude o botão selecionado.
- **Causa técnica encontrada depois:** a borda era desenhada no container **externo**
  (`rl_outer`), mas a linha **interna** (`rl_list_of_categories`, fundo escuro opaco)
  cobria a borda → correção na v72Z com `android:duplicateParentState="true"` na linha
  interna (6 arquivos de layout: layout / layout-land / layout-large-land × live / vod).

## Foto 3 — 16:26:11 — SÉRIES → "ÚLTIMOS ASSISTIDOS" (FUNCIONANDO)
- **Legenda do cliente:** *"sobre ultimos assistidos em series agora sim marca a primeira
  opção quando entra no grupo"*
- **Tela [dedução]:** título **"ÚLTIMOS ASSISTIDOS"** no topo; grade de capas de séries
  com botão de play sobreposto; **a primeira capa aparece com contorno (selecionada)**;
  lupa e 3 pontinhos no topo direito.
- **O que a foto comprova:** ✅ **o foco inicial funcionou** — este defeito (item 1 das
  pendências antigas) está resolvido. A causa era o elo solto: o método `a()` (launcher do
  `get_recent_watch`) nunca era chamado no ramo da categoria "-4".

## Foto 4 — 16:28:56 — tela de download ("Download de canais, Filmes e séries")
- **Legenda do cliente:** *"toda vez que abre o app ainda fica atualizando tudo e nao 1 vez
  por dia como falamos... demorou alem do que tava antes agora na segunda vez que abri a
  versao 74y"*
- **Tela [dedução]:** logo TVAQUI.PRO no topo, spinner laranja circular, título
  **"Download de canais, Filmes e séries"**, faixa vermelha e o texto
  *"TVAQUI.TOP! Sua Melhor Tv é Aqui! Estamos carregando novos conteúdos. Por favor,
  aguarde a atualização terminar..."*
- **O que a foto comprova:** a importação completa roda em aberturas que deveriam ser
  puladas pelo prazo de 24h.
- **Observação de código:** o portão de 24h (`ImportStreamsActivity.onCreate`, prefs
  `tvaqui_sync`/`last_full_sync`) **só era aplicado quando a Intent NÃO tinha ação**; as
  aberturas com ação `redirect_*` (usadas para entrar nas seções) **pulavam o portão**.
  Correção na v72Z: ações `redirect_*` passam a **respeitar** o prazo; só os marcadores de
  força (`tvaqui_auto`) importam na hora. Também entrou o Toast
  **"GATE: ultimo sync ha Xh"** para medir o tempo desde o último sync.

## Foto 5 — 16:31:14 — Tela inicial (confirmações)
- **Legenda do cliente:** *"O app abre? sim · Botões da tela inicial voltaram? sim ·
  IMPORT-GATE: Xh → naoi vi isso nao · LUPA → nao · ÚLTIMOS ASSISTIDOS → mostra seleção
  nos primeiro item agora"*
- **Tela [dedução]:** tela inicial com o logo, data/hora, e a fileira de 6 cartões
  (**TV AO VIVO · FILMES · SERIES · BAIXADOS · EPG · MULTI-TELA**), "Conectado: 1",
  "Expiração: outubro 6, 2026" e o visor de versão **v:7.4Y** (o que confirma que a
  build testada era a v72Y).
- **O que a foto comprova:** ✅ o app abre (a v72X fechava) e ✅ os botões da tela inicial
  voltaram (o sumiço era regressão do resgate da tela, corrigida na v72X/Y).

---

## Resumo do que as 5 fotos provam (estado após o teste da v72Y)
| Item | Situação |
|---|---|
| App abre | ✅ resolvido (v72X fechava) |
| Botões da tela inicial | ✅ resolvido |
| SÉRIES "ÚLTIMOS ASSISTIDOS" 1º item | ✅ resolvido |
| LUPA / 3 PONTINHOS com destaque | ❌ ainda sem visual → tratado na v72Z (borda fina permanente + brilho no foco) |
| Grupos com contorno no selecionado | ❌ só "vem para frente" → tratado na v72Z (`duplicateParentState`) |
| Download 1x por dia | ❌ importa sempre → tratado na v72Z (`redirect_*` respeita o prazo) + Toast de medição |
