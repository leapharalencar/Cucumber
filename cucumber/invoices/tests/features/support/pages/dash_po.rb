
require_relative 'sections'


class DashPage < SitePrism::Page

    section :nav, Sections::NavBar, '#navbar'

    element :title, '#content h3'
    element :title_row, '#title_row'
end
