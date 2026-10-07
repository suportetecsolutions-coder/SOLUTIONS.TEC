# Como tirar o "raio-x" da tela do TV Box

Serve para eu ver **exatamente** quais views existem naquela tela, quais podem
receber foco, qual está com o foco agora e o tamanho real de cada uma.

Leva uns 10 minutos na primeira vez. Depois são 30 segundos.

---

## 1. Baixar o ADB no PC (uma vez só)

1. Baixe: **https://dl.google.com/android/repository/platform-tools-latest-windows.zip**
2. Extraia para uma pasta fácil, por exemplo `C:\adb`
3. Abra o PowerShell **nessa pasta**: entre na pasta pelo Explorador, clique na
   barra de endereço, escreva `powershell` e aperte Enter.

Teste:

```
.\adb.exe version
```

Tem que aparecer a versão. Se aparecer, está pronto.

---

## 2. Ligar a depuração no TV Box (uma vez só)

No aparelho onde o defeito acontece:

1. **Configurações → Sobre** (ou "Sobre o dispositivo")
2. Clique **7 vezes** em **"Número da versão"** / **"Build number"**
   → aparece "Você agora é um desenvolvedor"
3. Volte e entre em **Opções do desenvolvedor**
4. Ligue **"Depuração USB"** (ou "ADB debugging")
5. Se existir, ligue também **"Depuração por rede"** / **"ADB over network"** /
   **"Depuração sem fio"**

### Anote o IP do aparelho

**Configurações → Rede → (sua Wi-Fi) → Status**
Algo como `192.168.0.25`.

> Se o seu aparelho **não tiver** a opção de depuração por rede, me avisa — tem
> outro caminho (cabo USB, ou eu gero uma versão que escreve o raio-x num arquivo
> sozinha).

---

## 3. Conectar (toda vez)

No PowerShell, dentro de `C:\adb`, trocando pelo IP do seu aparelho:

```
.\adb.exe connect 192.168.0.25:5555
```

Tem que responder `connected to 192.168.0.25:5555`.

Na primeira vez a TV pergunta **"Permitir depuração USB?"** — marque
**"Sempre permitir"** e confirme com o controle.

---

## 4. Tirar o raio-x (é esta parte que me interessa)

1. No TV Box, **abra o app e vá até a tela de adicionar usuário novo** — aquela
   onde o direcional não desce.
2. **Deixe a tela aberta** e volte para o PowerShell.
3. Rode, uma linha de cada vez:

```
.\adb.exe shell uiautomator dump /sdcard/tela.xml
```

```
.\adb.exe pull /sdcard/tela.xml .
```

```
.\adb.exe shell "dumpsys window | findstr mCurrentFocus"
```

4. **Me mande o arquivo `tela.xml`** (fica na pasta `C:\adb`) e **o texto que
   aparecer no terceiro comando**.

---

## O que eu vou ver nesse arquivo

Para cada view da tela: a classe, o id, as **coordenadas e o tamanho real**, e os
campos **`focusable`** e **`focused`**.

Com isso eu respondo de uma vez:

- os campos de usuário e senha **existem** mesmo na tela?
- eles estão com **altura zero** (o que os tiraria da busca de foco)?
- algum deles está marcado como **não focável**?
- **quem** está com o foco quando a tela abre?
- tem alguma view invisível por cima, engolindo o direcional?

É isso que transforma o chute em conserto.

---

## Bônus, se quiser aproveitar a conexão

Com o ADB conectado, instalar uma versão nova fica muito mais rápido do que por
pendrive:

```
.\adb.exe install -r "D:\0 - DOC\APPS\APPS - REVISADOS\TVAQUI.PRO\TVAQUI.PRO.v75q.apk"
```

E se algum dia o app fechar sozinho de novo, isto pega o motivo exato:

```
.\adb.exe logcat -b crash -d > crash.txt
```
