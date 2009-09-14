class CommunityController < ApplicationController
  helper :profile
  before_filter :protect

  def index
     @users = User.paginate :all, :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end
  
  def browse_all
     @title = "Browse Community"
     order = params[:order]
     logger.debug("ORDER #{order}")
     @users = User.paginate :all, :page => params[:page], :order => 'created_at DESC', :per_page => 10
   end
 
  # def browse
  #   @title = "Browse"
  #   return if params[:commit].nil?
  #   if valid_input?
  #     specs = Spec.find_by_asl(params)
  #     @users = specs.collect { |spec| spec.user }
  #     @users.paginate :page => params[:page], :order => 'created_at DESC'
  #   end
  # end

  # def search
  #   @title = "Search #{@site_name}"
  #   if params[:q]
  #     query = params[:q]
  #     logger.debug("Do ferret search")
  #     begin
  #       # First find the user hits...
  #       @users = User.find_with_ferret(query, :limit => :all)
  #       # ...then the subhits.
  #       specs = Spec.find_with_ferret(query, :limit => :all)
  #       faqs  =  Faq.find_with_ferret(query, :limit => :all)
  #       # Now combine into one list of distinct users sorted by last name.
  #       hits = specs + faqs
  #       
  #       logger.debug("User hits found for '#{query}' : #{@users.size}")
  #       logger.debug("Hits found for '#{query}' : #{hits.size}")
  #       
  #       @users.concat(hits.collect { |hit| hit.user }).uniq!        
  #       # Sort by last name (requires a spec for each user).
  #       @users.each { |user| user.spec ||= Spec.new }      
  #       @users = @users.sort_by { |user| user.spec.last_name }
  #       
  #       @users.paginate :page => params[:page], :order => 'created_at DESC'
  #     rescue Ferret::QueryParser::QueryParseException
  #       @invalid = true
  #     end
  #   end
  # end
  
  private

  # Return true if the browse form input is valid, false otherwise.
  def valid_input?
    @spec = Spec.new
    # The input is valid iff the errors object is empty.
    @spec.errors.empty?
  end
end