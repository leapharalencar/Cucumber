#language: pt

Funcionalidade: Soma
    Sendo um usuário de calculadora
    Posso realizar operações matemáticas
    Para facilitar minha vida

    Esquema do Cenario: Soma de valores

        Quando faço a soma de <v1> + <v2>
        Então o resultado deve ser <total>

    Exemplos:
         | v1 | v2 | total |
         | 2  | 3  | 5     |
         | 7  | 3  | 10    |
         | 5  | 3  | 8     |
         | 4  | 2  | 6     |
         | 4  | 3  | 7     |