
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


