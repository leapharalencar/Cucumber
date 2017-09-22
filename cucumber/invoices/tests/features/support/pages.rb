
class LoginPage < SitePrism::Page
    set_url '/login'
    element :email, '#email'
    element :password, 'input[type=password]'
    element :sign_in, 'button[id*=btnLogin]'
    element :message_error, '#login-errors'
end

class DashPage < SitePrism::Page
    element :title, '#content h3'
    element :title_row, '#title_row'
end

class NavPage < SitePrism::Page
    element :usermenu, '#usermenu'
    element :logout, 'a[href$=logout]'
end

