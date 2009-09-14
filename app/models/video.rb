class Video < ActiveRecord::Base
  belongs_to :page
  # validates_url_format_of :url,:allow_nil => true, :message => 'is not a valid url'
  
end
