describe("Service: Books", () => {

    let token;

    before(done => {
        request
            .post('/api/token')
            .send({
                email: "fernando@qaninja.io",
                password: "123456"
            })
            .expect(200)
            .end((err, res) => {
                token = res.body.user_token;
                done(err);
            });
    });

    describe("DELETE /books/:id", () => {

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
            })

            it("remover livro com sucesso", done => {
                request
                    .delete(`/api/books/${book.id}`)
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        done(err);
                    });
            });

            after(done => {
                request
                    .get(`/api/books/${book.id}`)
                    .set('ACCESS_TOKEN', token)
                    .expect(404)
                    .end((err, res) => {
                        done(err);
                    });
            });

        });

        describe("status 404", () => {

            it("livro não cadastrado", done => {
                request
                    .delete('/api/books/00000')
                    .set('ACCESS_TOKEN', token)
                    .expect(404)
                    .end((err, res) => {
                        done(err);
                    });
            });

        });

    });



});