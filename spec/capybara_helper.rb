require 'rails_helper'
require 'capybara/rspec'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.server = :puma
