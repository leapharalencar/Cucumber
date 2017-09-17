


describe("Service: books", ()=> {

    describe("POST /api/books", ()=> {

        describe("status 200", ()=> {

            let book = {
                title: "Cinquenta tons de cinza",
                author: "El James",
                isbn: "CTC123",
                price: 19.90,
                active: true
            }

            it("cadastrar novo livro", done => {
                request
                    .post('/api/books')
                    .send(book)
                    .expect(200)
                    .end((err, res) => {
                        done(err);          
                    });                                
                    
            });
        });
    });

});
