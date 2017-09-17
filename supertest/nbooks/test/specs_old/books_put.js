describe("Service: Books", () => {

    let token;

    let user = {
        email: 'fernando@qaninja.io',
        password: '123456'
    }

    before(done => {
        request
            .post('/api/token')
            .send(user)
            .expect(200)
            .end((err, res) => {
                token = res.body.user_token;
                done(err);
            });
    });

    describe("PUT /api/books", () => {

        describe("status 200", () => {

            let book;

            before(done => {
                request
                    .get('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        book = _.sample(res.body);
                        done(err);
                    });
            });

            it("atualizar um livro", done => {
                book.title = "Aprendendo SuperTest com o Papito";
                book.author = "Fernando Papito";

                request
                    .put(`/api/books/${book.id}`)
                    .set('ACCESS_TOKEN', token)
                    .send(book)
                    .expect(200)
                    .end((err, res) => {
                        done(err);
                    });
            });

            after(done => {
                request
                    .get(`/api/books/${book.id}`)
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        expect(res.body).to.eql(book);
                        done(err);
                    });
            });

        });

    });

});