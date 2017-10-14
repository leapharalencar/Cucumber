
Before ('@login_admin') do

    login.load
     
    user = {
        'email' => 'admin-qa@ninvoices.com', 
        'password' => 'secret'
        }    
    login.do_login(user)
    dash.wait_for_title
end


After ('@logout') do
    
    dash.nav.do_logout   
end

After do |scenario|
    ###Print da página

    # remove caracteres inválidos 
    # do nome do cenário para gerar o nome do arquivo
    @file_name = scenario.name.gsub(' ', '_')
    @file_name = @file_name.gsub(',', '').gsub('#', '')
    @file_name = @file_name.gsub('(', '').gsub(')', '')

    # define o nome do arquivo para o screenshot
    @target = "reports/screenshots/#{@file_name.downcase!}.png"

    # tira screenshot
    page.save_screenshot(@target)
    embed(@target, 'image/png', 'Clique aqui para ver a evidência')

end


