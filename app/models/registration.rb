class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :conference
  has_many :posters, :dependent => :destroy
  has_one :talk, :dependent => :destroy
  
  validates_uniqueness_of :user_id, :scope => :conference_id

  def user_name
    user.name
  end

  def bringing_poster
    if bringing_posters
      "Yes"
    else
      "No"
    end
  end

  def giving_talk
    if selected_for_competition || plenary_speaker
      "Yes"
    else
      "No"
    end
  end

  def payment_status_txt
    if payment_status
      "yes"
    else
      "no"
    end
  end

  def user_title
    spec = user.spec
    if spec
      spec.title
    else
      ""
    end
  end

end
