# AUDITORIA v72V → v72W — TVAQUI.PRO (04/10/2026, madrugada)

Time de auditoria: **Auditor** (QA), **Sênior** (arquitetura), **Microsoft**
(compatibilidade de API), **Meta** (UX/desempenho), **Google** (plataforma Android).
Escopo: as mudanças da v72V (foco da LUPA/3 PONTINHOS, fluxo "-4" das SÉRIES,
persistência da última seção, drawables dos grupos, Toasts de diagnóstico).

---

## 1. ACHADOS DA AUTO-AUDITORIA (confirmados pelo autor, antes dos agentes)

| # | Achado | Severidade | Correção |
|---|---|---|---|
| 1 | `TvaquiFocus.onFocusChange`: guarda de drawable nulo usava `if-nez v0, :cond_0` → **loop infinito** se o drawable fosse nulo (jump para trás) | CRÍTICO (latente) | ✅ `if-eqz v0, :tvaqui_ret` + label nova |
| 2 | Desfoco chamava `setBackground(null)` → removia o fundo (perde o ripple e o feedback de pressionado) | MAIOR | ✅ desfoco agora só reseta a escala; o `StateListDrawable` fica e cuida dos estados |
| 3 | `const/high16 0x3f99999a` (1.2f) inválido (bits baixos ≠ 0) — não compilava | CRÍTICO (de build) | ✅ trocado por `0x3fa00000` (1.25f) |
| 4 | v72S usava `View.setForeground` — só existe no API 23+ | CRÍTICO | ✅ substituído por `setBackground` (v72T) — conferido: **zero** `setForeground` restante no app |
| 5 | SÉRIES "ÚLTIMOS ASSISTIDOS": método `a()` (launcher do recém-assistidos) era **código morto** | CRÍTICO (causa do sintoma) | ✅ ligado no ramo "-4" de `b()` com guarda `equalsIgnoreCase("-4")` |
| 6 | Registradores: 29 métodos alterados verificados — nenhuma escrita em `p`, nenhuma operação larga invadindo parâmetros (77 avisos = padrão pré-existente do app) | OK | — |
| 7 | Labels duplicadas? `cond_9` existe em 2 MÉTODOS diferentes de SeriesActivitNewFlowSubCat (2342 e 3795) — **legal** (labels têm escopo de método) | OK | — |
| 8 | `onPrepareOptionsMenu` é realmente chamado pelo ToolbarActionBar (linha 651 → `Window$Callback.onPreparePanel`) | OK (confirma a estratégia de re-aplicação) | — |
| 9 | v5/v6/v7 no `onCreate` do dashboard são re-atribuídos antes do uso seguinte (4738+) — a restauração de foco não quebra valores | OK | — |
| 10 | Portão de 24h da importação intacto (v72K): `ImportStreamsActivity.onCreate` só aplica o portão com `getAction()==null`; o dashboard sempre manda ação `redirect_*`; `ImportStreamsActivity$c` grava o carimbo com `if-lez` (contador > 0) | OK (lógica original) | Ver análise de chamadores abaixo |

---

## 2. PERGUNTAS EM ABERTO PARA OS AGENTES

- [ ] **Google**: `ActionMenuItemView` — o `setBackground` programático substitui de fato o
      fundo do tema? Algum `onCreateDrawableState`/`drawableStateChanged` interfere?
- [ ] **Google**: qual view recebe o foco no SearchView iconificado (`mSearchButton`)?
- [ ] **Google**: `TvaquiFocus.run()` focando `getChildAt(0)` do RecyclerView é confiável?
- [ ] **Microsoft**: confirmar API 17+ de cada chamada usada (isFocusable, setScaleX/Y,
      postDelayed, setBackground, Toast, SharedPreferences.apply).
- [ ] **Meta**: contraste de #ff54626f + borda branca 6dp vs texto branco; escala 1.25 nos
      ícones da toolbar; plano de remoção dos 4 Toasts para produção.
- [ ] **Sênior**: riscos de `onClick` salvar QUALQUER id clicado; vazamento do Runnable
      de 400ms; análise dos chamadores de ImportStreamsActivity (regressão "baixa tudo").

---

## 3. RESULTADOS DOS AGENTES (preencher ao receber)

### Auditor (QA) — ✅ CONCLUÍDO
- **[CRÍTICO] `aput` com índice errado** (mesmo achado do Microsoft) — ✅ já corrigido.
- **[MAIOR] lógica INVERTIDA no filtro de classes da recursão** (`if-nez` pulava para `setBackground` quando NÃO continha o nome → borda aplicada a quase todo filho da toolbar). ✅ Corrigido (não-contém → próximo check; contém → setBackground).
- **[MAIOR] guarda do Toast "SELECIONADO" invertida** — ✅ já corrigida (`if-lt`).
- **[MENOR] Toast "RAMO -4" incondicional** — ✅ movido para dentro do ramo `equalsIgnoreCase("-4")`.
- **[OK] 19 verificações estruturais limpas**: registradores dentro de `.locals`, labels únicos, pares try/catch válidos, sem fall-through, 6× `onPrepareOptionsMenu` válidos, blocos de prefs do dashboard sem conflito.

### Sênior (arquitetura) — ⚠️ INTERROMPIDO (estourou o tempo); escopo coberto pela auto-análise
- **[ANÁLISE PRÓPRIA — regressão "baixa tudo a cada abertura"]** o portão de 24h em
  `ImportStreamsActivity.onCreate` **só se aplica quando `getIntent().getAction() == null`**.
  Chamadores mapeados: `NewDashboardActivity.e(String)` (clique de seção) **sempre** seta ação
  `redirect_*` (importa sem portão); `miscelleneious/b/d.g(Context)` abre **sem ação** (portão
  aplica — caminho normal de abertura); `d.g(Context,String)` e botões ATUALIZAR forçam.
  **Conclusão:** a lógica de 1x/dia está intacta desde a v72K (nada nosso a tocou). O sintoma do
  cliente é explicável por: (a) janela de 24h vencida entre sessões de teste; (b) box fraco
  interrompendo a importação (carimbo não gravado — por projeto); (c) relógio do box para trás.
  **Ação:** perguntar ao cliente "1ª abertura do dia ou todas?" + deixar registrado. Sem mudança
  de código (evitar mexer no que o cliente já aprovou).
- **[ANÁLISE PRÓPRIA — vazamento do Runnable 400ms]** `TvaquiFocus` segura a View até 700ms
  (400+300 retry) — janela curta, GC resolve; sem risco real em box fraco.
- **[ANÁLISE PRÓPRIA — onClick salvando qualquer id]** com `findViewById` + fallback para
  live_tv, ids não encontrados são ignorados com segurança. Aceitável.

### Microsoft (compatibilidade) — ✅ CONCLUÍDO
- **[FAIL-CRÍTICO] TvaquiFix.smali:552/560 — `aput v7, v6, v1` usava `v1` (cor 0x22ffffff) como índice do array** → `ArrayIndexOutOfBoundsException` silenciosa a cada chamada → o desenho da borda **nunca era criado** (estático `w` sempre nulo). **ERA A CAUSA DA LUPA NÃO FUNCIONAR NA v72V.** ✅ Corrigido: `const/4 v1, 0x0` antes do primeiro `aput`.
- **[WARN] TvaquiFix.smali:240 `ViewGroup.isLaidOut()` = API 19+** (pré-existente; minSdk 17). Engolido pelo catch. ✅ Corrigido de forma defensiva? — ver nota: será trocado por guarda de SDK na v72W. *(a aplicar)*
- **[PASS] zero `setForeground` no app** (regressão v72S eliminada) ✓
- **[PASS] literais smali válidos** (0x3fa00000→substituído por 0x3f900000, 0x3f800000, 0x40800000) ✓
- **[PASS] todas as demais APIs ≤ API 16** (setScaleX/Y=11, setBackground=16, apply()=9, Toast=1) ✓
- **[PASS] onPrepareOptionsMenu ×6** com tipo correto de campo `toolbar` ✓

### Meta (UX/desempenho) — ✅ CONCLUÍDO
- **[BUG] Toast "SELECIONADO": guarda INVERTIDA** (`if-ge` em vez de `if-lt`) → mudo nas 2 primeiras vezes e depois spam infinito. ✅ Corrigido.
- **[BUG] Toast "MENU OK": guarda INVERTIDA** (`if-eqz` em vez de `if-nez`) → nunca disparava. ✅ Corrigido.
- **[UX] Escala 1.25x nos ícones** causava corte no ActionMenuView (clipChildren default true). ✅ Reduzida para 1.125x.
- **[UX] StateListDrawable sem estado padrão** (desfocado → nulo). ✅ Adicionado item padrão transparente (empty-state) + desfoco não limpa mais o fundo.
- **[UX] Foco do recém-assistidos: timer fixo de 400ms frágil** se os dados chegarem depois. ✅ Retry único de +300ms se `requestFocus()` falhar sem filhos.
- **[UX] tvNoStream do recém-assistidos usa "Nenhum episódio encontrado" (0x7f11029d)** — texto errado, e não é focável. *(avaliar — trocar string global é arriscado; manter por ora)*
- **[PERF] custo do TvaquiFix.a(Toolbar) desprezível** (dezenas de µs, árvore ≤4 níveis) ✓
- **[A11Y] Grupos: #ff54626f + borda 6dp = contraste 6.25:1 (AA)** — manter; opcional clarear para #ff64788d. *(mantido como está)*
- **[UX] Cartões usam borda laranja #fffc8210** — propõe unificar em branco. *(NÃO mexer — cliente não reclamou dos cartões)*

### Google (plataforma) — ✅ CONCLUÍDO
- **[CONFIRMADO] `ActionMenuItemView` não tem lógica própria de fundo** (nenhum `onCreateDrawableState`/`drawableStateChanged`) → `setBackground(StateListDrawable)` substitui por completo e nada re-aplica. Estados focused/pressed corretos (0x101009c/0x10100a7) + estado padrão transparente ✓.
- **[CONFIRMADO] Rota do foco na LUPA**: `setIconifiedByDefault(false)` → o botão de busca fica GONE e quem recebe o foco é o `SearchAutoComplete` (EditText interno). A recursão do TvaquiFix **alcança** esses views (attach pós-inflateMenu + re-aplicação no onPrepareOptionsMenu) ✓.
- **[BUG] Toast "SELECIONADO" invertido** — ✅ já corrigido (`if-lt`).
- **[RISK] desfoco não limpa fundo** — decidido manter (estado padrão transparente cobre; limpar destruiria o ripple — ver Meta).
- **[CONFIRMADO] Foco do 1º filho do RecyclerView é confiável** (adapters sem `getItemViewType`, raízes `focusable=true`, suporte lib) — melhor que `recyclerView.requestFocus()` (que desiste durante layout/animação) ✓.
- **[CONFIRMADO] `onPrepareOptionsMenu` roda a cada `invalidateOptionsMenu`** (cadeia completa: delegate → ToolbarActionBar → onPreparePanel → Activity) ✓.
- **[CONFIRMADO] prefs `apply()`/`getInt` OK**; id salvo com fallback para live_tv aceitável ✓.
- **[CONFIRMADO] Fluxo "-4" CORRETO e consistente**: `l()` dispara "get_recent_watch" → `o()` enche U → `q()` exibe U via EpisodeDetailAdapter. **Sem mismatch.** (get_fav→c()/d(), get_all→a()/e() também consistentes.)

### Google (plataforma)
*aguardando*

---

## 4. CORREÇÕES JÁ APLICADAS NA ÁRVORE (entrarão na v72W)

1. `TvaquiFocus.smali` — guarda de nulo corrigida (`tvaqui_ret`); desfoco sem
   `setBackground(null)`; escala 1.25f/1.0f válida.
2. *(demais correções entram após os relatórios)*

## 5. PLANO DE BUILD pós-auditoria

1. Aplicar as correções dos agentes. ✅ (todas aplicadas)
2. Bump de versão a cada entrega. ✅ (114/7.4W → 115/7.4X → 116/7.4Y)
3. `apktool b` → `uber-apk-signer` → verificar dentro do assinado. ✅
4. Atualizar o `DIAGNOSTICO-LENTIDAO.md` e entregar as 5 partes + comando `cat`. ✅

## 6. PÓS-AUDITORIA — EPISÓDIO v72W/v72X/v72Y (lições registradas)

- **v72W (114)** = v72V + correções da auditoria. ⚠️ Introduziu REGRESSÃO: ao
  substituir `isLaidOut()` (API 19+) por `getWidth()>0 && getHeight()>0`, mudei a
  semântica de OU para E → no box fraco do cliente o resgate da tela inicial
  desistia → **botões ATUALIZAR DNS/VPN sumiram**. Lição: no TvaquiFix, preservar a
  semântica EXATA (OR). Corrigido na v72X (`getWidth()>0 || getHeight()>0`).
- **v72X (115)** = v72W-fix + Toasts do portão de 24h. ⚠️ Introduziu CRASH na
  abertura: `const-wide/32 v7, 0x36ee80` num método com `.locals 8` → grava no par
  `v7,v8` → **v8 inexistente** → VerifyError → app fecha na tela de atualização.
  Lição: operação larga SEMPRE em par dentro de `.locals`; rodar auditoria de
  par-largo do MÉTODO EXATO antes de compilar. Corrigido na v72Y (par `v4,v5`).
- **v72Y (116)** = correção do par-largo, verificada no APK assinado (0 registradores
  v8+ no onCreate). **É a versão a ser testada pelo cliente.**

