
class LoginPage < SitePrism::Page
    set_url '/login'
    element :email, '#email'
    element :password, 'input[type=password]'
    element :sign_in, 'button[id*=btnLogin]'
    element :message_error, '#login-errors'

    def do_login(user)
        self.email.set user ['email'] 
        self.password.set user['password']
        self.sign_in.click
    end

end

class DashPage < SitePrism::Page
    element :title, '#content h3'
    element :title_row, '#title_row'
end

class NavPage < SitePrism::Page
    element :usermenu, '#usermenu'
    element :logout, 'a[href$=logout]'

    def do_logout
        self.usermenu.click
        self.logout.click
    end
end

class CustomerPage < SitePrism::Page
    set_url '/customers'

    element :new, '#dataview-insert-button'
    element :save, '#form-submit-button'

    element :name, 'input[name=name]'
    element :phone, 'input[name=phone]'
    element :email, 'input[name=email]'
    element :radio_m, 'input[name=radio-m]'
    element :radio_f, 'input[name=radio-f]'
    element :type, '#type-customer'
    element :note, 'textarea[name=note]'
    element :info, '.checkbox input'

    element :search_input, 'input[name=search]'
    element :search_button, '#dataview-search-button'

    elements :view, 'table tbody tr'

    

end