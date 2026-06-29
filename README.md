# Acolher Instituto — Landing Page

Página institucional e de arrecadação de doações da ONG **Acolher Instituto** (Guarulhos). Site single-page focado em apresentar os programas sociais e converter visitantes em doadores mensais.

## Stack

- **HTML5 + CSS3 (vanilla)** — sem framework, sem build step.
- **JavaScript vanilla** — toda interação no próprio `index.html`.
- **Arquivo único** — `index.html` (~900 linhas). Zero dependências de Node.

## Instalação

Nenhuma dependência pra instalar — projeto 100% vanilla sem build step.

Clone o repositório:

```bash
git clone https://github.com/seu-usuario/ong-demo.git
cd ong-demo
```

Pronto. Abra `index.html` no navegador ou siga para **Como rodar**.

## Como rodar

Abra `index.html` direto no navegador, ou sirva como estático:

```bash
npx serve .
```

## Estrutura da página

| Seção | Âncora | O que faz |
|-------|--------|-----------|
| Hero | `#inicio` | Chamada principal + CTA de doação |
| Doação | `#doar` | Seletor de valores e botão de doação mensal |
| Essencial | `#essencial` | Itens essenciais financiados pelas doações |
| Programas | `#programas` | Programas sociais do instituto |
| Viabiliza | `#viabiliza` | Painel de impacto das doações |
| Contato | `#contato` | CTA final |

## Tema claro/escuro

- **Estratégia:** classes `.dark` / `.light` no `<html>`, com fallback `@media (prefers-color-scheme: dark)`.
- **Anti-FOUC:** script síncrono inline no `<head>` aplica o tema do `localStorage` antes do primeiro paint e ajusta o `<meta name="theme-color">`.
- **Reativo:** `window.themeManager` (padrão pub-sub) gerencia `'light' | 'dark' | 'system'`.
- **Multi-abas:** evento `storage` sincroniza o tema entre abas abertas.
- **Acessível:** controles `#theme-toggle` / `#theme-select` com `aria-label`, `aria-pressed` e foco visível.

## Acessibilidade

- Região `aria-live` (`#theme-announcer`) anuncia mudança de tema.
- Atributos semânticos e foco delineado nos controles.

## Contribuindo

Contribuições são bem-vindas. Siga os passos abaixo:

### 1. Fork e clone

```bash
git clone https://github.com/seu-usuario/ong-demo.git
cd ong-demo
```

### 2. Crie uma branch

Use nomes descritivos com prefixo:

| Prefixo | Quando usar |
|---------|-------------|
| `feat/` | Nova funcionalidade |
| `fix/`  | Correção de bug |
| `style/`| Ajuste visual sem lógica |
| `docs/` | Documentação |

```bash
git checkout -b feat/minha-feature
```

### 3. Faça suas alterações

- Mantenha tudo em `index.html` — não introduza dependências de build.
- Teste em ao menos dois navegadores (Chrome e Firefox).
- Verifique os temas claro, escuro e sistema antes de commitar.
- Garanta acessibilidade: navegação por teclado e leitores de tela.

### 4. Commit

Mensagens no formato `tipo: descrição curta` (Conventional Commits):

```bash
git commit -m "feat: adiciona contador de doadores no hero"
```

### 5. Abra um Pull Request

- Descreva **o que** mudou e **por quê**.
- Inclua screenshots se a mudança for visual.
- PRs sem testes manuais documentados podem ser bloqueados.

### Boas práticas

- Sem JavaScript inline desnecessário — prefira funções nomeadas.
- CSS: use variáveis CSS já existentes (`:root`) em vez de valores fixos.
- Nada de `!important` sem justificativa clara.
- Mantenha o `AGENTS.md` atualizado se mudar stack ou decisões-chave.

## Exemplos

Alterar tema via console do navegador:

```javascript
// Ativar dark mode
window.themeManager.set('dark');

// Seguir preferência do SO
window.themeManager.set('system');
```

Adicionar nova variável de cor respeitando os dois temas:

```css
:root {
  --minha-cor: #5a2d7a;
}
html.dark {
  --minha-cor: #c98de0;
}
```

Âncoras de navegação direta para cada seção:

```
index.html#inicio    → Hero
index.html#doar      → Doação
index.html#programas → Programas
index.html#contato   → Contato
```

## Docs do projeto

- [`AGENTS.md`](./AGENTS.md) — contexto para LLMs.
- [`PLANO.md`](./PLANO.md) — plano de evolução.
- [`audit-darkmode.md`](./audit-darkmode.md) — auditoria do dark mode.
