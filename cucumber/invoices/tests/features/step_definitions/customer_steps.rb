#encoding utf-8

  
Dado(/^usuário acessa cadastro de clientes$/) do
    @customer.load
end

Dado(/^que eu tenho um cliente "([^"]*)"$/) do |type| 
    name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"                         
    @new_customer = {
        'name' => name,
        'phone' => Faker::PhoneNumber.cell_phone,
        'email' => Faker::Internet.free_email(name),
        'note' => Faker::Lorem.paragraph,
        'type' => type,
        'info' => true
    }
  end                                                                            
                                                                         
                                                                                
Quando(/^faço o cadastro desse cliente$/) do
    @customer.new.click                                  
    @customer.name.set @new_customer['name']
    @customer.phone.set @new_customer['phone']
    @customer.email.set @new_customer['email']
    @customer.note.set @new_customer['note']
    @customer.info.click if @new_customer['info'].eql? (true)
    @customer.save.click
end                                                                           
                                                                                
Então(/^esse cliente deve ser exibido na busca$/) do                          
    @customer.search_input.set @new_customer['email']
    @customer.search_button.click
    expect(@customer.view.size).to eql 1
    expect(@customer.view.first.text).to have_content @new_customer['name']
    expect(@customer.view.first.text).to have_content @new_customer['phone']
    expect(@customer.view.first.text).to have_content @new_customer['email']
end                                                                           