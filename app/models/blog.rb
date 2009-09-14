class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :conference
  has_many :posts, :order => "created_at DESC"
  
  def owner
    if user
      user.full_name
    else
      ""
    end
  end
end