require_relative 'pages/sections'

module PageObjects

    def login
        return LoginPage.new
    end

    def dash
        return DashPage.new
    end

    def customer
        return CustomerPage.new
    end
end