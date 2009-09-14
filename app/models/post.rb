class Post < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, :order => "created_at", :dependent => :destroy
  
  validates_presence_of :title, :body, :blog
  validates_length_of :title, :maximum => 200
  validates_length_of :body,  :maximum => 2000

  # Prevent duplicate posts.
  validates_uniqueness_of :body, :scope => [:title, :blog_id]
  
  # Return true for a duplicate post (same title and body).
  def duplicate?
    post = Post.find_by_blog_id_and_title_and_body(blog_id, title, body)
    # Give self the id for REST routing purposes.
    self.id = post.id unless post.nil?
    not post.nil?
  end
end