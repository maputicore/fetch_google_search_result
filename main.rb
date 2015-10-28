# -*- coding: utf-8 -*-

require 'mechanize'
require 'nokogiri'

query = "ラーメン"
max_page = 10

url = 'http://google.co.jp'
uri = URI.parse(url)
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
page = agent.get(uri)

form = page.forms[0]
form.field_with(:name => "q").value = query

next_page = agent.submit(form)
# puts next_page.body
(0...max_page).each { |i|
    p i + 1
    next_page.search('h3 a').each { |nd|
        puts nd['href'].sub("/url\?q=", "") + "," + nd.text
    }
    next_button = next_page.at('//*[contains(./text(), "次へ")]')
    if next_button
        next_button = next_button.parent
        agent.click(next_button)
        next_page = agent.page
    end
    
}