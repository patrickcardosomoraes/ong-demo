# Handoff cross-engine (auto-gerado · TRANSITÓRIO)

> Gerado quando o usuário trocou de LLM/engine no meio da sessão: resumo destilado + últimas mensagens cruas, pra nova LLM continuar de onde parou. **Sobrescrito a cada troca** e **gitignorado** — é estado momentâneo da sessão, NÃO viaja com o repo (≠ `memory.md`, que é durável e commitado). Já passou por filtro de segredos. Pode ler/editar antes da nova LLM usar.

## Handoff (codex)

**Objetivo atual:** Manter a landing page do Acolher Instituto em `index.html`; remover resíduos do sistema solar que entraram por engano.

**Decisões tomadas:**
- `solar-system.html` foi removido.
- Memórias locais não rastreadas sobre sistema solar/Three.js foram removidas.
- O índice `.orbe/memory.md` foi ajustado para não apontar para essas memórias removidas.
- Foi mantida a correção válida de visibilidade do badge usando `var(--ink)`.

**Estado:** Landing page do Acolher permanece como arquivo principal. Não há tarefa visual pendente associada ao sistema solar.
