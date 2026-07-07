# Correção de visibilidade da UI

> Memória do orbe — tópico `correcao-de-visibilidade-da-ui` (auto-gerada, filtrada de segredos).

## 2026-07-07
Foi identificado e corrigido um problema onde o texto de um badge (subtítulo) estava invisível no modo claro, pois usava cor branca sobre um fundo branco. A correção foi aplicar a variável CSS `--ink` para garantir a visibilidade em ambos os temas.
