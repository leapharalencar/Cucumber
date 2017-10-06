#encoding utf-8

#backgraund

Dado(/^usuário "([^"]*)" faz login$/) do |_profile|
    login.load
    
   user = {
       'email' => 'admin-qa@ninvoices.com', 
       'password' => 'secret'
       }    
   login.do_login(user)
   dash.wait_for_title
end
  
Dado(/^acesso o cadastro de clientes$/) do
    customer.load
end

Dado(/^que eu tenho um novo cliente$/) do 
    name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"                         
    new_customer = {
        'name' => name,
        'phone' => Faker::PhoneNumber.cell_phone,
        'email' => Faker::Internet.free_email(name),
        'gender' => ['M', 'F'].sample,
        'type' => ['Gold','Prime', 'Platinum'].sample,
        'note' => Faker::Lorem.paragraph,
        'info' => true
    }
end   

Dado(/^esse cliente é do "([^"]*)"$/) do |tipo|
    new_customer ['type'] = tipo 
end
                                                                          
Quando(/^faço o cadastro desse cliente$/) do
    customer.new.click                                  
    customer.name.set @new_customer['name']
    customer.phone.set @new_customer['phone']
    customer.email.set @new_customer['email']
    customer.select_gender(@new_customer['gender'])
    customer.select_type(@new_customer['type'])
    customer.note.set @new_customer['note']
    customer.info.click if @new_customer['info'].eql? (true)
    customer.save.click
end                                                                           
                                                                                
Então(/^esse cliente deve ser exibido na busca$/) do                          
    customer.search_input.set @new_customer['email']
    customer.search_button.click
    expect(customer.view.size).to eql 1
    expect(customer.view.first.text).to have_content @new_customer['name']
    expect(customer.view.first.text).to have_content @new_customer['phone']
    expect(customer.view.first.text).to have_content @new_customer['email']
end

#Remover

Dado(/^que eu tenho um cliente cadastrado$/) do      
                              
    steps %{
        Dado que eu tenho um novo cliente
        Quando faço o cadastro desse cliente
        Então esse cliente deve ser exibido na busca
    }      
    
end                                                                            
                                                                                 
Quando(/^solicito a exclusão desse cliente$/) do                               
    customer.remove_item  
end                                                                            
                                                                                 
Quando(/^confirmo a ação de Exclusão$/) do                                     
    customer.modal_box.remove_yes.click  
end                                                                            
                                                                                 
Então(/^esse cliente não deve ser exibido na busca$/) do    
    expect(customer.has_view?).to eql false
end                                                                            
                                                                                 
Então(/^vejo uma mensagem informando que o mesmo não está cadastrado$/) do     
    expect(customer.alert_warning.text).to eql "\"#{@new_customer['email']}\" não encontrado."
end                                                                            