---
name: vercel-deploy
description: Use ao preparar um app web pra deploy na Vercel ou ao investigar um build que falhou. Checagens de pré-deploy, variáveis de ambiente e leitura de logs. Pareia com o conector Vercel do orbe.
---

# Deploy na Vercel

## Antes do deploy
- O build local passa? Rode o `build` do projeto (`next build`, `vite build`) e corrija erros antes de subir.
- Variáveis de ambiente: tudo que está no `.env.local` e o app usa precisa estar configurado na Vercel (Project → Settings → Environment Variables). `.env.local` NÃO sobe.
- Segredos (service_role, DATABASE_URL) entram como env var na Vercel, nunca no código/git.
- `NEXT_PUBLIC_*` / `VITE_*` são expostas ao browser — só coloque o que é público (ex.: anon key), nunca segredo.

## Investigar build quebrado
- No orbe: `vercel_list_deployments` pra achar o deployment, `vercel_get_deployment` pro estado e erro.
- "Module not found" no build = dep faltando no `package.json` ou só instalada localmente. Confirme que está nas `dependencies`.

## Boas práticas
- Detecte o framework certo (a Vercel autodetecta, mas confira).
- Não faça deploy em produção sem o usuário pedir — deploy é gesto explícito.
