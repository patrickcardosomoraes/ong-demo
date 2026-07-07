# Solução Anti-FOUC

> Memória do orbe — tópico `solucao-anti-fouc` (auto-gerada, filtrada de segredos).

## 2026-07-06
Para evitar o Flash of Unstyled Content (FOUC) no sistema de temas, um script síncrono inline lê o `localStorage` e aplica o tema antes do paint inicial da página, prevenindo piscadas visuais.
