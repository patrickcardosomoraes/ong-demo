# Auditoria de Acessibilidade e Dark Mode — Acolher Instituto

Esta auditoria detalha melhorias no Dark Mode e na acessibilidade da Landing Page do **Acolher Instituto**. Como o projeto foi consolidado em um arquivo único `index.html` sem dependências do Node.js, todas as correções de CSS/JS listadas abaixo serão aplicadas cirurgicamente no mesmo.

---

## Exemplos

Variável CSS correta para hover no dark mode (substitui hardcoded `#ead9ec`):

```css
.btn-soft:hover {
  background-color: var(--line); /* em vez de #ead9ec */
}
```

Token `--bar-bg` para trilho da barra de progresso:

```css
:root { --bar-bg: #eadff0; }
html.dark { --bar-bg: #2a1c32; }

.bar { background: var(--bar-bg); }
```

Foco visível acessível para input `#outro`:

```css
#outro:focus-visible {
  outline: 2px solid var(--focus);
  outline-offset: 2px;
}
```

Anúncio de tema para leitores de tela:

```html
<div id="theme-announcer" class="sr-only" aria-live="polite"></div>
```

```javascript
document.getElementById('theme-announcer').textContent = 'Modo escuro ativado';
```

## 1. Problemas de Contraste e Elementos Visuais Identificados

### 1.1 Cores Hardcoded e Hover no Dark Mode
- **Hover de Botões Secundários (`.btn-soft:hover`)**: 
  - *Problema:* O valor de hover está hardcoded para `#ead9ec` (um roxo claro). Em modo escuro, o fundo do botão `--lav2` é escuro (`#2a1c32`) e o texto `--plum` é claro (`#d275d3`). Ao passar o mouse, o fundo fica `#ead9ec` (branco/lilás muito claro), o que quebra totalmente o contraste com um texto claro ou a harmonia do dark mode.
  - *Solução:* Substituir de `#ead9ec` para uma cor derivada de variável como `var(--line)`.
- **Trilho da Barra de Progresso (`.bar`)**:
  - *Problema:* O fundo do trilho é `#eadff0` (hardcoded). Fica com contraste baixíssimo com o texto do entorno e é desnecessariamente claro no modo escuro.
  - *Solução:* Criar uma variável `--bar-bg` e usá-la no lugar da cor hardcoded.
- **Aspas Gigantes nos Depoimentos (`.quote .mark`)**:
  - *Problema:* A cor está definida estaticamente como `#d9b9da`. Fica muito clara e sem contraste adequado em fundos claros ou escuros.
  - *Solução:* Mudar para `rgba` ou criar um token dependente do tema.

### 1.2 Problemas de Acessibilidade (A11y)
- **Falta de Indicador de Foco (`:focus-visible`) para Inputs**:
  - *Problema:* O input de valor customizado (`#outro`) possui `outline: none`, o que remove o indicador de foco nativo do navegador e impede que usuários de navegação por teclado saibam que o elemento está focado.
  - *Solução:* Adicionar `outline: 2px solid var(--focus)` no `:focus-visible`.
- **Anúncio de Troca de Tema para Leitores de Tela**:
  - *Problema:* Embora o botão tenha `aria-label` dinâmico, leitores de tela podem não anunciar imediatamente a mudança do estado de forma falada.
  - *Solução:* Adicionar uma tag escondida (visualmente oculta com classe `.sr-only`) com `aria-live="polite"` que receba um texto dinâmico (ex.: "Modo escuro ativado", "Modo claro ativado") quando o usuário interagir com o toggle ou select.
- **Feedback Tátil**:
  - *Problema:* Navegadores móveis não dão retorno físico ao alternar temas.
  - *Solução:* Usar `navigator.vibrate(15)` com segurança (guardando com `try/catch` e checando suporte) quando houver clique no toggle para maior imersão e acessibilidade.

### 1.3 Suporte a Movimento Reduzido (Acessibilidade Motora)
- *Problema:* As transições longas nos componentes de UI (`transition: 0.25s`) continuam ativas mesmo para quem prefere movimento reduzido por questões de labirintite ou processamento lento.
- *Solução:* Adicionar `@media (prefers-reduced-motion: reduce)` redefinindo transições para `none !important`.

---

## 2. Ações de Correção Planejadas
1. **Adicionar Variáveis CSS de Contraste Fino**:
   - `--bar-bg` para o trilho.
   - `--hover-soft` para botões soft.
   - `--quote-mark` para a marca d'água de aspas.
2. **Atualizar CSS no `<style>` de `index.html`** com as resoluções de contraste e foco.
3. **Injetar o Feedback Tátil e Anúncio `aria-live`** no script JS do final do arquivo.
4. **Garantir que as imagens do modo escuro fiquem mais confortáveis** reduzindo levemente seu brilho através de filtro CSS.
