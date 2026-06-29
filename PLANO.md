# Plano Final de Aprimoramento do Dark Mode

## Exemplos

Estrutura de tokens CSS com `data-theme` (passo 2):

```css
:root {
  --color-bg: #FFFFFF;
  --color-text: #1a1a1a;
  --color-border: #e0e0e0;
}

[data-theme="dark"] {
  --color-bg: #121212;
  --color-text: #E0E0E0;
  --color-border: #333333;
}
```

Detecção de preferência do sistema com fallback (passo 7):

```javascript
function getTheme() {
  if (localStorage.getItem('theme')) return localStorage.getItem('theme');
  if (window.matchMedia('(prefers-color-scheme: dark)').matches) return 'dark';
  return sessionStorage.getItem('theme') || 'light';
}
```

Transição suave com respeito a `prefers-reduced-motion` (passo 5):

```css
body {
  transition: background-color 300ms ease, color 300ms ease;
}

@media (prefers-reduced-motion: reduce) {
  body { transition: none; }
}
```

### 1. Realizar auditoria detalhada do dark mode atual
- **O que fazer:** Identificar elementos com contraste insuficiente (abaixo de 4.5:1), textos ilegíveis, bordas invisíveis e componentes não adaptados. Documentar em checklist com capturas de tela específicas (ex.: placeholder cinza em fundo escuro, ícones SVG sem adaptação).  
- **Arquivos a tocar:** `src/styles/audit-darkmode.md` (arquivo de registro), navegador com axe DevTools ativado.  
- **Por quê:** Basear correções em problemas reais observados, não em suposições. Garantir foco nas falhas que prejudicam usabilidade.

### 2. Definir tokens de design estruturados em CSS com `data-theme`  
- **O que fazer:** Criar variáveis CSS hierárquicas em `src/styles/tokens.css` usando padrão `data-theme`, incluindo opacidades ajustadas para dark mode (ex.: `--surface: 0 4px 12px rgba(0, 0, 0, 0.16)`). Incluir variantes para estados (hover, disabled).  
- **Arquivos a tocar:** `src/styles/tokens.css` com estrutura:  
  ```css
  :root {
    --color-bg: #FFFFFF;
    /* ... paleta light */
  }
  [data-theme="dark"] {
    --color-bg: #121212;
    --color-bg-surface: #1E1E1E;
    --color-text: #E0E0E0;
    --color-text-disabled: #616161;
    /* ... paleta dark com valores validados no WCAG Contrast Checker */
  }
  ```  
- **Por quê:** Padrão `data-theme` é mais robusto que classes no body (suporte nativo a múltiplos temas), e tokens hierárquicos evitam repetição de valores.

### 3. Substituir todas as cores hardcoded por tokens  
- **O que fazer:** Buscar globalmente valores hexadecimais (`#...` ou `rgb(...)`) em arquivos CSS/SCSS e substituí-los pelas variáveis do passo 2. Priorizar componentes críticos: `Button.module.css`, `Input.module.css`, `Card.module.css`, `Modal.module.css`.  
- **Arquivos a tocar:** Todos os arquivos `.css`, `.scss` e componentes React com estilos embutidos (ex.: `Header.jsx` usando `styled-components`).  
- **Por quê:** Eliminar inconsistências e garantir que mudanças na paleta afetem todos os componentes simultaneamente.

### 4. Corrigir elementos específicos com problemas confirmados na auditoria  
- **O que fazer:**  
  - Inputs: Fundo `var(--color-bg-surface)`, borda `1px solid var(--color-border)`, placeholder `color: var(--color-text-disabled)`.  
  - Botões: `opacity: 0.6` para estado `:disabled`, com `color: var(--color-text-disabled)`.  
  - SVGs: Adicionar `stroke="currentColor"` e `fill="currentColor"` para herdar cores do texto.  
- **Arquivos a tocar:** `src/components/Input/Input.module.css`, `src/components/Button/Button.module.css`, `src/icons/**/*.svg`.  
- **Por quê:** Resolver casos onde a mera substituição por tokens não é suficiente (ex.: placeholders invisíveis).

### 5. Implementar transição suave com fallback para dispositivos fracos  
- **O que fazer:** Adicionar no `body`:  
  ```css
  transition: background-color 300ms ease, color 300ms ease;
  /* Fallback para dispositivos com pouca GPU */
  @media (prefers-reduced-motion: reduce) {
    transition: none;
  }
  ```  
- **Arquivos a tocar:** `src/styles/global.css`.  
- **Por quê:** Evitar *flickering* na alternância de tema sem prejudicar usuários com limitações de hardware (ex.: celulares antigos).

### 6. Validar acessibilidade com teste automatizado + manual  
- **O que fazer:**  
  - Rodar axe DevTools em todas as páginas principais.  
  - Testar manualmente modais com fundo escuro usando extensão **Dark Vision** para simular daltonismo.  
  - Ajustar cores críticas (ex.: links) até atingir contraste ≥ 4.5:1.  
- **Arquivos a tocar:** `src/accessibility-report.darkmode.csv` (exportar resultados do axe).  
- **Por quê:** Contraste inadequado é a causa principal de dark modes ruins – validação prática elimina risco de falhas subjetivas.

### 7. Implementar detecção de preferência do sistema com fallback seguro  
- **O que fazer:** Atualizar `src/context/ThemeContext.js` para:  
  ```javascript
  // 1. Checar localStorage
  if (localStorage.getItem('theme')) return localStorage.getItem('theme');
  // 2. Checar prefers-color-scheme
  if (window.matchMedia('(prefers-color-scheme: dark)').matches) return 'dark';
  // 3. Fallback para sessionStorage (evita bloqueio de localStorage)
  return sessionStorage.getItem('theme') || 'light';
  ```  
- **Arquivos a tocar:** `src/context/ThemeContext.js`, `src/hooks/useTheme.js`.  
- **Por quê:** Atende à exigência crítica ignorada no Plano 1 e cobre casos de navegadores que bloqueiam `localStorage` (Plano 3).

### 8. Criar toggle acessível com feedback tátil  
- **O que fazer:** Implementar componente `<ThemeToggle>` com:  
  - Animação de ícone (sol/luá com SVG path transition)  
  - `aria-live="polite"` para leitores de tela anunciarem a troca  
  - Efeito de vibração curta (via `navigator.vibrate(15)`) ao alternar  
- **Arquivos a tocar:** `src/components/ThemeToggle/ThemeToggle.jsx`, `src/components/ThemeToggle/ThemeToggle.module.css`.  
- **Por quê:** Garante que usuários com deficiências visuais identifiquem a mudança de tema imediatamente.

### 9. Testar em ambiente realista  
- **O que fazer:**  
  - Verificar em celular físico com brilho máximo (simulando ambientes claros)  
  - Testar em Chrome DevTools com "Emulate CSS media feature prefers-color-scheme"  
  - Rodar Lighthouse 3x para medir regressão de performance  
- **Arquivos a tocar:** Nenhum (testes manuais e relatórios do Lighthouse).  
- **Por quê:** Detalhes como brilho excessivo em telas AMOLED só são visíveis em dispositivos reais.

### 10. Documentar padrões para manutenção futura  
- **O que fazer:** Atualizar `CONTRIBUTING.md` com:  
  ```markdown
  ## Dark Mode Guidelines
  - Nunca use cores hardcoded. Sempre use tokens do tokens.css.
  - Valide contraste com [WCAG Contrast Checker](https://webaim.org/resources/contrastchecker/)
  - Teste modais em fundo #121212 antes de commitar
  ```  
- **Arquivos a tocar:** `CONTRIBUTING.md`, `src/styles/README.md`.  
- **Por quê:** Previne recaídas em más práticas que geraram o problema inicial.

---

## Riscos e Mitigações  
- **Quebra de componentes terceiros** (ex.: bibliotecas UI): Mitigação – Sobrescrever estilos com `!important` apenas no escopo `data-theme="dark"`.  
- **Região branca durante transição**: Mitigação – Definir `background-color` estático no `<html>` para evitar brancura ao carregar.  
- **Tokens não aplicados em SVGs externos**: Mitigação – Criar script de pós-build que insira `fill="currentColor"` em todos os SVGs.  

---

## Critério de Pronto  
- [ ] **Checklist da auditoria** (passo 1) 100% resolvida com evidências em `audit-darkmode.md`.  
- [ ] **Lighthouse Score** ≥ 95 em Acessibilidade no modo escuro.  
- [ ] **Nenhum elemento** com contraste < 4.5:1 conforme axe DevTools (relatório anexado).  
- [ ] **Toggle funciona** em Safari 14+ (único navegador que ignora `prefers-color-scheme` em alguns casos).  
- [ ] **Transição suave** comprovada via vídeo (30 FPS mínimo em celular Android 8).  
- [ ] **Documentação atualizada** com exemplos de como estender a paleta para novos componentes.