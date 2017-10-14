#language: pt

Funcionalidade: Login
    Sendo um usuário do invoices
    Posso acessar o sistema
    Para cadastrar meus clientes e também lançar faturas

Contexto: Página login
    * usuário acessa a página login

    @logout @now
    Cenario: Administrador faz login

        Dado que eu tenho um usuário com o perfil "admin"        
        Quando faço login
        Então vejo o dashboard com a mansagem "Olá, " usuário ", seja bem vindo ao Invoices."
            E vejo email do usuário logado 

    @login_tentativa
    Cenário: Tentativa de login

        Dado que eu tenho uma lista de usuários:   
            | email                     | password | mensagem                 |
            | admin-qa@ninvoices.com    | 1234     | Senha inválida.          |
            | admin-qa&teste.com        | secret   | Informe um email válido. |
            | padrekevedo@noekziste.com | teste123 | Usuário não cadastrado.  |
        Quando faço a tentativa de login
        Então vejo as mensagens de erro de login
