# TVAQUI — onde você parou e o que fazer a seguir

*Anotado em 25/09/2026, à noite.*

Leia de cima para baixo. São duas frentes **independentes**: a A não depende da B,
então pode fazer na ordem que der na sua agenda.

---

## FRENTE A — testar a v71 (pode fazer sozinho, agora)

A v71 já está pronta e entregue. É a primeira versão de produção desde a v63.

- [ ] **A1.** Juntar as 5 partes:

  ```
  cmd /c "copy /b TVAQUI.PRO.v71.part0.bin+TVAQUI.PRO.v71.part1.bin+TVAQUI.PRO.v71.part2.bin+TVAQUI.PRO.v71.part3.bin+TVAQUI.PRO.v71.part4.bin TVAQUI.PRO.v71.apk"
  ```

  Confira o MD5: `96086c2f3dbbe617c15d6882f7470da7`

- [ ] **A2.** Instalar **por cima** (mesma chave de assinatura, não precisa desinstalar).

- [ ] **A3.** Testar, de preferência num TV Box e numa Smart TV:
  - a tela inicial abre com os seis botões visíveis
  - o foco começa no TV AO VIVO
  - entrar no app leva menos de 30 segundos
  - **fechar e abrir de novo**: tem que ir direto para a tela inicial, sem
    rebaixar canais (é o pulo de 12 horas)
  - **trocar de usuário**: tem que reimportar na hora, com a lista da conta nova
  - TV AO VIVO abre a lista em ~1 segundo

- [ ] **A4.** Me contar o que deu.

> O aviso de atualização **não vai aparecer** nessa versão — ela aponta para um
> endereço que ainda não existe. Isso é esperado e não causa erro nenhum para o
> cliente. Quem resolve isso é a v72, na Frente B.

---

## FRENTE B — montar a infraestrutura dos endereços

Decidido: **3 endereços**, em domínios diferentes, sendo **2 no No-IP** (você já
tem o plano pago, 16 de 25 usados) e **1 domínio seu**.

### B1. Criar os endereços

- [ ] No **No-IP**, criar 2 hostnames com **finais diferentes**. Sugestão:
      `brasilia.me` e `myeffect.net` — são domínios separados de verdade, com
      nomes neutros. Deixe o **TTL em 60**.
- [ ] Ter **1 domínio seu** (novo ou um que você já tenha), de preferência
      `.net` ou `.com`, que são os mais estáveis.
- [ ] Apontar cada um para onde vai ficar (veja B2).

**Regra que não pode quebrar:** pelo menos um dos 3 tem que estar em um
**servidor diferente** dos outros. Se os 3 apontarem para a mesma hospedagem,
você só está protegido contra queda de domínio, não contra queda de hospedagem.

### B2. Decidir quem fica onde

| Endereço | Onde aponta | O que fica lá |
|---|---|---|
| 1 — seu domínio | sua hospedagem de hoje | o **painel de verdade** (`painel-tvaqui-app.zip`) |
| 2 — No-IP | sua hospedagem de hoje | nada — é só outro nome para o mesmo painel |
| 3 — No-IP | **outro servidor** | o **espelho** (`espelho-tvaqui.zip`) |

O servidor do item 3 pode ser uma hospedagem básica barata. **Não** use a Oracle
gratuita para isso: ela apaga máquina que fica 7 dias com pouco uso, e o espelho
é justamente uma coisa quieta.

### B3. Teste que tem que passar ANTES de continuar

- [ ] Adicionar o nome do No-IP na sua hospedagem como domínio adicional.
      **Algumas hospedagens compartilhadas não aceitam** nome que não venha de um
      registrador normal. Se a sua não aceitar, me avisa que a gente muda o plano.
- [ ] Abrir no navegador e confirmar que responde.

### B4. Subir o painel

- [ ] Subir o `painel-tvaqui-app.zip` no endereço 1, de forma que o painel fique em
      `https://<endereço 1>/pro/`
- [ ] Abrir `install.php` e criar o login de administrador.
- [ ] Conferir no `config.php` que está `define('APP_ID', 'pro');`

### B5. Subir o espelho

- [ ] Abrir `espelho/api/home.php` e trocar a linha:

  ```php
  $MESTRE = 'app.seudominio.top/pro';
  ```

  pelo **endereço 1** (sem `http://` e sem barra no fim).

- [ ] Subir a pasta no servidor do endereço 3, de forma que o arquivo responda em
      `https://<endereço 3>/pro/api/home.php`
- [ ] Testar no navegador:
      `https://<endereço 3>/pro/api/home.php?action=versao&app=pro`
      Tem que aparecer a mesma resposta do painel principal.

### B6. Cadastrar os espelhos no painel

- [ ] No painel, aba **Atualização** → **Endereços espelho**, cadastrar os
      endereços 2 e 3 (no formato `nome.dominio/pro`, sem `http://`).

### B7. Me mandar os nomes

- [ ] Mandar os 3 endereços exatos. Eu gravo eles no app e gero a **v72
      (versionCode 95)**.

### B8. Depois que a v72 estiver testada

- [ ] Subir a v72 para `amoraamor.top/arq/pro.apk`
- [ ] No painel, aba Atualização, publicar: número **95**, nome **7.4**, link do APK.
- [ ] A partir daí, toda versão nova é só isso: subir o arquivo e mudar o número
      no painel. Os clientes recebem o aviso sozinhos.

---

## Limpeza da pasta (2 minutos, faça quando lembrar)

Pode apagar:

- [ ] `painel-versao-app.zip` — painel avulso, substituído
- [ ] `painel-tvaqui.zip` — painel antigo, substituído
- [ ] `painel-tvaqui-app.zip` das 15:38 — **fique só com o mais recente**
- [ ] `TVAQUI.PRO.v70D.apk` — só depois da v71 testada

Substituir pelos que recebeu hoje:

- [ ] `ESTADO-ATUAL.md`, `DOCUMENTACAO.md`, `GUIA-APPS-SMARTERS.md`

Guardar como histórico, mas **não confiar**:

- [ ] `NOTAS-TECNICAS.md` — é de 31/08 e parou de ser mantido. O que importava
      migrou para os outros três.

---

## Se você voltar numa conversa nova

Anexe estes arquivos e escreva *"continue do PROXIMOS-PASSOS.md"*:

1. `PROXIMOS-PASSOS.md` (este)
2. `ESTADO-ATUAL.md`
3. `DOCUMENTACAO.md`
4. `GUIA-APPS-SMARTERS.md`
5. `mykey.keystore` — **sem ele não dá para assinar**
6. as 5 partes da v71

---

## Ficou pendente no app (não é urgente)

- ~12 segundos de "aguarde" causados por um endereço morto tentado primeiro,
  ainda não identificado.
- As telas de importação e de EPG desenham "pequenas" em TV — causa desconhecida.
- O guia de TV (EPG) baixa todo dia; poderia baixar só quando a guia guardada
  estiver acabando.
- Layouts `new_dashboard_layout.xml` e `..._without_freetrail2.xml` ainda no
  estilo antigo.
- Vidro do modo retrato ainda estático.
- VPS Oracle + primeira rota de VPN de verdade (a Oracle gratuita serve para
  isso, porque a rota tem tráfego; só não serve para coisa parada).
- Autenticação de usuário e senha no proxy.
- Aplicar tudo isso no PRO2.
