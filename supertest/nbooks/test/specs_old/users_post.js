describe('Service: nBooks', () => {

    describe('POST /api/user', () => {

        let user = {
            name: 'Fernando',
            email: 'fernando@qaninja.io',
            password: '123456'
        }

        describe('status 200', () => {

            before(done => {
                MongoClient.connect(mongo_uri, (err, db) => {
                    db.collection('users').deleteMany(user, (err, res) => {
                        db.close();
                        done(err);
                    });
                });
            });

            it('cadastrar novo usuário', done => {
                request
                    .post('/api/user')
                    .send(user)
                    .expect(200)
                    .end((err, res) => {
                        done(err);
                    });
            });

        });

        describe('status 409', () => {

            let user = {
                name: 'Papito',
                email: 'papito@qaninja.io',
                password: '123456'
            }

            before(done => {
                MongoClient.connect(mongo_uri, (err, db) => {
                    db.collection('users').deleteMany(user, (err, res) => {
                        db.collection('users').insert(user, (err, res) => {
                            db.close();
                            done(err);
                        });
                    });
                });
            });

            it('email já cadastrado para outro usuário', done => {
                request
                    .post('/api/user')
                    .send(user)
                    .expect(409)
                    .end((err, res) => {
                        expect(res.body.message).to.eql("O e-mail informado, já esta cadastrado!");
                        done(err);
                    });
            });

            // 1 - enviar post, com email em branco => 409
            // 2 - enviar post, sem email no json => 409
            // 3 - enviar post, com email inválido => 409
            // Validar mensagem de retorno para todos os cenários

        })

    });

});