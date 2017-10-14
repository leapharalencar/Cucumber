#language: pt

Funcionalidade: Exclusão de clientes
    Sendo um usuário cadastrado
    posso acessar o cadastro de clientes
    para poder remover meus clientes

    Contexto: Usuário acessa o cadastro de clientes
        * usuário "admin" faz login
        * acesso o cadastro de clientes

    @smoke @logout
    Cenário: Remover cliente

        Dado que eu tenho um cliente cadastrado
        Quando solicito a exclusão desse cliente
            E confirmo a ação de Exclusão
        Então esse cliente não deve ser exibido na busca
            E vejo uma mensagem informando que o mesmo não está cadastrado