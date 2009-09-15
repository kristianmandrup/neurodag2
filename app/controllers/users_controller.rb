class UsersController < ApplicationController
  include ApplicationHelper
  helper :profile, :avatar
  before_filter :protect, :only => [:index, :edit]
  
  def show_rated_talks
    @user = User.find(params[:id])    
    return if !@user.is_referee? 
    @title ="Referee #{full_name}:: rated talks "  
    # @ref_rated_talks = Rate.find_all_by_rateable_type_and_user_id('Talk', 2)    
    @ref_talks = Talk.find_rated_by(current_user)  
    @ref_talks.compact!
    
    @ref_talks_research = @ref_talks.sort do |t2, t1|
      t1.stars_by(@user, :research)  <=> t2.stars_by(@user, :research)
    end

    @ref_talks_presentation_style = @ref_talks.sort do |t2, t1|
      t1.stars_by(@user, :presentation_style)  <=> t2.stars_by(@user, :presentation_style)
    end
    
    @ref_talks_organization = @ref_talks.sort do |t2, t1|
      t1.stars_by(@user, :organization)  <=> t2.stars_by(@user, :organization)
    end
    
  end
  
  def index
    @title = "Neurodag User Hub"
    @user = User.find(session[:user_id])
    make_profile_vars
  end

  def new
    render :action => 'register'
  end

  def delete_selected
    logger.debug(params)
  end

  def register
    @title = "Register"
    if param_posted?(:user)
      @user = User.new(params[:user])
      empty_spec = Spec.new
       @user.spec = empty_spec
      if @user.save 
        @user.login!(session)
        flash[:notice] = "User #{@user.screen_name} created!"
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
  end


  def login
    @title = "Log in to #{@@site_name}"
    if request.get?    
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,
                                                   @user.password) 
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        flash[:notice] = "User #{user.screen_name} logged in!"
        redirect_to_forwarding_url
      else 
        @user.clear_password!
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end
  
  def logout
    User.logout!(session, cookies)
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "site"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      logger.debug("UPDATE OK")      
      flash[:notice] = 'User was successfully updated.'
    else
      logger.debug("UPDATE NOT OK")            
      flash[:notice] = 'User was not updated.'
    end
    render :update do |page|
      page.replace_html 'notice', flash[:notice]
      page.visual_effect :highlight, 'notice'
    end
    
  end
  
  # Edit the user's basic info.
  def edit
    logger.debug("USER EDIT")
    @title = "Edit basic info"
    @user = User.find(session[:user_id])   
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end  
      end
    end
    # For security purposes, never fill in password fields.
    @user.clear_password!
  end

  def destroy
    @user = User.find(params[:id])
    User.logout!(session, cookies)
    flash[:notice] = "Logged out"
    @user.destroy    
    redirect_to :action => "index", :controller => "site"

  end

  private
  
  # Redirect to the previously requested URL (if present).
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
  
  # Return a string with the status of the remember me checkbox.
  def remember_me_string
    cookies[:remember_me] || "0"
  end
  
  # Try to update the user, redirecting if successful.
  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "User #{attribute} updated."
      redirect_to :action => "index"
    end
  end
end