#encoding utf-8


Dado(/^usuário acessa a página login$/) do  
  login.load 
end


Dado(/^que eu tenho um usuário com o perfil "([^"]*)"$/) do |perfil|
  @user = $data['users'][perfil]
end

Quando(/^faço login$/) do
  login.do_login(@user)
end

Então(/^vejo o dashboard com a mansagem "([^"]*)" usuário "([^"]*)"$/) do |msg1, msg2|
  expect(dash.title.text).to eql 'Dashboard'  
  expect(dash.title_row.text).to have_content "#{msg1} #{@user['name']}#{msg2}"  
end

Então(/^vejo email do usuário logado$/) do     
  
  expect(dash.nav.usermenu.text).to eql @user['email']
end                                                                           

Dado(/^que eu tenho uma lista de usuários:$/) do |table|
  @users = table.hashes
end

Quando(/^faço a tentativa de login$/) do
  @message_list = []
  @message_spec = []

  @users.each do |user|
    login.do_login(user)    
    @message_spec.push(user['mensagem'])
    @message_list.push(login.message_error.text)
  end  
end
Então(/^vejo as mensagens de erro de login$/) do
  expect(@message_list).to eql @message_spec
end
