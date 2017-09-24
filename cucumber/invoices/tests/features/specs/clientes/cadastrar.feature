#language: pt

Funcionalidade: Cadastrar cliente
    Sendo um usuário cadastrado
    Posso acessar o cadastro de clientes
    Para cadastrar um novo cliente e também administrar os mesmos

    Contexto: Cadastrar cliente
        * usuário acessa cadastro de clientes

    @cadastro @login_admin
    Cenario: Cadastrar novo cliente

        Dado que eu tenho um cliente "Prime"
        Quando faço o cadastro desse cliente
        Então esse cliente deve ser exibido na busca