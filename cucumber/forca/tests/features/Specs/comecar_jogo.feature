#language:pt

Funcionalidade: Começar jogo
    Para Poder passar o tempo
    como jogador
    Quero poder começar um novo jogo

    Cenario: Começo de novo jogo
        Ao começar o jogo, é exibida a mensagem
        de boas vindas ao jogador

        Quando começo um novo jogo
        Então vejo a seguinte mensagem na tela:
        """
        Bem vindo ao Jogo da forca!
        """
         