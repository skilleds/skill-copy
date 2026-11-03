# E-mail de venda

> Parte da `schematize-copy`. Esta skill **escreve** o e-mail; **nunca envia**.

1. **Assunto honesto**: promete só o que o corpo entrega; sem urgência falsa, sem "Re:" fingido.
2. **Remetente identificado**: razão social/CNPJ e canal de resposta no rodapé (dados do dono, `[CONFIRMAR:]`).
3. **Descadastro de um clique**: o corpo traz o token `{{unsubscribe}}` (o gate `--email` avisa se faltar).
4. **Base legal por finalidade (LGPD)**: de onde veio o contato e por que ele recebe; sem lista comprada. Validação jurídica: `references/legal-br.md`.
5. **Voz do cliente**: vale tudo da copy de LP (você > nós, especificidade, zero eco do briefing).
6. **Efeito externo (piso 18 da `schematize-engineering`)**: fora de prd, e-mail só sai para domínio de teste em rota nula (`@test.<domínio>`), com sink por padrão, teto por execução e guard dentro do provider. Esta skill não dispara envio; ao entregar, aponte a engenharia para implementar o guard.

Gate: `bash scripts/check-copy.sh email.md --email`.
