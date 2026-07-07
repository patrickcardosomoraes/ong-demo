# Correção de Visibilidade UI

> Memória do orbe — tópico `correcao-de-visibilidade-ui` (auto-gerada, filtrada de segredos).

## 2026-07-07
Foi descoberta uma armadilha onde o texto do badge estava invisível no modo claro (`light mode`) devido à combinação de um fundo `var(--white)` com texto `#fff` (branco sobre branco). A correção envolveu mudar a cor do texto para `var(--ink)` para garantir visibilidade em ambos os temas.

## 2026-07-07
Foi descoberto que texto com cor `#fff` (branco hardcoded) ficava invisível no modo claro quando o fundo também era branco (`var(--white)`). A correção envolveu usar uma variável CSS (`var(--ink)`) para a cor do texto, garantindo visibilidade em ambos os temas.

## 2026-07-07
Foi identificada uma armadilha visual onde o texto do badge na UI ficava invisível no modo claro devido à cor do texto estar hardcoded como branco (`#fff`) e o background ser também branco (`var(--white)`), exigindo a mudança para uma cor escura (`var(--ink)`) para garantir visibilidade em ambos os temas claro e escuro.
