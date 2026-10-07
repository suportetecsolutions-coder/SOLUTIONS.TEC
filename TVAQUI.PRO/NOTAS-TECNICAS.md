# TVAQUI.PRO — notas técnicas

Documento de referência do projeto. Guarde junto com o APK e o painel.
Última atualização: 31/08/2026.

---

## 1. O aplicativo

| | |
|---|---|
| Nome | TVAQUI.PRO |
| Pacote interno | `com.ftgtv.ftgiptvbox` |
| applicationId | `com.tvaquipr.mtream` |
| Base | app da linha WHMCS Smarters (IPTV Smarters Pro) |
| Versão final entregue | **v36 → versionName `4.7`, versionCode `48`** |

### Ferramentas usadas para modificar

```
apktool 2.9.3          descompilar e recompilar
zipalign -p -f 4       alinhar
apksigner              assinar (keystore mykey.keystore, alias tvaqui)
```

Entrega: o APK é dividido em 5 partes e juntado no Termux com

```
cat TVAQUI.PRO.vXX.part00* > TVAQUI.PRO.vXX.signed.apk
```

---

## 2. ONDE FICA O ENDEREÇO DO PAINEL  ← o mais importante

O endereço do painel **não tem tela de configuração**. Ele está gravado
numa única constante dentro do APK:

```
arquivo : smali_classes2/com/ftgtv/ftgiptvbox/a/g$a.smali

public static a = "https://sm.wctvapp.com/aq/api/home.php?"   ← O ENDEREÇO
public static b = "action=dns"          (pede a lista de DNS)
public static c = "action=note"         (pede os avisos)
public static d = "reset_password"
```

**Para trocar de hospedagem:** substituir o valor de `a` pelo novo endereço
(mantendo a `?` no final) e recompilar o APK. Os campos `b`, `c` e `d` não
mudam — são os comandos, e o painel novo já responde a eles.

Confirmado por busca no app inteiro: não existe nenhum outro lugar (código,
recursos, manifesto ou assets) com esse endereço.

---

## 3. Contrato da API do painel

Confirmado de duas formas: lendo o código do app e vendo a própria API do
fornecedor responder com a lista de endpoints.

O aplicativo chama **apenas duas** URLs (confirmado: são os únicos dois
métodos da classe `a/g`, e a constante `reset_password` nunca é usada):

| Chamada | Quem chama no app |
|---|---|
| `?action=dns` | LoginActivity, MultiUserActivity, LoginM3uActivity, MultiUserAdapter |
| `?action=note` | AnnouncementsActivity |

O `m=gu` que aparece na lista de endpoints do fornecedor **não é uma chamada
separada neste app** — é apenas um dos campos de formulário enviados junto
com o `action=dns`.

**action=dns** — resposta em **JSON** (não é texto puro). O app faz:
`getString("su")` → corta o primeiro e o último caractere → remove as aspas
→ divide por vírgula. Por isso o `su` precisa ser um array:

```json
{
  "status": "true",
  "su": ["http://servidor1.com:80", "http://servidor2.com:8080"],
  "ndd": "2027-08-31",
  "sc": "<devolve o mesmo que o app enviou>"
}
```

| Campo | Papel |
|---|---|
| `status` | precisa ser `"true"` (comparado com `equalsIgnoreCase`) |
| `su` | array com os DNS, na ordem de tentativa |
| `ndd` | data de vencimento, formato `yyyy-MM-dd`; o app acrescenta `" 00:00:00.000"` e compara com hoje (formato interno `yyyy-MM-dd HH:mm:ss.SSS`) |
| `sc` | lido da resposta; significado não identificado — o painel devolve o mesmo valor recebido |

> Único ponto não confirmado em laboratório: o campo `sc`. Tudo o mais foi
> derivado direto do bytecode e testado simulando passo a passo o que o app
> faz com a resposta.

**action=note** — cada item precisa exatamente destes três campos:

```json
{"status": true,
 "response": [{"Title": "...", "Description": "...", "CreateDate": "..."}]}
```

### Campos que o app envia em toda chamada

| Campo | Conteúdo |
|---|---|
| `m` | **o comando** (ex.: `gu`) — atenção: **não é MAC** |
| `k` | chave que o app guarda; é o identificador único da instalação |
| `d` | fabricante + modelo (`Build.MANUFACTURER` + `Build.MODEL`) |
| `u` | usuário |
| `pw` | vem como `no_password` nessa chamada |
| `av` | versão do app |
| `dt` | tipo do aparelho |
| `sc`, `r`, `do` | não identificados |

> **O app não envia endereço MAC.** Para identificar cada cliente, o que
> existe é a chave (`k`) mais o modelo (`d`).

---

## 4. Correções feitas no aplicativo

**DNS com várias entradas.** Quando o app reabria e o servidor salvo não
respondia, ele insistia só no endereço em cache. Passou a escalonar para um
relogin completo, que percorre a lista inteira de DNS até achar um que
funcione. (`MultiUserActivity` → `LoginActivity` com ação `login_perform`.)

**Guia de programação (EPG) sendo apagado.** Era o problema mais grave. A
rotina de importação começava com `DELETE FROM epg`, e a atualização
automática disparava a cada vez que a tela inicial aparecia — e, como a
importação devolvia para a tela inicial, o ciclo se repetia. Três camadas de
correção:

1. a atualização automática só roda se o guia estiver vazio **ou** se
   passaram 24 h (`NewDashboardActivity.autoEpg`);
2. no máximo uma tentativa por execução do app;
3. o apagar saiu de fora e foi para **dentro da transação de gravação**
   (`b/b/d.d(List)`), virando uma troca atômica: ou grava tudo, ou não mexe
   em nada. Se o download falhar, o guia antigo continua intacto.

> Detalhe que custou uma versão: o método antigo de apagar (`b/b/d.m()`)
> **fecha a conexão do banco**. Chamá-lo logo antes de gravar fazia a
> gravação falhar em silêncio. Por isso o apagar agora é feito com
> `execSQL` dentro da própria transação.

**Textos sumidos nas telas de atualização.** Na tela de EPG era corte de
layout no modo paisagem: uma seção invisível no rodapé (`rl_skip`) empurrava
os textos para fora da área visível. Resolvido deixando-a como `gone` e
reduzindo margens nas variantes `layout-land` e `layout-large-land-v4`. Na
tela de canais/filmes/séries era a string errada (`0x7f110126` no lugar de
`0x7f110125`).

**Tela Ao Vivo.** Passou a recarregar os dados no `onResume`, em vez de
mostrar o que estava em memória.

### Detalhe de comportamento

O rótulo do menu é dinâmico e reflete a tabela do guia: mostra
**INSTALAR EPG** quando a tabela está vazia e **EPG** quando tem dados
(`NewDashboardActivity.a(d)` compara `d.i()` com zero).

---

## 5. O painel

PHP + SQLite (não precisa criar banco). Abas: DNS, Avisos, Aparelhos e Senha.
Instruções completas em `painel/LEIA-ME.txt`.

O painel já responde no formato correto do `action=dns` (JSON com
`status`/`su`/`ndd`) e do `action=note`. A data de vencimento informada ao app
sai de `APP_VENCIMENTO`, em `config.php` — vazio significa sempre 1 ano à
frente. A aba Aparelhos → Diagnóstico grava as últimas chamadas recebidas,
para conferir se o app está mesmo chegando lá.

---

## 6. O que ficou para depois

- Teste real de login com o APK apontado para o painel próprio (é o que
  fecha a validação do campo `sc`).
- Atualização remota e cadastro de cliente à distância: **exige modificar o
  app**, porque hoje ele só pergunta ao painel duas coisas (DNS e avisos) e
  não tem canal para receber comandos.
- Apontar o APK para o painel próprio assim que a hospedagem estiver de pé.
