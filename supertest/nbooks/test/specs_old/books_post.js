describe("Service: Books @post_books", () => {

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

    describe("POST /api/books", () => {

        describe("status 200", () => {

            let book = {
                title: "Cinquenta tons de cinza",
                author: "El James",
                isbn: "CTC123",
                price: 19.90,
                active: true
            }

            before(done => {
                MongoClient.connect(mongo_uri, (err, db) => {
                    db.collection("books").deleteMany(book, (err, res) => {
                        db.close();
                        done(err);
                    });
                });
            });

            it("cadastrar novo livro", done => {
                request
                    .post('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .send(book)
                    .expect(200)
                    .end((err, res) => {
                        done(err);
                    });
            });

        });


        describe("status 409", () => {

            let book = {
                title: "Moby Dick",
                author: "Herman Melville",
                isbn: "MD123",
                price: 48.90,
                active: false
            }

            before(done => {
                MongoClient.connect(mongo_uri, (err, db) => {
                    db.collection("books").deleteMany(book, (err, res) => {
                        db.collection("books").insert(book, (err, res) => {
                            db.close();
                            done(err);
                        });
                    });
                });
            });

            beforeEach(done => {
                // repete para cada cenário
                console.log("Background");
                done();
            });

            it("livro já cadastrado", done => {
                request
                    .post('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .send(book)
                    .expect(409)
                    .end((err, res) => {
                        expect(res.body.message).to.eql("Livro já cadastrado.")
                        done(err);
                    });
            });

            it("isbn pertence a outro livro", done => {
                request
                    .post('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .send({
                        title: "Memórias Póstumas de Brás Cubas",
                        author: "Machado de Assis",
                        isbn: "MD123",
                        price: 29.90,
                        active: true
                    })
                    .expect(409)
                    .end((err, res) => {
                        expect(res.body.message).to.eql("ISBN pertence a um livro já cadastrado.")
                        done(err);
                    });
            });

        });


    });

});