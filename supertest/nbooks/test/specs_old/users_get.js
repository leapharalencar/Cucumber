describe("Service: Books @get", () => {

    describe('GET /api/user', () => {

        describe('status 200', () => {

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

            it('consultar dados do usuário', done => {
                request
                    .get('/api/user')
                    .set('ACCESS_TOKEN', token)
                    .expect(200)
                    .end((err, res) => {
                        expect(res.body.email).to.eql(user.email)
                        done(err);
                    })
            });

        });

    });

});