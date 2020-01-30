class StaticPagesController < ApplicationController
  protect_from_forgery with: :exception
  
  def home
  end

  def about
  end
end
