
require_relative 'sections'

class CustomerPage < SitePrism::Page
    set_url '/customers'

    section :modal_box, Sections::ModalBox, '.modal-dialog'
    section :nav, Sections::NavBar, '#navbar'

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
    element :alert_warning, '.alert-warning'

    def select_gender (gender)
        self.radio_m.click if gender == 'M'
        self.radio_m.click if gender == 'F'
    end

    def select_type(target)
        self.type.find('option', text: target).select_option
    end

    def remove_item
        #self.view.first.find('#delete-button').click
        self.view.first.find('span[class*=trash]').click
    end

end