#language: pt

Funcionalidade: Cadastrar cliente
    Sendo um usuário cadastrado
    Posso acessar o cadastro de clientes
    Para cadastrar um novo cliente e também administrar os mesmos

    Contexto: Cadastrar cliente
        * acesso o cadastro de clientes

    @cadastro @login_admin @logout
    Cenario: Cadastrar novo cliente

        Dado que eu tenho um novo cliente
        Quando faço o cadastro desse cliente
        Então esse cliente deve ser exibido na busca

    @cadastro_tipo @login_admin @logout
    Esquema do Cenario: Cadastrar Clientes por tipo

        Dado que eu tenho um novo cliente
            E esse cliente é do <tipo>
        Quando faço o cadastro desse cliente
        Então esse cliente deve ser exibido na busca

        Exemplos:
        | tipo       |
        | "Prime"    |
        | "Gold"     |
        | "Platinum" |