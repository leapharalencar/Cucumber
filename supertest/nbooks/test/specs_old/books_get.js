describe("Service: Books @getbooks", () => {

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

    describe('GET /api/books', () => {

        describe('status 200', () => {

            let books = [{
                    title: 'A culpa é das estrelas',
                    author: 'John Green',
                    isbn: 'ACDE123',
                    price: 20.49,
                    active: true
                },
                {
                    title: 'Pai Rico, Pai Pobre',
                    author: 'Robert K',
                    isbn: 'PRPC123',
                    price: 59.9,
                    active: true
                },
                {
                    title: 'A Cabana',
                    author: 'Willian Young',
                    isbn: 'AC123',
                    price: 29.9,
                    active: true
                },
                {
                    title: 'A Travessia',
                    author: 'Willian Young',
                    isbn: 'AT123',
                    price: 19.99,
                    active: false
                }
            ]

            before(done => {
                MongoClient.connect(mongo_uri, (err, db) => {
                    db.collection('books').deleteMany({}, (err, res) => {
                        db.collection('books').insert(books, (err, res) => {
                            db.close();
                            done(err);
                        });
                    });
                });
            });

            it('obter lista de livros', done => {
                request
                    .get('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        expect(res.body).to.be.an('array');

                        for (let i = 0, size = res.body.length; i < size; i++) {
                            expect(res.body[i].title).to.eql(books[i].title);
                            expect(res.body[i].author).to.eql(books[i].author);
                            expect(res.body[i].isbn).to.eql(books[i].isbn);
                            expect(res.body[i].price).to.eql(books[i].price);
                            expect(res.body[i].active).to.eql(books[i].active);
                        }
                        done(err);
                    });
            });

        });

    });

    describe('GET /api/books/:id', () => {

        describe('status 200', () => {

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

            it('obter um único livro', done => {
                request
                    .get(`/api/books/${book.id}`)
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        // console.log(book);
                        // console.log(res.body);
                        expect(res.body).to.eql(book);
                        done(err);
                    })
            });

        });

        describe('status 404', () => {

            it('livro não encontrado', done => {
                request
                    .get('/api/books/00000')
                    .set('ACCESS_TOKEN', token)
                    .expect(404)
                    .end((err, res) => {
                        done(err);
                    });
            });

        });

    });

    describe('GET /api/books/?params', () =>{

        describe('status 200', () => {

            let filter = {
                author: 'Young'
            }

            it('filtrar livros por autor', done => {
                request
                    .get('/api/books')
                    .set('ACCESS_TOKEN', token)
                    .query(filter)
                    .expect(200)
                    .end((err, res) => {
                        // console.log(res.body);
                        res.body.forEach((item) => {
                            expect(item.author).to.contain(filter.author);
                        });
                        done(err);
                    })
            })

        })

    })

});