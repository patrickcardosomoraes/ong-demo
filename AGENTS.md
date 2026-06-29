# Acolher Instituto — Landing Page

Página institucional e demonstrativa para arrecadação de doações da ONG Acolher Instituto em Guarulhos.

## Stack
- **Frontend**: HTML5, CSS3 (Vanilla) e JavaScript Vanilla.
- **Estrutura**: Arquivo único `index.html`. Sem dependências do Node.js, compiladores ou build step complexos.

## Como Rodar
1. Abra o arquivo [index.html](file:///Users/patrickcardoso/workspace/ong-demo/index.html) diretamente no seu navegador.
2. Alternativamente, use qualquer servidor estático simples, por exemplo:
   ```bash
   npx serve .
   ```

## Exemplos

Alternar tema via `themeManager`:

```javascript
// Forçar dark mode
window.themeManager.set('dark');

// Seguir preferência do sistema
window.themeManager.set('system');

// Ler tema atual
const tema = window.themeManager.get(); // 'light' | 'dark' | 'system'
```

Servir localmente:

```bash
npx serve .
# acessa em http://localhost:3000
```

## Decisões-chave & Dark Mode
- **Estratégia**: Classes `.dark` e `.light` aplicadas no elemento `<html>`. Fallback para `@media (prefers-color-scheme: dark)` quando nenhuma classe está presente.
- **Anti-FOUC**: Script síncrono inline no `<head>` que recupera o tema do `localStorage` e o aplica imediatamente antes da renderização do HTML, alterando também o `<meta name="theme-color">`.
- **Transições Suaves**: A classe temporária `theme-preload` é adicionada no `<html>` para evitar animações indesejadas no carregamento inicial da página. Ela é removida em runtime logo após o paint inicial.
- **Tema Reativo (JS Vanilla)**: Implementado o `window.themeManager` usando o padrão Publish-Subscribe para gerenciar a preferência de tema (`'light' | 'dark' | 'system'`).
- **Sincronização entre Abas**: Evento `storage` escutado no navegador para sincronizar a alteração do tema imediatamente entre diferentes abas abertas da mesma página.
- **Acessibilidade**: Os controles (`#theme-toggle` e `#theme-select`) usam etiquetas e atributos semânticos (`aria-label`, `aria-pressed` baseado no tema efetivo) e foco visível bem delineado.
