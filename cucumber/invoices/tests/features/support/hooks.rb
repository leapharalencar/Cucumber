

After ('@logout') do
    @nav = NavPage.new
    @nav.usermenu.click
    @nav.logout.click    
end


