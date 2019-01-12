class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "see if I got it"
  end
end
