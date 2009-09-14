class AdminController < ApplicationController
  before_filter :check_admin
  
  def check_admin
    is_admin?
  end

  def user_all
   User.find(:all)
  end
     
  def index
  end
end
