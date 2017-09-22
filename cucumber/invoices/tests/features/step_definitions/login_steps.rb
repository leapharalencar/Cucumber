#encoding utf-8


Dado(/^usuário acessa a página login$/) do
  @login = LoginPage.new
  @dash = DashPage.new
  @nav = NavPage.new
  @login.load 
end

Dado(/^que eu tenho os seguintes dados de acesso:$/) do |table|
  @user = table.rows_hash
end

Quando(/^faço login$/) do

  @Login = LoginPage.new

  @Login.email.set @user ['email'] 
  @login.password.set @user['password']
  @login.sign_in.click
end


Então(/^vejo o dashboard com a mansagem "([^"]*)"$/) do |welcome|

  expect(@dash.title.text).to eql 'Dashboard'  
  expect(@dash.title_row.text).to have_content welcome
  
end

Então(/^vejo email do usuário logado$/) do     
  
  expect(@nav.usermanu.text).to eql @user['email']
end                                                                           

Dado(/^que eu tenho uma lista de usuários:$/) do |table|
  @users = table.hashes
end

Quando(/^faço a tentativa de login$/) do
  @message_list = Array.new
  @message_spec = Array.new

  @users.each do |user|
    @Login.email.set user ['email'] 
    @login.password.set user['password']
    @login.sign_in.click
    
    @message_spec.push(user['mensagem'])
    @message_list.push(@login.message_error.text)
  end  
end
Então(/^vejo as mensagens de erro de login$/) do
  expect(@message_list).to eql @message_spec
end
