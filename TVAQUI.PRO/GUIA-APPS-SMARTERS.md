# Guia para modificar apps IPTV da linha Smarters

Conhecimento acumulado ao trabalhar no TVAQUI.PRO, escrito para servir a
**qualquer app da mesma família**. Serve de ponto de partida quando for mexer
em outro aplicativo.

---

## 1. Como saber se o app é dessa família

Depois de descompactar, procure por estes sinais:

```bash
grep -rn "whmcssmarters" res/values/strings.xml     # vendedor da base
ls smali_classes2/com/*/                            # pacote tipo com.ftgtv.ftgiptvbox
ls smali_classes2/com/*/*/a/g.smali                 # cliente de API do painel
```

Se aparecer `whmcssmarters.com` nos textos ou existir a classe `a/g`, é a
mesma base (IPTV Smarters Pro rebrandeado) e **tudo neste guia se aplica**,
mudando só o nome do pacote.

Atenção: o nome do pacote interno (`com.ftgtv.ftgiptvbox`) costuma ser
diferente do `applicationId` (`com.tvaquipr.mtream`). Nos caminhos de arquivo
vale o **pacote interno**.

---

## 2. Ferramentas e sequência de trabalho

```bash
# 1. descompilar
java -jar apktool.jar d APP.apk -o decoded

# 2. editar os arquivos .smali / res/

# 3. recompilar
java -jar apktool.jar b decoded -o app.unsigned.apk

# 4. alinhar
zipalign -p -f 4 app.unsigned.apk app.aligned.apk

# 5. assinar
apksigner sign --ks mykey.keystore --ks-pass pass:SENHA \
  --ks-key-alias ALIAS --key-pass pass:SENHA \
  --out app.signed.apk app.aligned.apk

# 6. CONFERIR: descompilar o APK JÁ ASSINADO e verificar as alterações
java -jar apktool.jar d app.signed.apk -o verify
grep -n "sua_alteracao" verify/smali_classes2/.../Arquivo.smali
```

O passo 6 não é frescura — foi ele que pegou erro em várias rodadas. Confira
sempre no APK **assinado**, não no que você editou.

Para subir a versão, edite `decoded/apktool.yml`:

```yaml
versionCode: '48'
versionName: '4.7'
```

**Entrega sem PC:** dividir e juntar no Termux.

```bash
split -n 5 -d app.signed.apk parts/app.part0        # gera part000..part004
cat app.part00* > app.signed.apk                    # no Termux, no Android
```

---

## 3. Mapa das classes ofuscadas

O código é ofuscado (classes com nome de uma letra). Este mapa poupa horas:

| Caminho | O que é |
|---|---|
| `a/g.smali` | cliente que fala com o painel |
| `a/g$a.smali` | **as constantes de URL do painel** |
| `a/d.smali` | AsyncTask que faz o POST |
| `a/e.smali` | um campo de formulário (nome/valor) |
| `a/c.smali` | interface de callback da resposta |
| `a/f.smali` | dados do aparelho (`c()` devolve a chave guardada) |
| `b/b/d.smali` | **banco de dados principal** (canais, EPG, filmes, séries) |
| `b/b/e.smali` | banco de licença / m3u |
| `b/c/a.smali` | modelo de notificação (Title, Description, CreateDate) |
| `b/c/m.smali` | modelo de programa do EPG |
| `view/utility/b.smali` | baixa e interpreta o XMLTV do EPG |
| `miscelleneious/b/a.smali` | constantes estáticas globais |
| `miscelleneious/b/d.smali` | utilidades (`l(Context)` monta a URL do servidor) |

Telas principais em `view/activity/`: `SplashActivity`, `LoginActivity`,
`MultiUserActivity`, `NewDashboardActivity`, `LiveActivityNewFlow`,
`ImportEPGActivity`, `ImportStreamsActivity`, `ImportM3uActivity`,
`AnnouncementsActivity`, `NewEPGActivity`.

**Biblioteca de rede (OkHttp), também ofuscada — pacote `c`:**

| Caminho | O que é |
|---|---|
| `c/x.smali` | `OkHttpClient` |
| `c/x$a.smali` | `OkHttpClient.Builder` |
| `c/aa.smali` / `c/aa$a.smali` | `Request` / `Request.Builder` |
| `c/e.smali` | `Call` (interface; `a()` executa e lança `IOException`) |
| `c/ac.smali` | `Response` (`f()` devolve o body) |
| `c/ad.smali` | `ResponseBody` (`e()` devolve `String`) |
| `c/q.smali` / `c/q$a.smali` | `FormBody` / `Builder` |
| `c/w.smali` / `c/w$a.smali` | `MultipartBody` / `Builder` |

Vale conferir se o app-alvo usa a mesma versão do OkHttp (os nomes de classe
de uma letra podem mudar entre versões) antes de reaproveitar esse mapa.

Truque para achar coisas: pesquise pelo **texto que aparece na tela** em
`res/values-pt/strings.xml`, pegue o nome do recurso, ache o ID numérico em
`res/values/public.xml` e depois procure esse ID no smali.

---

## 4. O painel de DNS

### Onde fica o endereço

```
smali_classes2/<pacote>/a/g$a.smali

public static a = "https://PAINEL/api/home.php?"    ← trocar aqui
public static b = "action=dns"
public static c = "action=note"
public static d = "reset_password"                  ← não é usado
```

**Não existe tela no app para configurar isso.** Trocar de painel = editar
essa constante e recompilar.

### O que o painel precisa responder

`?action=dns` — JSON:

```json
{
  "status": "true",
  "su": ["http://servidor1:80", "http://servidor2:8080"],
  "ndd": "2027-08-31",
  "sc": "<devolver o mesmo que o app enviou>"
}
```

O app pega `su` como texto, corta o primeiro e o último caractere, remove as
aspas e divide por vírgula. `ndd` é vencimento em `yyyy-MM-dd`. `status`
precisa ser `"true"`.

`?action=note` — JSON:

```json
{"status": true,
 "response": [{"Title":"...", "Description":"...", "CreateDate":"..."}]}
```

### O que o app envia

`m` (o **comando**, ex. `gu` — não é MAC), `k` (chave única da instalação),
`d` (fabricante+modelo), `u`, `pw`, `av`, `dt`, `sc`, `r`, `do`.
**Não existe MAC.** Para identificar clientes, use `k` + `d`.

---

## 5. Armadilhas conhecidas dessa base

Todas foram encontradas na prática. Provavelmente existem nos outros apps.

**O EPG é apagado antes de baixar.** A importação começa com
`DELETE FROM epg` (método `m()` em `b/b/d`). Se o download falhar, o cliente
fica sem guia nenhum. Correção: tirar o delete de lá e fazer o apagar
**dentro da transação de gravação** (`d(List)`), com `execSQL`, virando troca
atômica — ou grava tudo, ou não mexe em nada.

**Cuidado com `m()`: ele fecha a conexão do banco.** Chamar `m()` logo antes
de gravar faz a gravação falhar **em silêncio**. Custou uma versão inteira
para descobrir.

**Erros engolidos.** Vários métodos têm `try/catch` que só faz `Log`. Quando
algo "não acontece" sem mensagem, procure um catch vazio antes de suspeitar
de outra coisa.

**Dados carregados só no `onCreate`.** Padrão recorrente: a tela busca do
banco uma vez e nunca mais. Ao voltar para ela, mostra dado velho. Correção:
chamar de novo o método de carga no `onResume`. Ocorreu em `NewEPGActivity` e
`LiveActivityNewFlow`.

**Layout cortado no modo paisagem.** Em telas com seção de rodapé, o bloco de
cima é espremido e os textos somem — parecem "tela preta sem texto", mas o
texto existe, está fora da área visível. Verifique as variantes
`res/layout-land/` e `res/layout-large-land-v4/`; deixar seções invisíveis
como `gone` (em vez de `invisible`) devolve o espaço.

**Atualização trava pra sempre depois de tempo em segundo plano.** Nessa
base, o cliente Retrofit usado pra importar canais/filmes/séries é montado
a partir de um endereço guardado em `SharedPreferences` toda vez que a
chamada é feita (não é reaproveitado). Se esse endereço guardado estiver
vazio ou malformado (o que pode acontecer sem motivo aparente depois do
processo passar tempo em segundo plano), o método que monta o cliente
(`miscelleneious/b/d;->a(Context)`) captura a exceção e **retorna nulo em
silêncio** — e o código que chama isso (`c/d;->a()` até `f()`) só prossegue
`if-eqz`/não-nulo, ou seja, quando vem nulo **nem sucesso nem erro é
avisado**. Como o fluxo de importação é uma máquina de estados que só
avança quando um desses dois avisos chega, o resultado é a tela de
atualização girando pra sempre, sem nunca estourar por tempo esgotado (por
isso um timeout configurado direito no OkHttp não resolve sozinho — o
problema não é a rede, é a chamada nem sair do aparelho). Correção: no
`:cond_0` (branch do nulo) desses métodos, chamar explicitamente o mesmo
aviso de "falhou" que o callback de erro chamaria, pra sempre avançar a
máquina de estados. Vale procurar esse mesmo padrão (Retrofit/OkHttp
remontado por chamada, retorno nulo engolido em silêncio) em outros apps
dessa base antes de assumir que é só timeout de rede.

**Adicionar view nova numa tela com várias variantes de layout = crash
garantido em TV Box se esquecer alguma.** Toda `Activity` de tela principal
nessa base normalmente tem várias cópias do mesmo layout, uma por
qualificador de recurso: `res/layout/` (retrato/padrão),
`res/layout-land/` (paisagem) e `res/layout-large-land-v4/` (telas
grandes em paisagem — praticamente todo TV Box cai aqui). O Android
escolhe sozinho qual pasta usar de acordo com o aparelho, e **TV Box roda
sempre em paisagem** — então se você adicionar um botão/tile novo só em
`res/layout/` (o mais fácil de achar primeiro), ele nunca aparece em TV
Box, e pior: se o código faz `findViewById` nele esperando que sempre
exista, o retorno vem `null` e a próxima chamada nele
(`setOnClickListener`, etc.) derruba o app na hora — geralmente logo após
o login, o que parece (mas não é) um travamento na tela de atualização.
Aconteceu exatamente isso no TVAQUI.PRO v38 (corrigido na v39). Duas
regras pra não repetir: (1) sempre que adicionar uma view nova numa tela
assim, edite **todas** as variantes de layout dela, não só a padrão —
`find . -iname "nome_do_layout.xml"` mostra todas de uma vez; (2) mesmo
editando todas, proteja o código com `if-eqz`/checagem de nulo antes de
usar qualquer view achada via `findViewById`/`getIdentifier` — é rede de
segurança barata contra a próxima variante que você não vai lembrar de
cobrir.

**Botão de "atualizar" que parece fazer a mesma coisa que outro fluxo, mas
não faz.** Nessa base é comum existir mais de um caminho de código pro
"mesmo" resultado aparente — ex.: reentrar com um usuário salvo (clicar
na lista) e um botão avulso de "Atualizar" — e eles não serem o mesmo
código por baixo. No TVAQUI.PRO, clicar no usuário salvo chamava
`Adapter;->d(String)`, que dispara a chamada de login `"gu"` e, na
resposta, aciona `c/c;->a(String,String)` (o gatilho real de
reimportação). O botão "Atualizar" fazia a MESMA chamada `"gu"`, só que
por outro método (`Activity;->b(String)`), cujo retorno só re-renderizava
a lista a partir do cache local, sem nunca acionar o gatilho de
reimportação — então o botão "atualizava" a tela sem nunca buscar nada
novo de verdade. Antes de assumir que um botão "faz a mesma coisa" que um
fluxo que já funciona, compare os dois `onClick`/callback até a última
chamada de cada um — se um deles não termina batendo no mesmo método
final (aqui, `c/c;->a(...)` ou o equivalente de importação), ele não faz
o que parece fazer, por mais parecido que o código pareça à primeira
vista.

**Disparo automático/programático de um clique acontecendo cedo demais —
"a correção certa que nunca roda".** Depois de achar e corrigir corretamente
o *o quê* um botão deveria fazer, ainda dá pra a correção não ter efeito
nenhum na prática se o *quando* estiver errado. No TVAQUI.PRO, um botão de
"Atualizar" foi corrigido pra chamar o método certo (o gatilho real de
reimportação, que depende de um adapter/lista já montada em tela) — mas
quando esse mesmo clique passou a ser disparado **automaticamente** (via
`onClick(null)` chamado direto do código, simulando o toque, pra replicar
um fluxo que sempre funcionou manualmente), o disparo acontecia no
`onCreate`, **antes** do método que monta esse adapter/lista rodar. Resultado:
a correção "certa" caía sempre numa checagem de nulo e nunca executava de
verdade — sintoma idêntico ao bug original, então parecia que a correção
não tinha funcionado, quando na real ela nunca chegava a rodar. Lição: ao
disparar um `onClick`/callback **programaticamente** (sem o usuário ter
realmente tocado na tela), nunca assuma que já é seguro só porque o método
que o prepara (`setOnClickListener`, criar o botão) já rodou — ache o ponto
exato onde **os dados que esse clique usa** ficam prontos (aqui, logo depois
da linha que atribui o campo do adapter/lista) e dispare **dali**, não do
`onCreate` genérico. Um campo booleano "já disparei" evita repetir o
disparo se esse ponto puder rodar mais de uma vez (retentativa, atualização
da lista).

**Método "atualizar" compartilhado por dezenas de telas, sem saber pra onde
voltar.** Um único método utilitário estático (aqui, `miscelleneious/b/d.g`,
uma "atualizar canais/filmes/séries" chamada de **mais de 30 lugares
diferentes** do app — cada tela de conteúdo tem seu próprio menu com essa
opção) inicia a mesma tela de importação, mas **não sabe pra qual tela
voltar** depois — porque isso é resolvido lendo uma "ação" no `Intent`
(`Intent.getAction()`), e um caminho legítimo (o botão da tela inicial)
marcava essa ação certinho, enquanto o método compartilhado nunca marcava
nada. Resultado: **qualquer tela** que chamasse essa opção de "atualizar"
acabava devolvida sempre pro mesmo destino padrão/genérico (aqui, o
Dashboard), nunca de volta pra tela de onde o usuário realmente estava —
sem erro nenhum, sem crash, só "voltou pro lugar errado" (o que, numa tela
de vídeo em reprodução, parece "não resolveu nada"). Lição: quando uma
tela decide seu próximo destino lendo uma ação/flag do `Intent` que
**apenas alguns chamadores** definem, todo caminho novo (ou já existente,
mas nunca visto antes) que dispara essa mesma tela também precisa definir
essa ação — senão cai sempre no caso padrão, silenciosamente. Pra não
arriscar quebrar os outros ~30 chamadores que já funcionavam, o mais seguro
é criar uma **sobrecarga nova** do método (mesmo nome, um parâmetro a mais
pra ação) e só trocar o chamador específico que você está corrigindo, sem
tocar no método original nem nos outros pontos de chamada.

**Para automatizar uma ação de tela, construa o LISTENER — não chame o
método interno que ele usa.** Essa foi a armadilha mais cara deste projeto
(oito versões até acertar). Queríamos que o app fizesse sozinho o que o
usuário faz tocando num item da lista. As tentativas de chamar direto os
métodos que o toque usa por dentro (`Adapter;->d(String)`,
`Adapter;->a(String,String)`) falharam todas, com sintomas diferentes a cada
versão — porque esses métodos são **etapas do meio**: eles assumem estado que
só o listener prepara antes. No caso, o `onClick` do listener real
(`Adapter$6`, criado no `onBindViewHolder`) inicializava quatro campos de
`SharedPreferences`/`Editor` do adapter, gravava usuário/senha/endereço em
prefs, preenchia quatro campos do adapter e decidia o tipo da conta — e só
então chamava o tal método interno. Chamando o método interno direto, nada
disso existia: dava `NullPointerException` engolido por um `catch`, ou
gravava `userID = -1`, ou logava com credenciais nulas.
A solução que funcionou: **instanciar a própria classe do listener com os
mesmos argumentos que o `onBindViewHolder` passa e chamar `onClick(null)`**
— quase sempre o `onClick` sobrescreve o parâmetro `View` na primeira
instrução, então passar nulo é seguro (confirme antes). Como a classe do
listener costuma ser package-private, adicione um método `public` na classe
dona (o adapter) que faz isso, e chame esse método de fora.
Receita para achar os argumentos certos: leia o `onBindViewHolder` e copie a
ordem exata do `new Listener(...)` — os registradores são embaralhados por
`move-object/from16` antes do `invoke-direct/range`, então **desembaralhe com
cuidado**; trocar dois argumentos aqui grava dados errados em silêncio.

**Dois endereços de servidor, e o player usa o segundo.** Nessa base existe
um endereço *provisório*, gravado quando o app pede a lista de DNS ao painel,
e o *definitivo*, que só é gravado **quando o login completa** — é o
`server_info.url`/`port` que a API devolve, salvo em `loginPrefs`
(`serverUrl`/`serverPort`). O player monta o link do canal com o definitivo.
Consequência prática: se algum fluxo seu interromper o login antes de
completar, o player fica usando o provisório — o vídeo até funciona, mas
abre com segundos de atraso (o provisório costuma ser um domínio atrás de
CDN que redireciona). Sintoma clássico: "o canal abria instantâneo e agora
demora 3–4 s". Não procure no player: procure quem parou de completar o
login.

**Rótulos dinâmicos.** Alguns textos de menu mudam conforme o banco. Ex.:
mostra "INSTALAR EPG" quando a tabela do EPG está vazia e "EPG" quando tem
dados. Se o rótulo "voltou sozinho", o dado sumiu.

---

## 6. Método de trabalho que funcionou

**Avisos de diagnóstico na tela.** Sem acesso ao logcat, a saída é colocar
`Toast` temporários nos pontos-chave e pedir prints. Foi assim que se
descobriu o ciclo que apagava o EPG.

```smali
const-string v0, "DIAG: passou aqui"
const/4 v1, 0x1
invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
move-result-object v0
invoke-virtual {v0}, Landroid/widget/Toast;->show()V
```

Melhor ainda: criar **um método único** `dbg(String)` que mostra o toast e
chamar ele de todo lugar. No fim, basta esvaziar esse método (`.locals 0` +
`return-void`) para silenciar tudo de uma vez, sem mexer nas chamadas.

**Auditar o patch antes de compilar compensa mais do que testar depois.**
Neste projeto, mandar um revisor ler o smali alterado antes de gerar o APK
reprovou a primeira versão da correção final por quatro motivos — um deles
impedia até de montar o arquivo, e os outros três causariam falha silenciosa
no aparelho. Cada rodada de "gera, divide, instala, testa" custa muito mais
tempo do que a leitura. Regra prática: **compile primeiro só para validar a
sintaxe** (`apktool b`), **revise a lógica linha a linha**, e só então
assine, divida e entregue.

**Atenção ao atraso dos toasts.** Eles entram numa fila e cada um demora
~3,5 s. Os avisos aparecem bem depois do que já aconteceu — não confie na
ordem deles para deduzir a sequência dos eventos.

**Contadores ajudam.** Numerar (`DASH #1`, `#2`, `FIRE #1`) mostra quantas
vezes uma tela foi criada e revela ciclos.

---

## 7. Editar bytecode à mão sem compilador Java (nenhum `android.jar`/`d8` disponível)

Sem SDK do Android nem compilador, toda funcionalidade **nova** (não só
correção) precisa ser escrita direto em smali. Regras descobertas na prática,
verificadas pelo verificador do ART (não é só regra do `javac`):

**Campo `final` só pode ser escrito dentro do próprio `<init>` da classe
dona.** Não dá para setar um campo final de fora, nem com `iput` direto. Se
precisar mudar algo assim depois de construído (ex.: o proxy de um
`OkHttpClient`), procure o **Builder** correspondente — o campo lá costuma
ser mutável — e refaça o objeto com `.build()` de novo, exatamente como o
próprio construtor faz internamente.

**Campo/método "package-private" (sem `public`/`private`) só é acessível de
dentro do mesmo pacote**, e isso vale no bytecode, não só na fonte. Se uma
classe nova precisa ler um campo desses de outro pacote, tem duas saídas:
(a) colocar a classe nova **no mesmo pacote** de quem tem o campo, ou (b)
adicionar um método `public static` na própria classe dona que devolve o
valor. A opção (a) foi usada duas vezes neste projeto — inclusive para
acessar um Context guardado num singleton existente sem precisar criar
nenhum parâmetro novo.

**IDs de recurso novo (layout, `@+id/...`) são só definidos depois do build**
— é uma referência circular: não dá pra hardcodar no smali um ID que só o
`aapt2` vai gerar. Solução que funcionou 100%: usar
`Resources.getIdentifier(nome, tipo, pacote)` em tempo de execução em vez de
`R.id.nome`/`R.layout.nome` fixos. Custa uma leitura a mais em tempo de
execução, mas elimina totalmente a necessidade de editar `public.xml` à mão.
Da mesma forma, textos de tela nova podem ser `const-string` +
`setText(CharSequence)` direto, sem precisar de entrada em
`res/values/strings.xml`.

**`.locals` de 16 ou mais empurra o `p0` para fora do alcance.** Com
`.locals 16` num método de instância, o `p0` vira **v16** — e `iget-object`,
`iput-object`, `move-object` e afins têm campo de registrador de **4 bits**
(v0–v15). O assembler recusa com "Invalid register: v16. Must be between v0
and v15". Solução: declarar um registrador a mais (`.locals 17`), começar o
método com `move-object/from16 v15, p0` e usar **v15 como "this"** no método
inteiro; valores que só passam por `move-result`/`move/from16` podem morar
em v16 tranquilamente. Vale conferir isso **antes** de gerar o APK — um
`apktool b` seco já acusa.

**Duas assinaturas (nome + parâmetros) iguais não podem coexistir na mesma
classe**, mesmo com retorno diferente. Ao copiar um método existente como
base para um novo, sempre trocar o nome.

**IDs de recurso do próprio Android** (não do app) são estáveis e seguros de
hardcodar sem lookup — ex. `0x1090008` = `android.R.layout.simple_spinner_item`,
`0x1090009` = `android.R.layout.simple_spinner_dropdown_item`,
`0x1020002` = `android.R.id.content`.

**Disciplina de verificação que compensou sempre:** depois de assinar,
descompilar de novo o **APK assinado** (nunca o que você editou) numa pasta
separada e conferir com `grep`/`cat` cada mudança — nome de método, campo
novo, texto de layout, `versionCode`. Pegou erro em praticamente toda rodada
deste projeto.

---

## 8. Armadilhas de ambiente e ferramentas (fora do código do app)

**Nem todo `apktool.jar` funciona.** Alguns jars "oficiais" baixados dão
`NoClassDefFoundError` (faltando dependência) ou `no main manifest
attribute`. Se acontecer, procure/gere um **fat jar** (com todas as
dependências dentro) — foi o que resolveu aqui. Teste com um `d`/`b` simples
antes de confiar no jar para o trabalho todo.

**No shell, `$` dentro de nome de arquivo é expandido pelo bash como
variável.** Um comando como `tail arquivo$a.smali` (sem aspas) vira
silenciosamente `tail arquivo.smali` porque `$a` é lido como variável vazia
— e o comando "funciona" sem erro, mostrando o arquivo errado. Sintoma que
denunciou o problema: dois arquivos "diferentes" retornando exatamente o
mesmo conteúdo. **Sempre colocar em aspas simples** qualquer caminho de
arquivo smali com `$` no nome (nomes de classe interna, tipo `Classe$a`).

---

## 9. Receita: rota alternativa (proxy) controlada pelo painel, sem nada fixo no APK

Padrão usado no TVAQUI.PRO para contornar bloqueio de operadora em alguns
clientes, reaproveitável em qualquer app desta família:

1. No painel: uma tabela/aba de "rotas" (host, porta, tipo) e um endpoint
   novo que devolve essas rotas em JSON — mesmo esquema de autenticação e
   formato que o app já usa para os outros pedidos.
2. No app: uma classe nova concentra toda a lógica (liga/desliga, automático
   ou manual, cache local via `SharedPreferences` para sobreviver mesmo se o
   pedido de "buscar rotas" falhar na hora do problema).
3. **Nunca trocar a chamada de rede original** — só envolver: tentar direto
   primeiro, e só em caso de erro (`IOException`) tentar de novo com um
   `OkHttpClient` novo (construído a partir do `newBuilder()` do original,
   com proxy setado no Builder — ver seção 7) apontando pra cada rota
   cadastrada, na ordem. Se todas falharem, relançar o **erro original**, não
   um genérico, pra não mascarar a causa real.
4. Escopo pequeno de propósito: essa rota alternativa deve cobrir só as
   chamadas pequenas de API (config, avisos, listas), **nunca** o tráfego de
   vídeo — isso evitaria adicionar lentidão onde não precisa e mantém a
   solução simples de manter.
5. Nada de endereço de proxy fixo no APK: tudo vem do painel, então trocar,
   desativar ou adicionar rota nunca exige nova versão do app.

---

## 9b. Duas lições sobre "deixar configuração pronta de fábrica"

Vale para qualquer app dessa base, porque a estrutura de preferências é a
mesma.

**Lição 1 — antes de escrever código, confira o default que já existe.**
Metade dos pedidos de "deixar isso marcado na instalação" já é o padrão de
fábrica; o cliente só está mostrando a tela dele *depois* de ter configurado.
Nesta base, `b/b/l.smali` concentra os getters e o segundo argumento do
`getString`/`getBoolean` é o default. Confirmado assim que ordenação
(`LiveSort`, `VODSort`, `SeriesSort`, `PlaylistSort`, `*catsort` — todos `"0"`,
que cai no rádio "Padrão") e "Autoiniciar quando Ligar"
(`auto_start_on_bootup`, default `""` ≠ `"checked"`) **já vinham certos**.
Mudança que não precisa ser feita é a mais segura de todas.

**Lição 2 — escolha a técnica pelo tipo de valor guardado.**

- Se a preferência guarda um valor **estável** (nome de idioma, número, flag),
  o mais simples é uma **gravação única** num método estático chamado no
  começo do `SplashActivity.onCreate`, protegida por `contains()` para não
  atropelar a escolha do usuário e envolvida em try/catch. Foi o caso do
  idioma, que nessa base fica em **duas** preferências diferentes
  (`LanguageSelectionPref/SelectedLanguage` e
  `selected_language/selected_language`) com dezenas de pontos de leitura —
  mexer em cada leitura seria muito mais arriscado do que gravar o valor uma
  vez. Confirme antes que nada lê aquele valor antes do Splash: procure
  Application custom, `attachBaseContext` e `ContentProvider` no manifesto.
- Se a preferência guarda um **texto traduzido** — e nessa base o
  decodificador do player guarda literalmente o texto do rádio ("Nativo",
  "Decodificador de Hardware") — **não grave string nenhuma**. Grave e o valor
  vira lixo se o idioma mudar (ou se ainda não tiver sido aplicado no primeiro
  arranque). O certo é mudar o **default da leitura**: trocar
  `getString(chave, "")` por `getString(chave, getResources().getString(R.string.X))`.
  Assim "nunca escolhido" passa a significar a opção desejada em qualquer
  idioma, quem já escolheu mantém a escolha, e nada é gravado. Só compensa
  quando os pontos de leitura são poucos — aqui eram dois.

**E confira o que o valor realmente faz.** No caso do decodificador, "Nativo"
não é cosmético: `view/ijkplayer/a/a;->b()I` retorna `3`, e o `3` desvia o
roteamento do player inteiro para as Activities ExoPlayer em vez das IJK.
Rastreie o retorno do getter antes de mudar o default dele.

---

## 9c. Automatizar um clique sem prender o usuário na tela

Complemento da seção 5: depois de fazer o app "apertar um botão sozinho"
(construir o `OnClickListener` real e chamar `onClick(null)`), sobra um
problema de UX que passa despercebido — a automação dispara em **toda** entrada
naquela tela, inclusive quando o usuário foi até lá de propósito.

Receita que resolveu, com duas travas independentes:

1. **Marcar a origem no Intent.** Quem abre a tela *automaticamente* faz
   `intent.setAction("marca_sua")`; quem abre por navegação manual não faz
   nada. A automação só dispara se `getIntent().getAction().equals("marca_sua")`.
   Use `String.equals` com a constante à esquerda (`"marca".equals(action)`) —
   é seguro contra `null`.
2. **Uma vez por instância.** Um `.field boolean` na Activity, setado antes de
   disparar. Protege o caso de o usuário voltar de BACK para a mesma instância
   e o callback rodar de novo.

Duas dicas de execução:

- Mapeie **todos** os `const-class ... SuaActivity` do APK e classifique cada
  um: arranque ou manual. Aqui eram 11, e três precisavam da marca (dois no
  `SplashActivity.f()`, um no `RoutingActivity.a()`) — mais um quarto que a
  auditoria pegou e eu tinha esquecido: um botão que existia justamente para
  refazer o login.
- Confirme que o `false` da automação **restaura o comportamento original** em
  cada ramo que a chama. Comparar com uma versão anterior descompilada
  (`verifyNN/`) é o jeito mais rápido de provar isso.

---

## 9d. Três armadilhas que só aparecem na hora de "deixar pronto de fábrica"

**Backup de arquivo de `res/` nunca fica dentro de `res/`.** Ao editar layouts em
massa é natural salvar um `arquivo.xml.bak` ao lado. O aapt2 trata **qualquer**
arquivo sob `res/layout*/` como recurso: o APK sai com os backups embutidos, com
os layouts ANTIGOS, e a tabela de recursos ganha entradas fantasma. Guarde
backups fora da árvore `res/` (ou fora da pasta decodificada) e confira com
`find res -name "*.bak*"` antes de compilar.

**"Default de leitura" só funciona quando os pontos de leitura são poucos.**
Vale contar antes de escolher a técnica: o decodificador do player tinha 2
leituras (deu para mudar o default), o formato de fluxo tinha 48 ocorrências em
13 arquivos (não deu — foi por gravação). E cuidado com um caso escondido: uma
tela pode mostrar um valor lido de uma preferência **e** o comportamento real
vir de outra. O "Autoiniciar quando Ligar" desse app fazia isso — a caixinha
lia `auto_start` com default `true`, e o receiver de `BOOT_COMPLETED` lia a
mesma chave com default `false`. A caixinha aparecia marcada e o app não
iniciava. Sempre rastreie os dois lados: quem **mostra** e quem **age**.

**`contains()` não basta se o app for atualizado por cima.** A guarda
`if (!prefs.contains(chave)) grava o padrão` é a certa para não atropelar a
escolha do usuário — mas numa atualização sem desinstalar as SharedPreferences
sobrevivem, e se o próprio app já gravou um valor no primeiro login (essa base
faz isso com `allowedFormat`), o padrão novo nunca entra. Quando o objetivo é
corrigir também quem já tem o app instalado, troque por um **marcador de
aplicação única**: uma preferência própria (`tvaqui_defaults` / `v2`) que, se
ausente, autoriza gravar os valores uma vez e então se marca. Corrige o parque
instalado uma única vez e devolve o controle ao usuário depois. Versione o
marcador (`v2`, `v3`…) para poder repetir a operação numa entrega futura.

---

## 9e. Padrão de ícone do app (vale para TODOS os apps que mexermos)

Decidido com o TVB em 10/09/2026, depois de ver o ícone do TVAQUI.PRO no
celular. **Aplicar este mesmo padrão em qualquer app da carteira.**

**O problema.** O ícone original vinha com **fundo transparente**. Launcher de
Android moderno não deixa ícone legado solto: ele desenha um círculo (ou
squircle) **branco** por baixo e **encolhe** a arte para ~66% do quadro. O
resultado é um ícone que parece pequeno e perdido no meio do espaço — foi
exatamente a reclamação. Pior: se a marca tem texto branco, ele **some** sobre
o círculo branco do launcher.

**A regra.** O PNG do ícone tem de trazer **a sua própria placa de fundo,
opaca, ocupando o quadro inteiro**, com cantos arredondados. Aí o launcher não
tem o que inventar e a arte ocupa o tile todo.

**Especificação:**

| Item | Valor |
|---|---|
| Fundo | **branco**, opaco, cobrindo 100% do quadro |
| Cantos | arredondados, raio ≈ **22%** do lado |
| Arte | logo completo (marca + nome), **96% da largura** (margem de 2% de cada lado), centralizado |
| Critério do nome | o nome da marca em **uma linha só**, indo de ponta a ponta |
| Origem da arte | o logo em **alta resolução** (o do TVAQUI tem 4000×2547), recortado no conteúdo real (sem a moldura transparente do arquivo) e reduzido com LANCZOS |
| Densidades | mdpi 48, hdpi 72, xhdpi 96, xxhdpi 144, xxxhdpi 192 — sempre gerar cada uma a partir do original, nunca ampliar a menor |

**Por que branco e não preto.** A versão preta foi testada e reprovada: nessa
marca a antena da TV é **preta** e as letras brancas têm **contorno preto** —
sobre placa escura os dois desaparecem. Regra geral: escolha a cor da placa
olhando os detalhes **mais finos** do logo, não o elemento principal. Branco
ainda tem a vantagem de funcionar igual em gaveta clara e escura.

**O que NÃO fazer:** não converter para *adaptive icon*
(`mipmap-anydpi-v26/ic_launcher.xml`). O Android recorta o adaptive icon numa
zona segura de ~66%, e um logo que é uma **palavra larga** perde as pontas.
Para marca com wordmark, PNG legado com placa própria é melhor.

**Como gerar (Python/PIL, ~20 linhas):** recortar o bbox alfa do logo original;
criar quadrado S×S branco com `rounded_rectangle(radius=0.22*S)` como máscara;
colar o logo redimensionado para `0.96*S` de largura, centralizado; salvar nas
5 densidades. Conferir no fim que os 5 arquivos existem e têm o tamanho certo.

---

## 9f. Repaginar o visual dos botões sem estragar o layout

Aprendido no TVAQUI.PRO v52 → v53. Nesta base (WHMCS Smarters / IPTV
Smarters) os botões da tela inicial usam **PNG** como `android:background`
(`live_tv_background.png`, `green_background.png`, e os `*_focused.png`),
sempre 271x138 px e com o **mesmo arquivo repetido nos 7 buckets de
densidade**. Três coisas quebram se você trocar esse PNG por um `<shape>`:

1. **O PNG é o que segura o tamanho de botão `wrap_content`.** Um
   `BitmapDrawable` de fundo define o tamanho mínimo da view
   (`View.getSuggestedMinimumWidth/Height` usa o tamanho intrínseco do
   bitmap). Um `<shape>` sem `<size>` tem tamanho intrínseco zero, então
   a view encolhe até o conteúdo. Foi o que sumiu com os botões DNS/VPN.
2. **Encolher um botão de baixo estica os de cima.** A faixa de baixo é
   `wrap_content` e os tiles ficam num bloco com `layout_weight`; tudo que
   a faixa deixa de ocupar vai para o bloco com peso. Os tiles pularam de
   209px para 270px de altura sem ninguém ter tocado neles.
3. **As margens transparentes do PNG fazem parte do desenho.** Nesses PNGs
   as linhas 0..6 e 133..137 são transparentes, então o cartão visível é
   ~9% menor que a view. Um `<shape>` pinta 100% da view e o botão "engorda".

**Receita segura:** gere a arte nova como **PNG com as mesmas dimensões e as
mesmas faixas transparentes do original**, com nomes novos (nunca sobrescreva
os originais — eles são compartilhados por outros layouts), copiada nos 7
buckets. Os `<selector>` novos vão em `drawable/` **e** em
`drawable-v21/`, neste último envoltos em `<ripple android:color="@color/black">`,
copiando a estrutura dos `ripple_effect.xml`/`riple_green.xml` originais —
senão o efeito de toque do Android 5+ some.

**Para aumentar botão sem mudar de lugar:** mexa nas margens do próprio tile
(ex. 10dip → 2dip nos quatro lados). Ele cresce para os dois lados a partir do
mesmo centro. Mexer nos pesos do container move a fileira inteira.

**Para alinhar a faixa de baixo com os tiles:** dê à faixa o mesmo número de
colunas dos tiles via `weightSum` (6 tiles → `weightSum="6.0"`) e coloque
cada botão numa coluna de peso 1.0.

**Ícone colorido não leva `android:tint`** — tint achata o PNG numa silhueta
de uma cor só. Tint serve para ícone branco/silhueta.

**Confira sempre se algum ID de recurso já existente mudou.** Recursos novos
empurram a numeração dos que não estão fixados no `public.xml`. Compare o
`public.xml` do APK antigo com o do novo; se um ID que mudou for referenciado
por constante no smali (`const v0, 0x7f08....`), o app passa a apontar para o
recurso errado. Referência por nome em XML é segura.

## 9g. Deixar a ordenação escolhida de fábrica

Pedido do cliente em 13/09/2026, para valer em **todos** os apps dessa linha:
canais em **A-Z**, filmes em **Últimos Adicionados**, séries em **Últimos
Adicionados**.

Nesses apps a ordenação dos ITENS fica num único arquivo de SharedPreferences
chamado **`IPTVSort`** (o nome vem de um campo estático em
`miscelleneious/b/a`), com três chaves de tipo String:

| Tela | Chave | Valores |
|---|---|---|
| Canais ao vivo | `LiveSort` | 0=Padrão · 1=Últimos Adicionados · **2=A-Z** · 3=Z-A · 4=nº canal ASC · 5=nº canal DESC |
| Filmes | `VODSort` | 0=Padrão · **1=Últimos Adicionados** · 2=A-Z · 3=Z-A |
| Séries | `SeriesSort` | 0=Padrão · **1=Últimos Adicionados** · 2=A-Z · 3=Z-A |

Três armadilhas:

1. **O valor é uma String NUMÉRICA, não o texto do rádio.** O `onClick` do
   "SALVAR ALTERAÇÕES" lê o texto do RadioButton, compara com
   `getString(R.string.sort_atoz)` etc. e converte para o código. Grave o
   código. (Contraste com a preferência do decodificador, seção 9b, que guarda
   o texto traduzido.)
2. **Não confunda com a ordenação das CATEGORIAS**, que usa outras chaves
   (`livecatsort`, `vodcatsort`, `seriescatsort`) e um esquema diferente
   (0=Padrão, 1=A-Z, 2=Z-A).
3. **O default de leitura é `"0"`**, que na consulta SQL sai sem `ORDER BY` —
   ou seja, a ordem que o servidor mandou.

**Como aplicar:** dentro do método de defaults chamado no
`SplashActivity.onCreate`, um bloco protegido por um **marcador de aplicação
única** novo (preferências `tvaqui_defaults`, chave booleana — use uma letra
nova a cada rodada: `v2`, `v3`, …). Marcador, e não `contains()`, porque
`contains()` nunca pegaria quem já tem o app instalado. Depois que o marcador
é gravado, a escolha do usuário no diálogo volta a mandar.

Onde procurar em outro app da família: `getSharedPreferences` com o nome do
arquivo de sort; os getters de sort na classe utilitária (`b/b/l` aqui); e os
`$N.smali` anônimos das Activities de lista e do player para confirmar o
código de cada opção.

## 9h. Trocar o papel de parede em TODAS as telas

Aprendido no TVAQUI.PRO v58. O cliente trocou o fundo e reclamou que ele só
aparecia na tela inicial e na de usuários.

**Causa:** nesses apps o mesmo papel de parede está **duplicado em vários
drawables de nomes diferentes**, um por tipo de tela. No TVAQUI.PRO eram
**13 arquivos com md5 idêntico**: `main_bg`, `login_new_bg`,
`layout_background_tv` (listas de canais), `vod_backgound` (filmes e séries),
`account_background`, `background_screen_sky` (fundo do player),
`epg_timeline_background`, `movie_info_bg`, `parental_control_background`,
`player_selection_background`, `settings_screen_bg_tv`,
`stream_format_background`, `time_format_background`, `tv_guide_epg_background`.

**Receita:** ache todos de uma vez comparando md5 —

```bash
cd decoded/res
md5sum drawable*/*.jpg | sort | uniq -c -w32 | sort -rn | head
```

O grupo com mais ocorrências é o papel de parede. Sobrescreva **o conteúdo**
de todos eles com a imagem nova, mantendo nome, extensão e os buckets de
densidade. Assim **nenhum XML e nenhum smali precisa mudar**, nenhum id de
recurso é criado ou renumerado, e o resultado fica idêntico em todos os
aparelhos de graça.

**Detalhe que economiza tempo:** o fundo das telas de lista pode não estar no
XML. No TVAQUI.PRO as Activities de canais/filmes/séries chamam
`appbarToolbar.setBackground(R.drawable.…)` no `onCreate` — o XML raiz não tem
`android:background` nenhum. Se você procurar só nos layouts, não acha. Procure
a constante do drawable no smali da Activity.

**Legibilidade:** essas telas desenham caixas semitransparentes por cima
(`#96000000` nas categorias, `#90000000` na faixa do título do cartaz), então
texto branco continua legível sobre foto. Se ficar ruim, o caminho mais seguro
é gravar uma versão já escurecida do JPG, e não mexer em XML/smali.

## 9i. Telas de importação que travam para sempre (sem erro)

Aprendido no TVAQUI.PRO v59. Sintoma: com um servidor da lista de DNS fora do
ar, o app ficava girando eternamente na tela "Baixando a guia de TV", **sem
nunca dar erro**, e só limpar os dados resolvia.

**Causa:** nesta base a rede NÃO é Retrofit/OkHttp — é `java.net` puro. Em
`view/utility/b.smali` o download do EPG faz
`new URL(...).openStream()`, que usa `HttpURLConnection` com
`connectTimeout`/`readTimeout` **= 0 = espera infinita**. Servidor que aceita o
TCP mas não responde trava a thread para sempre: o `onPostExecute` do
AsyncTask nunca roda, o `finish()` nunca acontece, e o `catch` nunca dispara
(nem log sai).

**Agravante que explica "voltar não adianta":** antes de baixar, o app grava
no banco o status `EPG/2/"Processing"`, e só grava `"Finished"` no
`onPostExecute`. A tela inicial consulta esse status e **reabre** a tela de
EPG. Fica um ciclo fechado.

**Correção (uma instrução):** trocar `openStream()` por
`openConnection()` + `check-cast HttpURLConnection` +
`setConnectTimeout(0x7530)` + `setReadTimeout(0x7530)` + `getInputStream()`,
dentro do try/catch que já existe. Com timeout, estoura
`SocketTimeoutException`, cai no catch existente, a lista volta vazia e o
fluxo segue pelo ramo "sem EPG" que **já está pronto** (grava `"Finished"` e
vai para a Dashboard). O app já usa 30000 ms em outros pontos
(`MultiUserAdapter$c`, `NewDashboardActivity$d`, `LoginM3uActivity$c`) — use o
mesmo valor.

**Mesmo defeito latente**, para aplicar junto se o app usar M3U:
`ImportM3uActivity$a`, `LoginM3uActivity$a` e `MultiUserAdapter$a` têm o mesmo
`openStream()` sem timeout.

**Regra geral:** em qualquer app dessa linha, procure `openStream(` no smali.
Todo ponto que aparecer é um travamento eterno esperando acontecer.

## 9j. Não blinde contra causa não provada

Aprendido no TVAQUI.PRO v59, com duas reprovações seguidas de auditoria.

Um TV Box abria a tela inicial sem nenhum dos seis botões. A hipótese era que
o PNG de fundo das pílulas DNS/VPN (271x138 px, gravado **igual em todos os
buckets** de densidade) virava 92–184dp em aparelho de densidade baixa e comia
a altura da fileira.

Duas lições ficaram:

1. **`android:minHeight` é inerte num filho `layout_height="0dip"` +
   `layout_weight`.** O LinearLayout mede esse filho com `MeasureSpec.EXACTLY`
   igual à fatia calculada, e `EXACTLY` ignora o mínimo. Para ter piso real é
   preciso tirar o peso ou mudar a estrutura — o que troca um tamanho
   proporcional por um fixo, e isso é regressão.
2. **Faça a conta antes de mexer.** Simulando sete configurações de TV Box
   (720p e 1080p, densidades 1.0 / 1.33 / 1.5 / 2.0), a fileira nunca ficava
   menor que o conteúdo — a hipótese não explicava o defeito. A correção teria
   deixado as pílulas visivelmente menores (a arte é 1,96:1 e não é
   nine-patch) e subido a tela inteira nos aparelhos que já funcionam.

Conclusão registrada: sem a resolução e a densidade reais do aparelho que
falha, não se mexe. Peça o dado, ou entregue uma versão de diagnóstico que
mostre as medidas na tela — foi assim que a causa raiz do playback foi provada
na v46-DIAG.

## 9k. Tela inicial que abre vazia em Smart TV — como investigar sem chutar

Sintoma dessa base: cabeçalho e barra de baixo aparecem normalmente e o miolo
com os botões principais fica em branco — nem desenho, nem texto. Já apareceu em
Smart TV Android (SEMP TCL 55P635, Samsung) e em TV Box (Proeletronic Smart PRO).

**Ordem de investigação que funciona (do mais barato para o mais caro):**

1. **Descarte código antes de culpar layout.** Grep de `setVisibility`,
   `setLayoutParams`, `removeView`, `setAlpha`, `setScaleX` na Activity e em
   TODAS as classes internas (`Activity$*.smali`). Nessa base os botões do
   dashboard não são tocados por nenhum deles.
2. **Confirme que as views existem.** Se o binding é ButterKnife com
   `butterknife/a/b;->a(View,int,String,Class)` (= `findRequiredViewAsType`),
   ele **lança exceção** quando a view não existe. App que não fecha = views
   infladas e ligadas. Isso sozinho elimina "layout errado foi inflado".
3. **Confirme qual layout é inflado.** Procure o `setContentView` e resolva a
   constante no `res/values/public.xml`. Nessa base a escolha vem de constantes
   de compilação num `miscelleneious/b/a.smali` que **nunca** são reescritas em
   runtime — ou seja, é o mesmo layout em todo aparelho.
4. **Procure detecção de TV.** `UI_MODE_TYPE_TELEVISION`, `FEATURE_TELEVISION`,
   `android.software.leanback`, `UiModeManager`, `hasSystemFeature`. Nessa base
   **não existe**, e o `LEANBACK_LAUNCHER` do manifesto aponta para a mesma
   SplashActivity. Sem isso, TV e celular seguem o mesmo caminho.
5. **Só então some a conta de altura do layout.** Nessa base a fileira de botões
   fica dentro de uma faixa com `weight 99` de `weightSum 100`, e **metade dessa
   faixa é um `<LinearLayout>` vazio com `weight 2.0`**. Somando o
   `paddingTop`/`paddingBottom` da raiz e o cabeçalho fixo, a conta é
   `altura_fileira ≈ 0,495 × (alturaDaJanelaEmDp − 206dp)`. Compare com o
   conteúdo mínimo de um botão (ícone + margem + texto). Se a fileira ficar
   menor, `gravity="center"` corta o ícone e joga o texto para fora — dá
   exatamente "vazio, nem o texto".

**O teste que fecha o caso em 30 segundos**, com o aparelho por ADB e a tela
aberta:

```
adb shell uiautomator dump /sdcard/d.xml && adb pull /sdcard/d.xml
```

Olhe o `bounds` dos nós dos botões: altura ~0 = **geometria**; bounds normais e
tela em branco = **pintura** (drawable/GPU do aparelho), e a investigação vira
outra. E `adb shell wm density 240` (depois `reset`) falsifica a hipótese de
geometria sem tocar no APK.

**Sem ADB:** reative um método de log morto da Activity (nessa base o `dbgE` é
um `return-void` puro) e faça ele escrever resolução, densidade e altura em dp.
Gera uma versão de diagnóstico sem inventar layout novo.

---

## 9l. OkHttp antigo: ter timeout não é ter prazo

Nessa base o `OkHttpClient.Builder` configura connect/read/write, mas a versão
embarcada é anterior à 3.12 — a classe do builder só tem os campos de
connect/read/write/ping e **não existe `callTimeout`**. Consequência prática:

- servidor que **não responde** → estoura o connect timeout, tudo bem;
- servidor que responde `200 OK` e manda o JSON **a conta-gotas** → cada leitura
  individual chega antes do prazo, o read timeout nunca dispara, e a tela espera
  para sempre.

É o mesmo buraco do `URL.openStream()` sem timeout, só que disfarçado de
"já tem timeout configurado". **Não confie no builder: confira a versão do
OkHttp antes de dar o caso por resolvido.**

O remédio confiável em APK modificado não é mexer no OkHttp, é **um watchdog na
tela**: `Handler.postDelayed` no `onCreate` que, passado o prazo, tira o usuário
dali. Vale também quando a cadeia de passos é sequencial e o elo seguinte é
chamado pelo `onPostExecute` de um AsyncTask — se o AsyncTask morrer, nenhum
timeout de rede salva a tela.

---

## 9m. Catch que só loga é armadilha de travamento

Padrão encontrado nas gravações em lote dessa base: `.catch` de
`SQLiteException` cujo corpo só faz `Log.w` e **não chama `endTransaction()`
nem `close()`**. Resultado: transação e conexão ficam abertas, a próxima
operação trava esperando o lock, e a tela congela **sem erro nenhum na
interface**. Quando estiver caçando "tela que trava e não dá mensagem", procure
esse padrão antes de olhar a rede — sintoma idêntico, causa completamente
diferente.

---

## 9n. "Os botões somem" em TV: foco funciona, desenho não

**A armadilha que custou três rodadas de investigação neste projeto:** o cliente
relata que a tela inicial abre sem os botões. Você testa a navegação pelo
controle e descobre que **os botões pegam foco e abrem a tela certa**. A
conclusão intuitiva — "então eles têm tamanho, o problema é de pintura" — está
**ERRADA**.

`View.canTakeFocus()` só passou a exigir tamanho maior que zero no **Android 9
(API 28)**. Abaixo disso, uma view de altura ZERO continua no circuito de foco e
continua respondendo ao OK do controle. E TV Box, Fire Stick e Smart TV Android
baratas rodam 7.1 / 8.1 em massa.

**Regra:** em aparelho abaixo da API 28, "pega foco e clica" **não** prova que a
view tem tamanho. Só `uiautomator dump` ou uma medição em runtime prova.

### A conta que faz a fileira sumir

O layout dessa base empilha, na vertical: padding da raiz + cabeçalho de altura
**fixa** + uma faixa com `weight 99` de `weightSum 100` + a barra de baixo. E
dentro da faixa existe um `<LinearLayout>` **vazio** com `weight 2.0` de
`weightSum 4.0`, que sozinho consome metade dela.

```
altura_fileira ≈ 0,495 × (altura_util_dp − padding − cabecalho_fixo)
```

Como o cabeçalho é fixo em dp e o padding também, em tela que reporta pouca
altura em dp eles comem tudo e a fileira vai a zero. O cabeçalho e a barra de
baixo continuam aparecendo porque **não dependem de peso** — e é isso que faz o
defeito parecer "só o meio sumiu".

### O conserto que não pode quebrar quem está bem

Não mexa no XML: qualquer ajuste de peso muda TODOS os aparelhos. Faça em
runtime, com um `Runnable` postado no `onResume`, em dois passos:

1. mede a altura real da fileira e compara com o mínimo do conteúdo
   (ícone + margem + texto). **Se está bom, retorna sem tocar em nada** — este é
   o caminho de 100% dos aparelhos saudáveis, e é o que garante zero regressão;
2. se está pequena: primeiro só o que não tem efeito colateral — zerar o padding
   da raiz e esconder o espaçador vazio (passando o `weightSum` do pai para o
   valor sem ele);
3. remede uns 700ms depois e **só então**, se ainda faltar, encolha o cabeçalho —
   lembrando de encolher a logo junto (`setAdjustViewBounds(true)` +
   `FIT_CENTER`), porque `RelativeLayout` recorta o filho em vez de
   redimensionar.

Cuidados obrigatórios ao subir a árvore com `getParent()` às cegas: confirme que
o "espaçador" que você vai esconder **não tem id** (`getId() == -1`) e **não tem
filhos** (`getChildCount() == 0`). Sem essas travas, se um dia o app inflar outro
layout você esconde o cabeçalho inteiro. Envolva tudo em `try/catch Throwable`.

Use valores **absolutos** (altura = 56dp, padding = 0), nunca incrementais — o
`onResume` roda toda vez que a tela volta, e o conserto precisa ser idempotente.

---

## 9o. Watchdog de tela: prazo cego é regressão

Um `Handler.postDelayed` que mata a tela depois de N minutos resolve o
travamento eterno **e cria um defeito novo**: o cliente de lista grande com
servidor lento, que hoje só espera, passa a ser expulso com o banco pela metade.

O prazo tem que olhar **progresso**, não relógio. Nessa base existe um contador
de passos concluídos (`h`) com acessor sintético — o watchdog lê esse contador e
**só age se ele ainda estiver zerado**. Qualquer passo que tenha respondido,
mesmo com erro, significa "o servidor está vivo, deixa terminar".

E calibre o prazo **acima do pior caso do seu próprio cliente HTTP**: com
connect 60s + read 60s, um prazo de 90s corta conexões que ainda iam funcionar.
150s é o mínimo defensável.

Por fim: guarde o `Handler` num campo e cancele com
`removeCallbacksAndMessages(null)` num `onDestroy()`, senão o watchdog dispara
sobre uma Activity que já saiu e arrasta o usuário de volta para a tela inicial
minutos depois.

---

## 9p. `new Configuration()` em branco apaga a tela inteira

A armadilha mais cara deste projeto, e ela está em **todo** app dessa linha.

A rotina que aplica o idioma faz isto:

```smali
new-instance p1, Landroid/content/res/Configuration;
invoke-direct {p1}, Landroid/content/res/Configuration;-><init>()V   # EM BRANCO
iput-object v2, p1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;
invoke-virtual {v0, p1, v1}, Landroid/content/res/Resources;->updateConfiguration(...)V
```

Uma `Configuration` recém-criada tem `screenLayout`, `orientation`,
`smallestScreenWidthDp`, `screenWidthDp` e `screenHeightDp` **zerados**.
Mandar isso para `updateConfiguration` faz o `Resources` perder as medidas da
tela. A partir daí, os qualificadores (`layout-large-land`, `values-sw600dp`,
densidade) resolvem errado, e o layout colapsa em aparelho que depende deles —
exatamente TV Box e Smart TV.

E essa rotina roda no **`onResume` de cada Activity**, via `d.j(Context)`.

O detalhe que fecha o caso: ela só roda **quando `selected_language` está
preenchido**. Num app de fábrica o campo está vazio, então o defeito fica
dormindo. Ele acorda no dia em que você deixa um idioma escolhido de fábrica —
e aí o problema parece ter "começado do nada", três versões depois da causa.

**Correção:**

```smali
new-instance p1, Landroid/content/res/Configuration;
invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;
move-result-object v3
invoke-direct {p1, v3}, Landroid/content/res/Configuration;-><init>(Landroid/content/res/Configuration;)V
iput-object v2, p1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;
```

**Regra geral: sempre que for mexer numa `Configuration`, copie a atual.**
Nunca crie uma em branco. Vale também para `createConfigurationContext`.

Procure isso em qualquer app dessa linha **antes** de deixar idioma de fábrica.

---

## 9q. Carimbo de "já fiz isso" tem três armadilhas

Pular trabalho repetido (reimportar a lista toda a cada abertura) é o maior
ganho de velocidade que existe nesses apps. Mas um carimbo de data mal feito
cria um defeito que o suporte não resolve sem mandar limpar dados.

**Armadilha 1 — carimbar antes de terminar.** O lugar "natural" de escrever o
carimbo é no começo do método que recebe o último passo. Errado: esse método
costuma ter um ramo de **erro** logo abaixo, e a gravação real acontece dentro
de um `AsyncTask` que nem começou. Resultado: a importação falha, o app entra
sem as séries, o cliente fecha e reabre — e **nada acontece pelas próximas 12
horas**, porque o carimbo já está lá.

O carimbo tem que ser escrito no `onPostExecute` do último `AsyncTask`, **depois**
de conferir o contador de erros:

```smali
invoke-static {v0}, ...->e(...)I      # contador de falhas
move-result v1
if-gtz v1, :tv_nostamp                # teve erro -> nao carimba
```

**Armadilha 2 — carimbo global com usuário trocado.** Se a chave for só
`last_full_sync`, o revendedor testa outra conta e o app mostra a lista da conta
anterior, sem reimportar. Grave também `last_full_sync_user` (o `username` de
`loginPrefs`) e só pule se bater:

```smali
invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
move-result v2
if-eqz v2, :tv_import
```

**Armadilha 3 — relógio para trás.** TV Box e Fire Stick sem bateria de RTC
sobem com a data errada e só corrigem depois do NTP. Se o carimbo for gravado
nessa janela, `agora - carimbo` fica **negativo**, o teste `if-gez` não dispara
e o app pula a importação **para sempre**, até a data real alcançar o carimbo.
Teste o limite de baixo também:

```smali
sub-long/2addr v4, v2
const-wide/16 v6, 0x0
cmp-long v1, v4, v6
if-ltz v1, :tv_import      # relogio para tras -> importa
const-wide/32 v6, 0x2932e00
cmp-long v1, v4, v6
if-gez v1, :tv_import      # passou do prazo -> importa
```

E um quarto cuidado que não é armadilha, é requisito: **o pulo não pode engolir
Intent com `action`**. Os redirects (`redirect_live_tv`, `redirect_vod`,
`redirect_series`, `redirect_catchup`) chegam nessa mesma Activity. Teste a
action antes de qualquer coisa e mande para o caminho normal se houver uma.

---

## 9r. `CREATE INDEX` não é de graça na thread da tela

Esses APKs não têm **nenhum** índice no SQLite. Criar um em
`iptv_live_streams(categoryID)` derrubou a lista de TV AO VIVO de 5s para 1s.
Vale muito a pena.

Mas `CREATE INDEX IF NOT EXISTS` na **primeira** vez faz varredura completa da
tabela, ordenação e escrita da B-tree, com journal. Numa tabela de dezenas de
milhares de canais, em eMMC de TV Box, isso é da ordem de **segundos**. E o pior
momento possível é justo o primeiro retorno à tela inicial depois de importar,
quando a tabela está no tamanho máximo e o `AsyncTask` de importação ainda pode
estar segurando o lock de escrita — aí a tela fica esperando o lock, sem
responder ao controle, e pode dar ANR no Android 5/6/7.

`try/catch Throwable` evita o crash, **não** evita o congelamento.

**Regra:** índice se cria em thread de fundo, uma vez por sessão, com uma trava
estática. Se já existe uma `Thread` sendo criada no `onResume` para outra coisa,
aproveite ela em vez de criar outra.

---

## 9s. Atualização dentro do app num parque antigo

Recurso simples de descrever e cheio de detalhe que só aparece em campo.

**O desenho:** uma classe que implementa `Runnable` e
`DialogInterface$OnClickListener` ao mesmo tempo, com um campo `m` que diz em
qual etapa ela está (0 consulta, 1 janela, 2 download, 3 instalar, 4 erro).
`run()` despacha pelo `m`. Assim uma classe só atravessa thread de fundo e
thread da tela sem nenhuma classe interna.

**Cinco coisas que quase ficaram erradas:**

1. **Trava de "já consultei" marcada antes da rede.** Em TV Box o app costuma
   abrir **antes do Wi-Fi subir**, então falhar na primeira tentativa é o caso
   comum, não o raro. Se a trava for marcada antes e não for liberada no
   `catch`, o recurso morre até o app ser fechado por completo. **Libere a trava
   no `catch`.**

2. **HTTPS sozinho não alcança o parque antigo.** Android 5, 6 e 7.0 não têm a
   raiz ISRG Root X1 da Let's Encrypt. O handshake falha, a exceção é capturada,
   e o recurso fica **invisível** exatamente em quem você queria atingir. Tente
   https e **caia para http** se falhar. O conteúdo é um número de versão e um
   link — não há o que proteger. (O app já tem `usesCleartextTraffic="true"`.)

3. **`Toast` dentro do `catch` sem `try` próprio.** No Android 7.1 existe o
   `BadTokenException: token android.os.BinderProxy is not valid` quando o Toast
   sai com o token da Activity já inválido. Se o handler de erro estiver fora de
   qualquer `try`, o app **inteiro** morre — justo no caminho de erro. Todo
   handler de erro que toca a tela precisa do seu próprio `try/catch`.

4. **FileProvider.** Não precisa criar um: esses apps já têm um
   (`<provider>` no manifesto, `res/xml/provider_path.xml` com
   `<external-path path="."/>`). Esse `path="."` ancora em
   `Environment.getExternalStorageDirectory()`, e `getExternalFilesDir(null)`
   fica embaixo dela — então serve. Use `FileProvider.getUriForFile` a partir do
   SDK 24 e `Uri.fromFile` abaixo, com `FLAG_GRANT_READ_URI_PERMISSION` e
   `FLAG_ACTIVITY_NEW_TASK`. E adicione
   `REQUEST_INSTALL_PACKAGES` ao manifesto (é permissão normal, concedida na
   instalação, sem diálogo).

5. **Montagem do link.** Acrescentar `?v=<numero>` para furar cache quebra se o
   link já tiver query string. Teste o `?` e use `&v=` nesse caso.

**No painel:** guarde número, nome, link, mensagem, "obrigatória" e "ativo".
O número é o `versionCode` — é ele que o app compara. O "ativo" é o botão de
pânico: achou problema na versão nova, desmarca e ninguém mais é avisado.

---

## 9t. O endereço do painel é o ponto único de falha do app inteiro

Todo app dessa linha tem **um** endereço de painel gravado no APK (no TVAQUI.PRO
era `https://sm.wctvapp.com/aq/api/home.php?`, do vendedor do script). Se esse
domínio morre, vence ou é bloqueado, **todo aparelho em campo fica órfão** e a
única saída é recompilar e pedir reinstalação para cada cliente.

Não é hipótese: um final de domínio inteiro pode cair de uma vez.

**O desenho que resolve, e que vale para qualquer app dessa linha:**

1. **Várias sementes, num campo só.** Grave 2 ou 3 endereços, em domínios
   diferentes, numa única constante separada por vírgula. O app tenta um por um
   até alguém responder. Trocar endereço vira trocar uma linha.

   ```smali
   .field public static final SEM:Ljava/lang/String; = "a.dom1.net/pro,b.dom2.me/pro"
   ```

2. **O painel publica a lista atual; o app aprende.** Toda resposta traz um campo
   `espelhos`. O app guarda no aparelho e tenta a lista guardada **antes** das
   sementes. Assim dá para acrescentar endereços novos anos depois, sem
   recompilar nada.

   A pegadinha: o espelho só chega em quem **conseguiu falar com o painel**.
   Cadastrar depois da queda não alcança ninguém. Isso tem que estar escrito na
   tela do painel, senão o dono não cadastra.

3. **Um painel de verdade, espelhos burros.** Nos outros domínios não vai o
   painel — vai um PHP de 4 KB que repassa a pergunta e guarda a última resposta
   boa. Sem banco, sem login. O dono continua publicando num lugar só, e se o
   principal cair o espelho serve o cache.

**Três detalhes que decidem se funciona:**

- **Domínios diferentes de verdade.** Dois subdomínios do mesmo domínio caem
  juntos. Dois nomes no mesmo provedor de DNS dinâmico também, se o problema for
  a conta.
- **Servidores diferentes.** Três domínios na mesma hospedagem só protegem
  contra queda de domínio.
- **HttpURLConnection não segue desvio que troca de esquema.** Um 302 de https
  para http é ignorado em silêncio. Se for usar arquivo de encaminhamento, ele
  tem que copiar o esquema do pedido.

## 10. Roteiro para um app novo

1. Descompilar e confirmar que é da mesma família (seção 1).
2. Localizar o pacote interno e conferir o mapa de classes (seção 3).
3. Abrir `a/g$a.smali` e anotar o endereço do painel atual.
4. Testar o painel no navegador: `ENDERECO?action=dns` mostra o formato real
   que aquele painel devolve — vale conferir antes de assumir.
5. Reproduzir o teste-base: instalar, fechar o app, abrir de novo e ver se o
   guia de programação sobrevive. É o defeito mais provável.
6. Aplicar as correções da seção 5 que fizerem sentido.
7. Se for preciso **funcionalidade nova** (não só correção), seguir as regras
   da seção 7 e, se for a mesma necessidade de rota alternativa, a receita da
   seção 9.
8. Compilar, assinar, **conferir no APK assinado**, dividir e entregar.
