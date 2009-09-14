class Poster < ActiveRecord::Base
    include ApplicationHelper
    belongs_to :registration
    belongs_to :user
    belongs_to :conference
    
    ajaxful_rateable :stars => 5, :allow_update => true, :dimensions => [:research] #, :cache_column => 'ctalk'
    
  def owner_name
    if owner
      owner.name
    else
      "No owner"
    end  
  end
      
  def owner
    user
  end
  
  def owner=(u)
    user = u
  end  
end
