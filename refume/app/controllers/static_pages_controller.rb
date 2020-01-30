class StaticPagesController < ApplicationController
  protect_from_forgery with: :exception

  def home
  end

  def about
  end

  def contact
  end

  def help
  end
end
