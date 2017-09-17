#encoding utf-8


Dado(/^usuário acessa a página login$/) do
  visit '/login'
end

Dado(/^que eu tenho os seguintes dados de acesso:$/) do |table|
  @user = table.rows_hash
end

Quando(/^faço login$/) do
  find('#email').set @user ['email'] 
  find('input[type=password]').set @user['password']
  find('button[id*=btnLogin]').click
end


Então(/^vejo o dashboard com a mansagem "([^"]*)"$/) do |welcome|
  title = find('#content h3').text
  expect(title).to eql 'Dashboard'

  title_row = find('#title_row').text
  expect(title_row).to have_content welcome
  
end

Dado(/^que eu tenho uma lista de usuários:$/) do |table|
  @users = table.hashes
end

Quando(/^faço a tentativa de login$/) do

  @message_list = Array.new
  @message_spec = Array.new


  @users.each do |user|
    find('#email').set user['email']
    find('input[type=password]').set user ['password']
    find('button[id*=btnLogin]').click
    
    @message_spec.push(user['mensagem'])
    @message_list.push(find('#login-errors').text)
  end  
end

Então(/^vejo as mensagens de erro de login$/) do
 puts @message_list
 puts @message_spec
end