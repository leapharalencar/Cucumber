
Before do
    @login = LoginPage.new
    @dash = DashPage.new
    @nav = NavPage.new
    @customer = CustomerPage.new
end

Before ('@login_admin') do

    @login.load
     
    user = {
        'email' => 'admin-qa@ninvoices.com', 
        'password' => 'secret'
        }    
    @login.do_login(user)
    @dash.wait_for_title
end


After ('@logout') do
    @nav = NavPage.new
    @nav.do_logout   
end


