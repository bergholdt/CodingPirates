class ApplicationController < ActionController::Base
  # Rails beskytter formularer med et CSRF-token og escaper tekst i views.
  # På offentlige undervisningsapps bruges et fælles holdpassword.
  if Rails.env.production? || ENV["COURSE_PASSWORD"].present?
    http_basic_authenticate_with name: ENV.fetch("COURSE_USER"), password: ENV.fetch("COURSE_PASSWORD")
  end
end
