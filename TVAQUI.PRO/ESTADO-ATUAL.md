# TVAQUI.PRO — onde o trabalho parou (25/09/2026, noite)

Este arquivo existe para retomar o projeto numa conversa nova, do zero.
Leia primeiro este; depois `DOCUMENTACAO.md` (visão geral) e
`NOTAS-TECNICAS.md` (detalhe técnico).

## 0. Para retomar numa conversa nova (limpar o contexto)

Limpar o contexto **ajuda** — a conversa fica mais rápida e sem confusão. Para
não perder nada, na primeira mensagem da conversa nova envie:

1. `PROXIMOS-PASSOS.md` — **comece por ele**, tem a lista do que fazer em ordem
2. `ESTADO-ATUAL.md` (este arquivo)
3. `DOCUMENTACAO.md`
4. `GUIA-APPS-SMARTERS.md`
5. `mykey.keystore` — sem ele não dá para assinar
6. as **5 partes da versão atual** (v71)

O `NOTAS-TECNICAS.md` é de 31/08 e parou de ser mantido — serve como histórico,
não como referência.

E escreva: *"continue do PROXIMOS-PASSOS.md"*.
Tudo o que foi descoberto está escrito aqui — nada depende da memória da
conversa antiga.


---

## 1. Versão atual

| | |
|---|---|
| Entregue agora | **v71 — versionName `7.3`, versionCode `94`** |
| SHA-256 do APK | `0f468fb5c58945092308e4e299bef858c598c5482bfb0e58d725f5ad0f409e1d` |
| MD5 | `96086c2f3dbbe617c15d6882f7470da7` |
| Versão anterior | v70D (7.2D / 93) — build de diagnóstico, **não distribuir** |
| Atenção ao versionCode | os códigos 73, 75 e 78 a 93 foram queimados em builds de diagnóstico. **O próximo release tem que ser 95 ou mais.** |

A v71 é a primeira versão de produção desde a v63. Tudo o que estava em
diagnóstico (a classe `DiagMetrics`, que escrevia os números da tela no lugar
da data de expiração) saiu. A classe continua na árvore, sem ninguém chamando —
para voltar a ter um build de diagnóstico basta repor o bloco no `onResume`.

**Qualquer versão anterior à v71 está superada.** As v52 a v58 em especial não
devem ser usadas: na v52 os botões DNS/VPN encolheram e os de cima esticaram;
na v53 o ícone do BAIXADOS não mudou e o DNS/VPN ficou 31px fora do
alinhamento.

---

## 2. Assinatura — leia antes de qualquer coisa

O APK é assinado com `mykey.keystore`, alias **`tvaqui`**, senha de store e
de chave **`[SENHA-REMOVIDA]`**.

Esse arquivo **precisa ser guardado pelo cliente**. A chave original se
perdeu em 12/09/2026 (senha não anotada) e por isso a v51 exigiu desinstalar
o app antes de instalar. Se essa segunda chave se perder, acontece de novo
com todo mundo que tiver o app instalado.

Certificado atual (confira sempre antes de entregar, tem que bater):
`SHA-256 cdc87c7fc63d66bdae181beffe950ea488932561d0df7e7a755a1cca82f22076`

---

## 3. Como recompilar do zero numa máquina nova

O ambiente de trabalho é temporário e some. Para retomar:

1. Juntar as 5 partes da v59 (ou da versão atual) num APK.
2. **Usar apktool 2.9.3** — `java -jar apktool.jar d -f APP.apk -o decoded`.
   O `apktool` que vem no sistema costuma ser o **2.7.0**, que usa aapt1 e
   **não compila este projeto**: aborta com `First type is not attr!` e
   `exit code = 134`, sem apontar arquivo nenhum. Parece erro das edições,
   mas é a ferramenta. Baixar o 2.9.3 antes de tudo.
3. Editar.
4. Compilar: `java -jar apktool.jar b decoded -o saida.apk`
5. `zipalign -p -f 4 saida.apk alinhado.apk`
6. `apksigner sign --ks mykey.keystore --ks-pass pass:SENHA --ks-key-alias tvaqui --key-pass pass:SENHA --out assinado.apk alinhado.apk`
7. Conferir: `apksigner verify --print-certs -v assinado.apk`
8. **Conferência obrigatória**: decompilar o APK **assinado** de novo e
   comparar com o decompilado da versão anterior (`diff -rq`). O `smali` tem
   que dar **0 diferenças** quando a mudança é só visual. Comparar também o
   `public.xml` das duas versões para garantir que nenhum ID de recurso já
   existente mudou de número.
9. Dividir em 5 partes (`split -b … -d -a 3`) e entregar **sempre com o
   comando `cat` do Termux** — o PC do cliente fica offline, ele junta os
   arquivos no celular.

**Armadilhas do ambiente novo (14/09/2026):** (a) `zipalign`/`apksigner` podem
não estar instalados — `apt-get install -y apksigner zipalign aapt` resolve;
(b) o `apktool.yml` de um decompile novo grava a versão **sem aspas**
(`versionCode: 69`), então um replace escrito para `versionCode: '69'` falha
em silêncio e o APK sai com a versão antiga — confira sempre com
`aapt dump badging` depois de assinar.

---

## 4. O que o cliente exige no modo de trabalho

- **Prévia fiel antes de implementar.** Ele quer ver uma imagem de como a
  tela vai ficar de verdade, e aprova ou pede ajuste em cima dela. Montar a
  prévia em cima do print que ele mandou funciona bem.
- **Não mexer no que já funciona.** Cada versão só pode alterar o que foi
  pedido; mudança visual não pode encostar em lógica.
- **Não mexer na logo.**
- **Mesmo visual em todos os aparelhos**: TV Box, Fire Stick, Smart TV
  Android e celular.
- **Entrega sempre em 5 partes + comando do Termux**, sem precisar pedir.
- **Ordenação de fábrica que ele quer em TODO app que mexermos** (pedido em
  13/09/2026, para reaproveitar nos outros apps dele): canais em **A-Z**,
  filmes em **Últimos Adicionados**, séries em **Últimos Adicionados**. O mapa
  de chaves e valores está na seção da v57 do NOTAS-TECNICAS.md.
- Usar sub-agentes para auditoria antes de compilar — ele pede isso
  explicitamente ("chame os agentes, o auditor e o sênior"), e nas v53/v54 foi
  o que achou as causas reais.
- Em imprevisto técnico (tipo a senha perdida da chave), ele espera que eu
  decida e resolva, avisando depois — não que eu pare para perguntar.

---

## 5. O que está resolvido e o que ficou pendente

### 5.1 Tela inicial vazia — RESOLVIDO, confirmado em campo

**Causa raiz, provada.** Duas coisas somadas:

1. A **barra de baixo** estava medindo 646px dos 864px disponíveis, sobrando 0
   para a fileira dos seis botões. Em Android abaixo da API 28 uma view de
   altura ZERO ainda recebe foco e clique (`View.canTakeFocus` só passou a
   exigir tamanho no Android 9) — por isso o controle remoto "achava" botões
   que ninguém via. TV Box, Fire Stick e muita Smart TV Android rodam 7.1 ou 8.1.
2. A rotina de idioma (`miscelleneious/b/d.c(Context,String)`) criava um
   `new Configuration()` **em branco** e mandava para `updateConfiguration`.
   Isso zerava `screenLayout`, `orientation` e a densidade a cada `onResume` de
   **cada** Activity. E ela só roda quando `selected_language` está preenchido —
   que fomos **nós** que preenchemos, com "Portuguese" de fábrica, duas ou três
   versões antes. Era por isso que a família inteira de problemas começou "do
   nada".

**Correção.** A `Configuration` agora é uma **cópia da atual**, com só o locale
trocado. E a classe `view/activity/TvaquiFix.smali`, postada no `onResume` com
300ms de atraso, faz um resgate em 4 etapas que **só age em aparelho quebrado**:
se a fileira já tem 64dp ou mais, retorna sem tocar em nada. As etapas: zerar o
padding da raiz; **limitar a barra de baixo a 96dp** (é esta que conserta de
fato); forçar altura na fileira e em 5 ancestrais; encolher o cabeçalho para
56dp e a logo para 48dp. As etapas 4 e 5 devolvem o foco ao TV AO VIVO e são
testadas **antes** da trava de altura, para não serem puladas.

**Confirmado no TX9:** `H:312:320:320:639:639:639:864 W312 BAR:138:138:192` —
botões visíveis, largura certa, foco no lugar.

### 5.2 Preso no "Download de canais, Filmes e séries" — RESOLVIDO

Três causas, todas corrigidas:

- **Transação de banco que nunca fechava.** Doze métodos de inserção em massa
  (`b/b/d.smali`) abriam `beginTransaction()` e, se estourasse exceção no meio,
  saíam sem `endTransaction()` nem `close()`. O banco ficava travado e o passo
  seguinte esperava para sempre. Agora o `catch` fecha os dois, com guarda para
  o caso de o objeto do banco nem ter chegado a existir.
- **Sem rede de segurança.** Dois watchdogs (`ImportWatchdog.smali`), aos 150s e
  aos 600s, **condicionais**: só disparam se **nenhum** dos 6 passos completou.
  Prazo cego aqui é regressão — o pior caso legítimo é ~725s.
- **Timeout de conexão.** Era 60s só para o aperto de mão TCP. Agora são 10s
  para conectar e 60s para ler (o tempo de resposta do painel, que é o que
  realmente demora, ficou intocado). Medido em campo: 65s → 12s.

### 5.3 Lentidão para entrar — RESOLVIDO

De 2+ minutos para 12s/58s/12s, e na reentrada dentro de 12 horas o download de
conteúdo é pulado por completo. O carimbo desse prazo é gravado **só quando a
importação termina de verdade e sem erro**, e é **amarrado ao usuário logado** —
trocar de conta reimporta na hora. Relógio para trás também força reimportação
(TV Box sem bateria de RTC sobe com data errada).

A lista de TV AO VIVO caiu de 5s para 1s com um índice em
`iptv_live_streams(categoryID)`, criado uma vez por sessão **em segundo plano**
(criar índice na thread da tela congelaria o aparelho por segundos na primeira
abertura depois de importar).

### 5.4 Atualização pelo painel — NOVO na v71

O app consulta `https://app.tvaqui.top/api/home.php?action=versao&app=pro` ao
abrir a tela inicial, em segundo plano. Se o número publicado for maior que o
instalado, mostra uma janela perguntando se quer baixar e instalar. Detalhes:

- Pergunta **uma vez por dia**, a menos que a atualização esteja marcada como
  obrigatória no painel (aí não tem o botão "AGORA NÃO").
- Se a consulta falhar (Wi-Fi ainda subindo, que é o normal em TV Box), a trava
  é liberada e ele tenta de novo no próximo `onResume`.
- Tenta **https e, se falhar, http**. Android 5, 6 e 7.0 não têm a raiz nova da
  Let's Encrypt; sem essa queda o recurso ficaria invisível justo no parque
  antigo.
- Baixa para `getExternalFilesDir(null)/tvaqui-atualizacao.apk` e abre o
  instalador via o FileProvider que o app já tinha
  (`com.tvaquipr.mtream.provider`). Permissão `REQUEST_INSTALL_PACKAGES`
  adicionada ao manifesto.
- **Onde hospedar:** o painel tem que ficar na **raiz** de `app.tvaqui.top`,
  porque o endereço está fixo no APK. Se for para uma subpasta, o endereço
  dentro de `TvaquiUpdate.smali` precisa mudar antes de compilar.
- O APK novo continua sendo hospedado onde já está
  (`amoraamor.top/arq/pro.apk`) — o painel só guarda o link.

### 5.5 Pendente

0. **Montar os 3 endereços e gerar a v72 (versionCode 95)** — o código do app já
   está escrito e compilando, com os endereços de exemplo
   `app.tvaqui.top/pro,app2.tvaqui.top/pro,app3.tvaqui.top/pro`. Falta só trocar
   pelos reais. Ver `PROXIMOS-PASSOS.md`.
1. **~12s de "aguarde"** — sobrou um endereço morto que é tentado primeiro,
   ainda não identificado.
2. **Telas de importação e de EPG desenham "pequenas" em TV** — a correção da
   `Configuration` não resolveu isso. Causa ainda desconhecida.
3. **EPG baixa todo dia (~12s).** Poderia baixar só quando a guia guardada
   estiver acabando.
4. `new_dashboard_layout_without_freetrail2.xml` e `new_dashboard_layout.xml`
   ainda estão no estilo antigo.
5. Vidro do modo retrato ainda estático.
6. Hospedar o painel de DNS.
7. VPS Oracle + primeira rota de VPN de verdade.
8. Autenticação de usuário/senha no proxy.
9. Aplicar tudo isso no PRO2.

### 5.6 Endereços do painel — decidido em 25/09, ainda não montado

O endereço que o app consulta fica **gravado dentro do APK** e não muda sem
recompilar e pedir reinstalação para todo mundo. Se esse domínio cair — e o
TVB viu o `.shop` cair no mundo inteiro — o parque inteiro fica sem ninguém
para perguntar.

**A solução montada (falta ele executar, está no `PROXIMOS-PASSOS.md`):**

1. **Três endereços gravados no APK**, em domínios diferentes, na ordem de
   tentativa. Ficam num campo só da `TvaquiUpdate.smali`, separados por vírgula:
   `.field public static final SEM:Ljava/lang/String;`. É a **única** coisa a
   trocar para mudar os endereços.
2. **O painel devolve a lista atual de espelhos** em toda resposta (campo
   `espelhos`). O app guarda no aparelho e tenta essa lista **antes** das
   sementes. Assim ele aprende endereços novos sem recompilar — **desde que o
   espelho seja cadastrado enquanto o painel ainda está no ar.**
3. **Um painel de verdade + espelhos burros.** Nas outras hospedagens vai só o
   `espelho-tvaqui.zip`: um PHP de 4 KB, sem banco, que repassa a pergunta para
   o painel principal e guarda a última resposta boa por 30 dias. O TVB continua
   publicando num lugar só.

Escolha dele: 2 endereços no No-IP (plano pago, finais diferentes, TTL 60) e 1
domínio próprio. Pelo menos um tem que estar em **servidor diferente** dos
outros — senão só protege contra queda de domínio, não de hospedagem.

**Não usar a Oracle gratuita para o espelho:** desde 15/06/2026 o nível gratuito
caiu de 4 núcleos/24 GB para 2/12 (sem aviso), e a Oracle apaga instância que
passe 7 dias com CPU, rede e memória abaixo de 20% — que é exatamente o perfil
de um espelho. Para a rota de VPN ela continua servindo.

## 6. Arquivos do projeto

| Arquivo | O que é |
|---|---|
| `ESTADO-ATUAL.md` | este arquivo |
| `DOCUMENTACAO.md` | o que foi feito / em andamento / idealizado, em linguagem simples |
| `NOTAS-TECNICAS.md` | detalhe técnico do TVAQUI.PRO, versão por versão |
| `GUIA-APPS-SMARTERS.md` | guia reaproveitável para qualquer app dessa linha |
| `RELATORIO-INVESTIGACAO-PLAYBACK.md` | histórico da investigação de reprodução (v38–v48) |
| `PROXIMOS-PASSOS.md` | a lista do que fazer, em ordem — o ponto de partida |
| `painel-tvaqui-app.zip` | painel próprio (DNS, rotas, aparelhos) **com a aba Atualização e os espelhos** — PHP + SQLite |
| `espelho-tvaqui.zip` | o espelho: um PHP só, sem banco, para as outras hospedagens |
| `mykey.keystore` | chave de assinatura — guardar com cuidado |
