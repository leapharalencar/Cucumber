require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'faker'

require_relative 'page_objects'

World(PageObjects)

Faker::Config.locale = 'pt-BR'

$browser = ENV['BROWSER']


Capybara.register_driver :selenium do |app|

    if $browser.eql?('chrome')
        #Subir o chrome
        Capybara::Selenium::Driver.new(
            app,
            browser: :chrome,
            desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                'chromeOption' => {
                    'args' => ['window-size=1280,800']
                }
            )
        )

    elsif $browser.eql?('firefox')
        #Subir o firefox

        Capybara::Selenium::Driver.new(
            app,
            browser: :firefox,
            marionette: true
        )

    elsif $browser.eql?('headless')  
        #Subir o phantamjs + poltergeist
        Capybara::Poltergeist::Driver.new(
            app,
            options = {
                :js_erros => false,
                phantomjs => Phantomjs.path
        
            }
        )
    end
end

$env = ENV['ENVIRONMENT']

$data = YAML.load_file(File.dirname(__FILE__) + "/data/#{$env}.yaml")


Capybara.configure do |config|
    config.default_driver = :selenium
    config.app_host = $data['url']
end

Capybara.default_max_wait_time = 5
