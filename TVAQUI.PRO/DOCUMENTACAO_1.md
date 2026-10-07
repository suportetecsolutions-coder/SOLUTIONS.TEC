# TVAQUI.PRO — documento de acompanhamento do projeto

Este arquivo existe pra gente nunca perder o fio do que já foi feito, do que
está em andamento e do que só está idealizado — mesmo se a conversa com a IA
se perder algum dia. Eu (a IA) atualizo ele a cada etapa nova.

**Outros documentos do projeto:**
- `NOTAS-TECNICAS.md` — os detalhes técnicos: onde fica cada coisa dentro do
  APK, o contrato da API do painel, o que foi corrigido e como.
- `GUIA-APPS-SMARTERS.md` — guia geral pra mexer em qualquer app da linha
  WHMCS Smarters/IPTV Smarters, não só o TVAQUI.PRO.
- `painel-tvaqui.zip` — o painel próprio (PHP + SQLite).

---

## Como eu trabalho nesse projeto

- Entrega de APK sempre dividida em 5 partes, com o comando de juntar no
  Termux incluído (`cat TVAQUI.PRO.vXX.part00* > TVAQUI.PRO.vXX.signed.apk`)
  — instrução permanente, não preciso perguntar de novo.
- Uso sub-agentes (IA em paralelo) quando fizer sentido pra ajudar no
  processo — por exemplo, verificação dupla de um APK, pesquisa em paralelo
  de alguma solução técnica, revisão cruzada de código antes de entregar.

---

## Feito (concluído e entregue)

- **Painel próprio em PHP + SQLite**, do zero, com abas DNS, Avisos,
  VPN/Rotas, Aparelhos e Senha — substitui o painel de terceiro
  (sm.wctvapp.com) quando o usuário decidir migrar.
- **Correções no app** (antes da v37): guia de programação (EPG) sendo
  apagado sem necessidade, DNS com fallback numa lista inteira em vez de
  travar num servidor só, textos cortados nas telas de atualização, tela Ao
  Vivo desatualizada.
- **v37 (versionName 4.8, versionCode 49)** — última versão entregue:
  - Editor de **DNS em massa** no painel (cola várias linhas de uma vez, com
    opção de substituir a lista inteira).
  - Nova aba **VPN / Rotas** no painel: cadastro de servidores SOCKS5/HTTP
    que servem de caminho alternativo quando o pedido direto ao painel
    falha (bloqueio de operadora, por exemplo).
  - Botão **VPN** no app (do lado do "Atualizar DNS"): liga/desliga (vem
    desligado), modo Automático ou Manual.
  - Decisão de arquitetura: as rotas ficam 100% no painel, **nada de
    endereço de proxy gravado dentro do APK**.
- **v38 (versionName 4.9, versionCode 50)** — tinha um bug grave (ver v39
  abaixo), **não usar**:
  - Tiles **Atualizar DNS** e **VPN** também na tela inicial, focáveis por
    controle remoto de TV Box.
  - Corrigido o travamento de atualização (canais/filmes/séries) depois do
    app ficar tempo em segundo plano — a tela agora sempre termina.
- **v39 (versionName 4.9.1, versionCode 51)** — corrige o fechamento
  sozinho da v38:
  - Os tiles de DNS/VPN da v38 só tinham sido colocados no layout
    retrato/padrão da tela inicial — em paisagem (todo TV Box), o app não
    achava os botões e fechava sozinho logo após o login. Agora os tiles
    estão em **todas** as variantes de layout da tela inicial (padrão,
    paisagem e paisagem-tela-grande), mais uma proteção no código pra
    nunca mais fechar sozinho mesmo se aparecer alguma variante nova no
    futuro.
- **v40 (versionName 4.9.2, versionCode 52)** — tinha dois problemas, **não
  usar** (ver v41 abaixo):
  - Visual: botões DNS/VPN compactos na barra de baixo — mas por um erro no
    layout eles ficaram **invisíveis** (bug corrigido na v41).
  - A correção do "Atualizar DNS" mirou a causa certa (fazer o botão chamar
    o código real de reimportação), mas o disparo automático acontecia cedo
    demais — antes de esse código sequer existir na tela — então continuava
    sem efeito na prática (bug corrigido na v41).
- **v41 (versionName 4.9.3, versionCode 53)** — última versão entregue,
  investigada com agentes de auditoria em paralelo depois que a v40 não
  resolveu na prática:
  - **Botões DNS/VPN voltaram a aparecer**, pequenos e no lugar certo (entre
    "Expiration" e "Conectado: usuário"), em todas as variantes de tela —
    refeitos do zero verificando a estrutura de cada um dos 12 arquivos de
    layout, em vez de repetir a suposição que causou o sumiço na v40.
  - **Causa raiz real do "abrir sozinho não funciona" encontrada e
    corrigida**: o disparo automático (tocar no tile da tela inicial)
    acontecia antes da lista de usuários salvos existir na tela, então a
    correção da v40 nunca era exercida de verdade. Agora o disparo acontece
    no momento certo — depois que a lista já existe — auditado por um
    segundo agente, registro por registro, sem achar problema.
  - **"Atualizar Canais, Radios, Filmes e Séries" do menu do player
    corrigido**: essa opção (usada quando aparece "Erro de reprodução,
    reconecta-se em...") baixava os canais de novo de verdade, mas sempre
    devolvia pra tela inicial em vez de voltar pra Tela Ao Vivo — por isso
    parecia que "não resolvia nada". Agora volta certinho pra Tela Ao Vivo
    já com o conteúdo novo.
  - Ponto em aberto, ainda não confirmado: se o aviso "Dados incorretos.
    Tentar novamente" que apareceu nos últimos prints continua acontecendo
    depois dessa correção — pode ter sido efeito colateral do bug acima.
    Ver `NOTAS-TECNICAS.md` seção 6 (v41) para detalhes.
- **v42 (versionName 4.9.4, versionCode 54)** — última versão entregue,
  achado o que muito provavelmente é a causa real por trás de todo esse
  assunto: o **login automático que roda sozinho toda vez que o app abre**
  (fechar e abrir de novo, do jeito que você realmente usa no dia a dia)
  nunca tinha sido corrigido — só o botão manual e o tile da tela inicial
  tinham ganho a correção nas v40/v41. Agora o login automático também usa
  o gatilho real de atualização, igual aos outros três caminhos. Também
  investigado (não é a causa raiz, mas apareceu nos mesmos prints): o
  player, ao tentar reconectar depois de um erro, sempre usa o mesmo
  endereço de servidor já em cache, nunca busca um novo — se o servidor
  salvo estiver mesmo fora do ar, as 5 tentativas falham em qualquer canal.
  É bem provável que isso se resolva sozinho agora que o login automático
  atualiza o servidor de verdade — mas só o teste confirma.

- **v43 (4.9.5/55)** — **não usar**: nessa versão eu removi, por engano, o
  método que atualiza o DNS (achando que era um método quebrado). Resultado:
  o app travava na tela "Listar usuários" com "Aguarde" eterno e não entrava.
- **v44 (versionName 4.9.6, versionCode 56)** — última versão entregue.
  Aqui o erro de leitura que vinha desde a v40 foi encontrado e corrigido.
  Resumo em português claro: o app tem **duas coisas diferentes** que
  precisam acontecer, **nesta ordem**: (1) atualizar o endereço do servidor
  (o "DNS") e (2) baixar de novo canais/filmes/séries usando esse endereço
  novo. O que sempre funcionou — clicar no usuário salvo — funciona porque
  ao abrir a tela o passo (1) já tinha acontecido, e o clique fazia o (2).
  As versões v40 a v42 disparavam os dois ao mesmo tempo (então o (2)
  baixava usando o endereço **velho** — "entra mas nada reproduz"), e a v43
  removeu o (1) de vez (por isso o app parou de abrir). A v44 devolve o (1)
  e faz o (2) rodar **dentro da resposta do (1)**, ou seja, só depois do
  endereço novo estar salvo — exatamente a ordem do clique manual. Se por
  algum motivo o (2) não puder rodar, o app entra normalmente como antes,
  então não tem como ficar preso sem abrir.

- **v45 (versionName 4.9.7, versionCode 57)** — última versão entregue.
  A v44 resolveu a atualização de conteúdo ao abrir o app (confirmado), mas
  ele ainda parava na tela de usuários esperando você clicar. A v45 faz ele
  entrar direto na tela de TV/Filmes/Séries: ao abrir, atualiza o DNS,
  atualiza o conteúdo e entra sozinho — exatamente o que o clique manual
  fazia, só que sem precisar clicar.

- **v47 (versionName 4.9.9, versionCode 59)** — última versão entregue.
  Aqui a causa raiz foi **provada**, não deduzida. Gerei uma versão de
  diagnóstico que mostrava na tela o endereço que o app ia usar e o erro
  verdadeiro, e ela revelou o seguinte: o app guardava **a lista inteira de
  DNS grudada num campo só** (`limeplycd.shop:80,nepo.zip,gatodeleite.club,
  agoravai.sbs,viarapida.top,solarwaves.top`) e tentava usar isso como se
  fosse o endereço de um servidor — daí o "Erro de rede", que na verdade era
  "não consegui resolver o host solarwaves.top". O clique manual sempre
  funcionou porque ele passa por outro método do app, que **separa a lista,
  usa um servidor de cada vez e vai para o próximo se falhar**. A v47 faz o
  gatilho automático usar exatamente esse mesmo método. Os avisos de
  diagnóstico foram removidos.

- **v48 (versionName 5.0, versionCode 60)** — ✅ **funcionando, confirmado no
  teste.** O app abre, mostra a tela de usuários por um instante, **clica
  sozinho** e entra — e os canais voltaram a abrir rápido.
  O que mudou de abordagem: nas versões anteriores eu mandava o app chamar
  "por fora" os métodos que o clique usa por dentro. Só que esses métodos são
  etapas do meio — eles contam com um preparo que **só o próprio botão do
  clique faz** (guardar usuário e senha, definir o tipo da conta, preparar
  quatro áreas de configuração). Chamando direto, faltava o preparo, e o
  sintoma mudava a cada versão sem nunca resolver. Agora o app **monta o
  próprio botão do clique e aperta ele sozinho** — é exatamente o mesmo
  caminho do seu toque.
  A lentidão de 3–4 s ao abrir canal saiu junto, e pelo mesmo motivo: o
  endereço definitivo de transmissão só é gravado quando o login termina de
  verdade. Como antes ele não terminava, o player usava um endereço
  provisório que dá uma volta a mais na rede. Com o login completando, voltou
  o endereço direto.
  Essa versão foi **auditada antes de virar APK** — e a primeira tentativa
  foi reprovada por quatro problemas (um deles impedia até de compilar).
  Corrigidos e reauditados antes de gerar.

- **v49 (versionName 5.1, versionCode 61)** — ✅ **confirmada pelo TVB em
  10/09/2026.** Dois ajustes.

  **1) Dá para ficar na tela de usuários de novo.** Era o efeito colateral da
  v48: o clique automático disparava toda vez que a tela de usuários aparecia,
  não só na abertura do app. Se você clicasse no ícone de trocar usuário, ou em
  "Sair", a tela abria e já se autoclicava, voltando para TV/Filmes/Séries —
  nunca dava tempo de cadastrar outro usuário e senha. Agora o app marca a
  passagem: quando *ele* abre a tela sozinho (arranque do app, e também o botão
  DNS da tela inicial, que precisa refazer o login depois de trocar o DNS), o
  clique automático acontece; quando *você* abre a tela, ele não acontece e a
  tela fica parada esperando. Além disso o clique automático só pode acontecer
  uma vez por abertura da tela, então voltar de "voltar" também não dispara.

  **2) Configurações já vêm prontas na instalação** (e você pode mudar depois
  normalmente, elas continuam sendo suas):

  | Configuração | Como fica |
  |---|---|
  | Idioma | Portuguese |
  | Mediaplayer Interno | Nativo |
  | Ordenar de acordo com | Padrão |
  | Autoiniciar quando Ligar | desmarcado |

  As duas últimas já eram assim de fábrica no app — conferido item por item,
  não foi preciso mexer em nada, o que é o caminho mais seguro. Idioma e
  decodificador foram ajustados. Vale um teste de reprodução com calma nesta
  versão: "Nativo" faz o app usar o player ExoPlayer em vez do IJK (é o que já
  estava no seu aparelho, mas numa instalação nova antes vinha diferente).

  Auditada por dois agentes antes de virar APK: ambos aprovaram, e a auditoria
  ainda apontou que o botão DNS da tela inicial ficaria sem refazer o login —
  corrigido antes do build.

- **v50 (versionName 5.2, versionCode 62)** — três ajustes finais, nada além
  deles.

  **1) Botões DNS e VPN centralizados** na tela inicial, nas 12 variantes de
  layout (celular, TV Box e TV Box de tela grande). Em 5 delas os botões estavam
  presos dentro da mesma barra do "Expiração:" e do "Conectado: usuário", e ali
  dentro não havia como centralizar na tela — então passaram para uma linha
  própria logo abaixo dessa barra. Nessas cinco o texto "Expiração:" anda alguns
  milímetros para o lado, porque a barra ficou com um item a menos.

  **2) "Autoiniciar quando Ligar" desmarcado.** Descobri por que vinha marcado:
  a tela mostrava a caixinha marcada por padrão, mas o app **nunca iniciava
  sozinho de verdade** — quem manda no boot lê a mesma opção e já vinha
  desligado. Ou seja, a caixinha estava mentindo. O risco real era outro: se
  você salvasse as configurações por qualquer outro motivo, ela gravaria
  "ligado" e aí o app passaria a abrir sozinho ao ligar o aparelho. Agora vem
  desmarcada e coerente.

  **3) Formato de fluxo = MPEGTS (.ts)** em vez de "Padrão".

  **Detalhe importante sobre esses dois últimos:** a auditoria mostrou que, numa
  instalação **por cima** (atualizar sem desinstalar), as configurações antigas
  sobrevivem e os novos padrões não entrariam — você instalaria a v50 e veria
  tudo igual. Por isso o .ts e o autoiniciar são aplicados **uma única vez**,
  mesmo em quem já tem o app: na primeira abertura da v50 eles são corrigidos, e
  a partir daí a sua escolha manda de novo. Então dá para testar atualizando por
  cima, sem precisar desinstalar.

  Auditada por dois agentes antes de virar APK: ambos aprovaram, e a auditoria
  pegou um erro real meu — eu tinha deixado arquivos de backup dentro da pasta
  de layouts, e eles estavam sendo empacotados dentro do APK junto com as
  versões antigas das telas. Removidos antes do build.

---

## Em andamento / depende de uma ação sua

- Testar a v50: (1) tela inicial em celular e em TV Box, conferindo os botões
  DNS/VPN centralizados; (2) Configurações Gerais, conferindo "Autoiniciar
  quando Ligar" desmarcado; (3) Configurações > Formato de fluxo, conferindo
  MPEGTS (.ts) selecionado; (4) abrir alguns canais ao vivo, que é o que muda
  com o .ts.
- Fora isso, nada pendente no aplicativo. A **v49 era a versão boa** e os dois assuntos
  abertos ("abrir e funcionar sozinho" e "configurações de fábrica") estão
  encerrados. Se aparecer algo, o histórico completo está no
  `RELATORIO-INVESTIGACAO-PLAYBACK.md`.
- **Hospedar o painel próprio** (`painel-tvaqui.zip`) e me mandar o endereço
  `https://SEU-DOMINIO/api/home.php?` — com ele eu gero o segundo APK apontado
  para o seu painel (é uma linha só, no `a/g$a.smali`), para os dois rodarem em
  paralelo.
- Conferido nesta rodada: os seis domínios da lista de DNS do painel estão
  todos no ar e com IPv4 — não precisa mexer no painel.

- **Criar a VPS grátis na Oracle Cloud** (conta + máquina + chave SSH) e me
  mandar o IP e a chave privada. Sem isso a função de VPN não tem nenhuma
  rota real pra usar — o botão existe no app, mas fica sem efeito.
- Depois que a VPS existir: eu monto o servidor de proxy nela e cadastro a
  primeira rota na aba "VPN / Rotas" do painel.

### Migração do painel próprio pra hospedagem dele (em andamento, passo a passo)

Ordem combinada, pra executar um de cada vez:

1. Criar o subdomínio na hospedagem (ex.: `painel.seudominio.com.br`) — **em
   andamento agora**, falta saber qual é a hospedagem dele pra dar o passo a
   passo certo.
2. Confirmar que o subdomínio já está resolvendo (propagação do DNS).
3. Enviar o `painel-tvaqui.zip` pra pasta do subdomínio (FTP ou gerenciador
   de arquivos da hospedagem) e extrair lá dentro.
4. Abrir o endereço novo pelo navegador e rodar a primeira instalação/login
   do painel.
5. Cadastrar DNS de teste e conferir que `?action=dns` responde certinho.
6. Avisar o endereço final pra eu trocar a constante no APK (`a/g$a.smali`)
   e gerar uma nova versão do app já apontando pra lá.
7. Testar essa versão nova apontando pro painel próprio antes de distribuir
   pros clientes.

> **Combinado (08/09/2026):** quando essa versão nova (com os ajustes desta
> seção) estiver pronta, vamos gerar **duas versões do app**: uma continua
> apontando pro painel atual (sm.wctvapp.com), e outra é gerada só depois
> que o painel próprio estiver hospedado, apontando pro endereço dele — os
> dois rodando em paralelo, cada um com seus clientes.

### Ajustes pedidos em 08/09/2026 — entregues na v38 (4.9/50)

1. **Feito.** Botões **Atualizar DNS** e **VPN** agora também na tela
   inicial (junto com TV AO VIVO, FILMES e SÉRIES), seguindo o mesmo padrão
   de foco por controle remoto que os tiles originais já usavam (os botões
   antigos da tela de usuários eram soltos, fora da navegação por D-pad —
   por isso não funcionavam bem no controle).
2. **Feito, com um ponto em aberto pra confirmar testando.** A causa do
   travamento pós-segundo-plano foi encontrada e corrigida: a tela agora
   sempre termina, não fica mais girando pra sempre. O que ainda não dá pra
   confirmar sem teste real é se, quando isso acontece, os canais voltam
   atualizados ou ficam com dados antigos — ver aviso detalhado no
   `NOTAS-TECNICAS.md` seção 6. Por favor testar deixando o app em segundo
   plano bastante tempo e reportando o resultado.

---

## Feito — v51 (5.3/63), entregue em 12/09/2026

1. **Feito.** Corrigido o efeito colateral aceito na v50: em `layout-land` e
   `layout-large-land-v4` (telas sem período de trial), a barra de baixo foi
   reorganizada para o texto "Expiration" não deslocar mais.
2. **Feito.** Botão DNS/VPN e tile Ao Vivo agora mudam de aparência quando
   ficam em foco pelo controle remoto (antes só mudavam quando marcados).
3. **Feito.** Rótulo "GRAVADOS" trocado para "BAIXADOS".

**⚠️ Importante sobre a assinatura:** a senha da chave (`mykey.keystore`)
usada até a v50 se perdeu — não estava anotada em lugar nenhum. Foi
necessário gerar uma chave nova para assinar a v51. **Efeito prático: os
aparelhos que já têm alguma versão do TVAQUI.PRO instalada vão precisar
desinstalar o app antigo antes de instalar a v51** (o Android recusa
atualizar por cima quando a assinatura muda). A senha nova foi anotada em
`NOTAS-TECNICAS.md` — **recomendo fortemente guardar essa senha também num
gerenciador de senhas seu**, pra não passar por isso de novo.

---

## Feito — v52 (5.4/64), entregue em 13/09/2026

Repaginação visual da tela inicial, no estilo "Vidro Neon" que você aprovou
nas prévias.

1. **Fundo novo.** Entrou a foto de cortina de teatro que você mandou, no
   lugar da sala de chão amadeirado. Recortada pro mesmo tamanho do original,
   nas 7 versões de densidade que o app usa.
2. **Botões repaginados.** TV AO VIVO, FILMES, SÉRIES, BAIXADOS, EPG,
   MULTI-TELA, DNS e VPN ganharam o visual de vidro translúcido com contorno
   colorido por categoria, e o ícone de cada um ficou na cor da categoria.
   Ao navegar pelo controle remoto, o botão em foco acende com o contorno
   neon.
3. **DNS e VPN alinhados.** Na tela de TV Box/Fire Stick eles agora caem
   exatamente embaixo de SÉRIES e BAIXADOS, como você pediu.
4. **Celular também.** A tela vertical do celular recebeu o mesmo padrão
   visual. Uma diferença: nos três botões grandes de cima (Ao Vivo, Filmes,
   Séries) o vidro é fixo, não acende ao focar — fazer ele acender exigiria
   mexer na peça que controla o toque do botão, e você pediu pra não
   arriscar nada que já funciona. Nos demais botões o brilho ao focar
   funciona normal.

**Nada de lógica foi alterado.** A conferência comparou o app assinado v52
com o v51, arquivo por arquivo: **zero diferença** no código (smali). As
únicas diferenças são os 3 arquivos de layout, os 18 desenhos novos e a
imagem de fundo. Posição, tamanho e área de toque de todos os botões
continuam idênticos aos da v51.

**Instalação:** dessa vez é só instalar por cima — a assinatura é a mesma da
v51, não precisa desinstalar.

**Ainda no estilo antigo:** existem variantes de tela que o app só usa em
configurações diferentes da sua (`..._without_freetrail2` e
`new_dashboard_layout`). Se um dia alguma delas aparecer em algum aparelho,
sai com o visual antigo. Dá pra repaginar essas também numa próxima rodada.

---

## Feito — v53 (5.5/65), entregue em 13/09/2026

Corrige o que ficou errado na v52 e fecha a repaginação da tela inicial.

**O que tinha dado errado na v52:** os botões DNS e VPN encolheram muito e os
seis botões de cima ficaram mais altos e mais baixos na tela. A causa: os
botões antigos usavam uma imagem PNG como fundo, e era essa imagem que
segurava o tamanho do DNS/VPN. Ao trocar por um desenho vetorial, eles
encolheram para o tamanho do texto — e, como a faixa de baixo ficou menor,
sobrou espaço que esticou os botões de cima.

**O que a v53 traz:**

1. **Tamanho correto de volta.** A arte nova virou imagem, com exatamente as
   mesmas medidas das imagens originais, então tamanho e posição voltam a ser
   idênticos por construção.
2. **Ícones novos.** Antena, claquete, rolo de filme, seta de download, livro
   e grade, cada um na cor da sua categoria — só nos seis botões. Os ícones da
   barra de cima (sino, usuário, REC, engrenagem, trocar usuário) continuam
   como sempre foram.
3. **Botões maiores.** Diminuí a margem em volta de cada botão, então eles
   ficaram mais altos e mais largos sem sair do lugar: o centro é o mesmo,
   eles só ocupam mais espaço. No seu aparelho passaram de 209x320 para
   259x338 pixels.
4. **DNS e VPN alinhados.** Agora cada um cai no centro da coluna de SÉRIES e
   de BAIXADOS, no tamanho grande de antes.
5. **Celular igual.** A tela vertical recebeu a mesma arte e os mesmos ícones,
   sem mexer na peça que controla o toque dos botões.

**Nada de lógica foi alterado** — a comparação do app assinado v53 com o v51
deu zero diferença no código. Conferi também que nenhum endereço interno de
recurso usado pelo código mudou.

**Instalação:** por cima, sem desinstalar.

---

## Feito — v54 (5.6/66), entregue em 13/09/2026

Dois acertos em cima da v53, depois que você instalou e mandou o print.

1. **O ícone do BAIXADOS agora é o novo.** Ele era o único que não tinha
   mudado. O motivo: esse ícone específico não vem do arquivo de tela, o
   próprio código do app troca ele quando a tela abre. Troquei a imagem que o
   código usa, então agora aparece a seta verde igual aos outros.
2. **DNS e VPN alinhados de verdade.** Estavam cerca de 31 pixels à esquerda
   do centro de SÉRIES e BAIXADOS. Era uma margem num elemento invisível da
   faixa de baixo que roubava largura da divisão das colunas. Corrigido, e
   também protegi contra o caso de a faixa desalinhar de novo em outras
   contas.

**Nada de lógica foi alterado** — comparação do v54 com o v53: zero diferença
no código, e nenhum endereço interno de recurso mudou. As correções foram
auditadas por um agente antes de compilar.

**Instalação:** por cima, sem desinstalar.

---

## Feito — v55 (5.7/67), entregue em 13/09/2026

Últimos ajustes visuais, todos aprovados por prévia antes de eu compilar.

1. **Ícones nas cores naturais.** Saiu a pintura na cor da categoria; cada
   ícone ficou com as cores originais dele. O contorno que acende no foco
   continua colorido por categoria.
2. **DNS e VPN na largura dos botões de cima.** Era isso que faltava: a
   divisão entre SÉRIES e BAIXADOS agora cai exatamente na divisão entre DNS e
   VPN. Antes eles eram estreitos e só ficavam centralizados na coluna.
3. **Tom do vidro** ficou no claro, com a cortina aparecendo atrás do botão.

Zero diferença no código contra a v54.

**Instalação:** por cima, sem desinstalar. É esta que vale — não a v54.

---

## Feito — v56 (5.8/68), entregue em 13/09/2026

1. O botão "DNS" agora se chama **"ATUALIZAR DNS"**.
2. **Ícones do DNS e do VPN maiores e iguais.** Eles já tinham a mesma medida,
   mas pareciam de tamanhos diferentes porque o desenho dentro de um dos
   arquivos tinha uma borda vazia em volta. Refiz os dois arquivos para o
   desenho ocupar a mesma proporção, e aumentei os dois.
3. **"Expiração" e "Conectado" na mesma linha.** O bloco do "Conectado" tinha
   alinhamento só na horizontal no layout original, e por isso o Android o
   jogava para o topo da faixa. Como a faixa ficou mais alta depois que os
   botões cresceram, ele subiu e desalinhou.

Zero diferença no código contra a v55.

**Instalação:** por cima, sem desinstalar. É esta que vale.

---

## Feito — v57 (5.9/69), entregue em 13/09/2026

**Ordenação já vem escolhida de fábrica**, como você pediu:

- **Canais:** A-Z
- **Filmes:** Últimos Adicionados
- **Séries:** Últimos Adicionados

Vale tanto para quem instala o app do zero quanto, uma única vez, para quem já
tem o app instalado — assim você já vê funcionando no seu aparelho. Depois
dessa primeira vez, o que o usuário escolher no menu "Ordenar" é respeitado
normalmente.

Nenhuma outra coisa foi tocada: o único arquivo de código alterado foi o que
grava as configurações de fábrica, e o restante do app está idêntico à v56.

**Instalação:** por cima, sem desinstalar.

---

## Feito — v58 (6.0/70), entregue em 14/09/2026

Dois ajustes que você pediu depois de instalar em TV Box.

1. **A cortina agora aparece em todas as telas.** Ela estava só na tela
   inicial e na de usuários. Descobri por quê: o papel de parede antigo não
   estava num arquivo só — ele estava **copiado em 13 arquivos diferentes**
   dentro do app, um para cada tipo de tela (login, lista de canais, lista de
   filmes e séries, informações do filme, guia de programação, conta, controle
   parental, seleção de player, formato de fluxo, formato de hora,
   configurações e fundo do player). Troquei os 13 pela cortina. Como o app
   busca essas imagens pelo nome, **nenhum arquivo de tela e nenhuma linha de
   código precisou mudar por causa disso** — e o resultado sai igual em TV Box,
   Fire Stick, Smart TV e celular automaticamente.
2. **"Conectado" alinhado no TV Box.** No arquivo de tela do TV Box esse bloco
   estava alinhado ao **início** da coluna dele — que fica logo depois do botão
   VPN — enquanto no celular está alinhado ao **fim**, na borda da tela. Agora
   os dois usam o mesmo valor. A auditoria ainda achou que o "Expiração" do TV
   Box também não tinha o alinhamento vertical que a gente já tinha corrigido
   no celular; corrigi junto, então as duas linhas ficam na mesma altura lá
   também.

**Conferência:** comparação do v58 com o v57 — **zero diferença no código**,
93 arquivos diferentes ao todo (as 91 imagens e os 2 arquivos de tela do TV
Box), nenhum endereço interno de recurso alterado e nenhum recurso novo ou
removido. Auditado por agente antes de compilar.

**Instalação:** por cima, sem desinstalar.

---

## Feito — v59 (6.1/71), entregue em 19/09/2026

**Corrigido: o app travava para sempre na atualização do guia de TV.**

Quando um dos servidores da lista de DNS estava fora do ar, o app ficava
girando eternamente na tela "Baixando a guia de TV", sem nunca dar erro, e só
limpar os dados resolvia.

Causa: a chamada que baixa o guia não tinha tempo limite nenhum. Se o servidor
aceita a conexão mas não responde, ela espera para sempre — e como nunca
termina nem falha, o app deixa gravado que o guia está "processando", e a tela
inicial reabre a tela do guia num ciclo. Por isso voltar não adiantava.

Correção: 30 segundos de limite, o mesmo valor que o app já usa em outros três
pontos. Passou disso, ele desiste, cai no tratamento de erro que já existia e
entra na tela inicial sem o guia — esse caminho já estava pronto, só nunca era
alcançado.

Conferência: o único arquivo diferente no APK inteiro é esse, nenhum recurso
mudou, nenhum endereço interno mudou.

**Não entregue nesta versão: a tela inicial vazia em um TV Box.**

Eu tinha preparado uma correção (a imagem de fundo dos botões DNS/VPN inflando
em telas de densidade baixa e comendo a altura dos seis botões). Os auditores
reprovaram em duas rodadas: a primeira porque a "altura mínima" que eu usei é
ignorada pelo Android naquele tipo de fileira; a segunda porque, refazendo a
conta para sete configurações de TV Box, **em nenhuma delas a fileira ficava
menor que o conteúdo** — ou seja, a hipótese não explica o defeito — e a
correção deixaria os botões menores e subiria a tela nos aparelhos onde hoje
funciona. Tudo foi revertido.

Para fechar esse caso é preciso a resolução e a densidade de tela daquele
aparelho específico.

---

## Feito — v62 (6.4/76) e v62D (6.4D/77), entregues em 25/09/2026

**A tela inicial vazia foi resolvida — e a causa ficou provada graças ao seu
teste com a cliente.**

Quando você pediu para ela navegar com o controle na tela "vazia" e ela entrou
no GUIA e depois em TV AO VIVO, isso provou que **os botões estão lá e
funcionam — eles só não são desenhados**. Parece que isso descartaria a
hipótese de tamanho, mas é justamente o contrário: no Android 8 e anteriores
(que é o que roda na maioria dos TV Box, Fire Stick e Smart TV baratas) um
botão de **altura zero ainda recebe foco e ainda abre quando você dá OK**. Ou
seja: a fileira dos botões encolheu até sumir, e o controle continuou
navegando em cima de botões invisíveis.

O motivo do encolhimento: o cabeçalho de cima tem altura fixa, a tela tem uma
margem grande em volta, e existe um espaço vazio no meio do layout que sozinho
consome metade da área útil. Em tela que reporta pouca altura, sobra zero para
os botões.

**A correção:** o app agora mede sozinho a fileira de botões 1,2 segundo depois
de abrir a tela. Se ela está do tamanho certo, ele não faz absolutamente nada —
nenhum aparelho que hoje funciona é tocado. Se estiver pequena, ele primeiro
remove aquele espaço vazio e a margem (o que já resolve na maioria dos casos) e
só se ainda faltar espaço é que encolhe o cabeçalho, reduzindo a logo junto para
ela não ficar cortada. Nada disso muda arquivo de imagem ou de layout — é tudo
decidido na hora, no aparelho.

**Também revisei o prazo de segurança da tela de atualização.** Você comentou
que a atualização está demorando mais. O prazo de segurança não atrasa nada: ele
só age depois do tempo acabar. O que eu mudei foi deixá-lo mais inteligente —
agora são dois prazos (2min30 e 10min) e **os dois só agem se NENHUMA parte da
atualização tiver respondido**. Se o servidor está respondendo, mesmo devagar, o
app nunca é interrompido. Na v60 o prazo de 10 minutos era cego e podia cortar
uma atualização saudável de lista grande — isso foi corrigido.

Sobre baixar o prazo para 1min30: isso **não deixaria a atualização mais
rápida**. Só faria o app desistir antes e abrir com o catálogo pela metade. Se a
lentidão continuar, o lugar de investigar é o painel/servidor.

**v62D** é a mesma coisa da v62, mas escreve os números da tela no lugar da data
de expiração. É só para o aparelho da cliente, para confirmar que o conserto
pegou. Depois do print, instala a v62 por cima.

**Atenção:** os números de versão 73 e 75 foram usados em builds de teste, então
a próxima versão tem que ser 78 ou maior.

---

## Feito — v60 (6.2/72) e v60D (6.2D/73), entregues em 21/09/2026

**v60 — o app ficava carregando para sempre no "Download de canais, Filmes e
séries".** Duas correções entraram:

1. **Prazo de segurança na tela.** Passados 10 minutos sem terminar, o app avisa
   ("O servidor demorou demais para responder. Abrindo o aplicativo.") e leva o
   usuário para a tela inicial em vez de ficar preso. Se a importação terminar
   normalmente antes disso, o prazo é cancelado sozinho e nada acontece.
2. **Transação do banco fechada no erro.** Em 12 pontos onde a gravação em lote
   podia falhar, a transação ficava aberta e travava tudo o que viesse depois,
   sem nenhuma mensagem. Agora ela é encerrada corretamente.

**O que foi descartado de propósito:** baixar o tempo limite de rede de 60 para
30 segundos. O auditor mostrou que esse mesmo tempo limite é usado pelo login,
pela tela inicial, por séries e por detalhes de filme, e que painel com lista
grande costuma levar de 40 a 60 segundos só para começar a responder. Cortar
para 30s corrigiria um cliente e quebraria outros. Ficou em 60.

Conferência: comparando com a v59, mudaram exatamente três arquivos de código e
**nenhum** arquivo de imagem, layout ou texto. Visual intacto, mesma assinatura.

**v60D — versão de diagnóstico, só para os aparelhos com a tela vazia.** É a
v60 com um detalhe: no lugar da data de expiração, no canto de baixo à
esquerda, aparece em letra miúda a resolução da tela, a densidade, o tamanho em
dp e o tamanho real medido do botão "TV AO VIVO". O cliente instala, tira um
print e manda. Com esse print dá para saber se os botões estão sendo criados
com tamanho zero (problema de medida) ou se estão do tamanho certo e
simplesmente não são desenhados (problema de vídeo do aparelho). Depois do
print, é só reinstalar a v60 por cima.

---

## Feito — v71 (7.3/94), entregue em 25/09/2026

Versão de produção. Fecha os dois problemas de campo de 21/09, resolve a
lentidão e traz o recurso de atualização pelo painel.

**1. Tela inicial vazia — resolvido.** Eram duas coisas somadas. A barra de
baixo estava ocupando 646 dos 864 pixels úteis, sobrando zero para a fileira de
botões; e a rotina de idioma apagava as medidas da tela a cada vez que uma
tela era reaberta. Essa segunda parte explica por que o problema "começou do
nada": a rotina só roda quando o idioma está escolhido, e fomos nós que
deixamos "Portuguese" de fábrica duas ou três versões antes.

Agora a rotina de idioma preserva as medidas, e existe um resgate automático
que **só age em aparelho quebrado**: se a fileira já está do tamanho certo, ele
retorna sem tocar em nada. Confirmado no TX9 — botões visíveis, do tamanho
certo, com o foco no TV AO VIVO.

**2. Preso no "Download de canais, Filmes e séries" — resolvido.** A transação
do banco não fechava quando dava erro no meio, e o passo seguinte ficava
esperando para sempre. Agora fecha. Além disso há dois prazos de segurança
(2min30 e 10min) que **só disparam se nenhum dos seis passos completou** —
prazo cego mataria importação legítima, que no pior caso passa dos 12 minutos.

**3. Entrar no app ficou rápido.** De mais de 2 minutos para 12s de login, 58s
de conteúdo e 12s de guia. E, reabrindo dentro de 12 horas, o download de
conteúdo é **pulado inteiro** — vai direto para a tela inicial. O carimbo desse
prazo só é gravado quando a importação termina de verdade e sem nenhum erro, e
fica amarrado ao usuário logado: trocar de conta reimporta na hora.

A lista de TV AO VIVO abria em 5 segundos e agora abre em 1, por causa de um
índice no banco.

**4. Atualização pelo painel — novo.** Ao abrir a tela inicial, o app pergunta
ao painel se existe versão nova. Se existir, mostra uma janela com o número da
versão e o seu recado, e os botões ATUALIZAR e AGORA NÃO. Aceitando, ele baixa
e abre o instalador sozinho.

No painel, aba **Atualização**: você digita o número da versão, o nome que o
cliente lê, o link do APK e a mensagem; marca se é obrigatória (aí some o
"AGORA NÃO") e se quer avisar os clientes. Tem também a lista de quais versões
estão em uso no seu parque.

Ele pergunta **uma vez por dia**, para não incomodar. Se a consulta falhar
porque o Wi-Fi ainda não subiu — o normal em TV Box — ele tenta de novo na
próxima vez, em vez de desistir até o app ser fechado.

**O que você precisa fazer:** subir o painel na **raiz** de `app.tvaqui.top`.
O endereço está fixo dentro do APK, então se ele ficar numa subpasta o app não
acha. O APK novo continua sendo hospedado onde já está
(`amoraamor.top/arq/pro.apk`) — o painel só guarda o link.

---

## Idealizado (planejado, ainda não começado)

- Migrar o painel pra sua própria hospedagem e apontar o APK pra lá — você
  decidiu deixar isso pra depois, depois de fechar os ajustes de agora.
- Autenticação usuário/senha no proxy SOCKS5/HTTP (hoje o app só usa
  host/porta; os campos já existem no formulário do painel mas não são
  usados ainda).
- Tela de aparelhos conectados mais completa, atualização remota e cadastro
  de cliente à distância — isso exige mudar o app pra ele ter um canal de
  comandos vindo do painel (hoje ele só pergunta DNS, avisos e rotas).
- Aplicar o mesmo conhecimento nos outros apps de IPTV que você revende
  (usar o `GUIA-APPS-SMARTERS.md` como ponto de partida).
- Fazer um teste real de login com o app apontado pro seu painel próprio,
  pra confirmar de vez o campo `sc` da API.
- Testar de verdade, com um cliente com bloqueio real da operadora, se a
  rota automática de VPN resolve — não dá pra simular esse bloqueio aqui.

---

*Última atualização: 25/09/2026 — entrega da v71 (7.3/94), primeira versão de
produção desde a v63: tela inicial vazia resolvida, travamento no download
resolvido, entrada no app de 2 minutos para menos de 30 segundos, e o recurso
de atualização pelo painel. Antes dela, a v59 (6.1/71), que corrige o
travamento eterno na atualização do guia de TV. Antes dela, a v58 (6.0/70), com a cortina em
todas as telas e o "Conectado" alinhado no TV Box. Antes dela, a v57 (5.9/69),
com a ordenação de
fábrica (canais A-Z, filmes e séries em Últimos Adicionados). Antes dela, a
v56 (5.8/68), com o "ATUALIZAR
DNS", ícones iguais e as duas linhas de texto alinhadas. Antes dela, a v55
(5.7/67), com os ícones nas
cores naturais e o DNS/VPN na largura das colunas. Antes dela, a v54 (5.6/66),
que corrigiu o
ícone do BAIXADOS e o alinhamento do DNS/VPN. Antes dela, a v53 (5.5/65), que
corrigiu o
tamanho dos botões da v52 e traz os ícones novos. Antes dela, a v52 (5.4/64),
com a repaginação
visual da tela inicial (fundo novo + botões Vidro Neon + DNS/VPN alinhados,
em TV Box, Fire Stick, Smart TV e celular), sem nenhuma mudança de lógica.
Antes dela, a v51 (5.3/63), com três ajustes em
cima da v50 (5.2/62) e troca da chave de assinatura (senha antiga perdida).
Detalhe técnico em NOTAS-TECNICAS.md, seção 6 ("v51"); histórico da
investigação de playback em RELATORIO-INVESTIGACAO-PLAYBACK.md, seções 4.2 e
4.3. Próximo passo do projeto: hospedar o painel próprio.*
