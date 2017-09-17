#language: pt

Funcionalidade: Login
    Sendo um usuário do invoices
    Posso acessar o sistema
    Para cadastrar meus clientes e também lançar faturas

Contexto: Página login
    * usuário acessa a página login

    Cenario: Administrador faz login

        Dado que eu tenho os seguintes dados de acesso:
            | email    | admin-qa@ninvoices.com |
            | password | secret                 |
        Quando faço login
        Então vejo o dashboard com a mansagem "Olá, Admin QA, seja bem vindo ao Invoices."

    @login_tentativa
    Cenário: Tentativa de login

        Dado que eu tenho uma lista de usuários:   
            | email                     | password | menssagem                 |
            | admin-qa@ninvoices.com    | 1234     | Senha inválida.          |
            | admin-qa@teste.com        | secret   | Informe um email válido. |
            | padrekevedo@noekziste.com | teste123 | Usuário não cadastrado.  |
        Quando faço a tentativa de login
        Então vejo as mensagens de erro de login
