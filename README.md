# Desafio INK

## Descrição

Esse é um projeto simples em Rails no qual podemos cadastrar lojas, produtos e pedidos. Para mais detalhes do que cada tabela possui, você pode acessar o schema no arquivo: `db/schema.rb`. Nesse projeto, utilizamos o PostgreSQL como banco de dados.

Além do rails, estamos utilizando mais duas gems:

- rspec-rails: biblioteca usada para fazer testes
- tailwindcss-rails: biblioteca para CSS

## Configurando o Projeto

O projeto usa docker para facilitar o desenvolvimento e configuração. Dependendo de como você instalou, vai ser necessário usar o `sudo`.

Primeiramente, para configurar o projeto, você vai seguir os seguintes passos:

1. Execute o docker compose:
```sh
docker-compose up
```

2. Criar os bancos de dados de teste e desenvolvimento. Em outra aba do terminal, execute:
```sh
docker exec desafio-ink-web ./bin/setup
```

3. Agora, para deixar o CSS ativo, execute:
```sh
docker exec -it desafio-ink-web bin/rails tailwindcss:watch
```
OBS: esse terminal deve continuar aberto para que suas mudanças no CSS sejam percebidas pela aplicação.

## Acessando o Projeto

Após executar, você pode acessar as rotas:
- `http://localhost:3000/`
- `http://localhost:3000/stores`
- `http://localhost:3000/products`
- `http://localhost:3000/orders`

Para rodar os testes automatizado, basta executar:
```sh
docker exec -t desafio-ink-web bundle exec rspec
```

## Desafios

O objetivo é que você resolva os seguintes desafios.

1. Criar uma página que consiga listar todos os produtos de uma loja e diga quantas vendas cada produto possui.

2. Criar uma página que consiga listar todos os pedidos de uma loja.

3. Decrementar o estoque a cada venda que um produto tiver e não deixar o estoque ficar negativo, não permitindo uma venda nesse caso.

4. Criar um ranking das top-10 lojas que tiveram o maior faturamento.
- O faturamento de uma loja é o somatório do valores de todos os pedidos de uma loja.
- O valor de um pedido é dado pela soma do valor do frete(shipping) + o valor do produto (price)

5. Todas as novas implementações precisam ter testes automatizados

6. (opcional) Fazer as melhorias que achar necessário no projeto.

7. Escrever um documento explicando sua ideia.

8. Explicar como seria a implementação de um carrinho de compra nesse projeto (não precisa implementar essa parte, queremos saber apenas a ideia).

## Comentário gerais
- As modificações no frontend devem seguir o Tailwind CSS. Para facilitar, você pode usar muita coisa pronta do [Flowbite](https://flowbite.com/docs/getting-started/introduction/), ele já está configurado no projeto. (Lembrar de deixar de fazer o passo 3 do "Configurando o Projeto")
- Você pode mudar o que quiser na aplicação e no banco de dados.
- Você pode instalar novas gems se achar necessário.

## O que vai ser levado em consideração
- Se a solução resolve os problemas
- Organização do código e legibilidade
- Conhecimento em banco de dados e SQL
- Conhecimento em testes automatizados
- Preocupação com segurança (para simplificar, não precisa adicionar autenticação nesse projeto)
- Preocupação com performance e escalabilidade
