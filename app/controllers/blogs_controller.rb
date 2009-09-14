class BlogsController < ApplicationController
  helper :profile
  
  # GET /blog
  def show
    @blog = Blog.find(params[:id])
    @title = @blog.title
    @content = @blog.body
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @blog.to_xml }
    end    
  end
  
  # GET /blogs
  def index
    @blogs = Blog.paginate :page => params[:page], :per_page => 10, :order => 'created_at DESC'
    @title = "Blogs"
    respond_to do |format|
      format.html # index.rhtml
    end
  end 
    
  # GET /posts/new
  def new
    @blog = Blog.new
    @title = "Create a new blog"
  end

  # GET /posts/1;edit
  def edit
    @blog = Blog.find(params[:id])
    @title = "Edit #{@blog.title}"
  end

  # POST /posts
  # POST /posts.xml
  def create
    @blog = Blog.new(params[:blog]) 
    @blog.user = current_user   
    if @blog.save
      flash[:notice] = 'Blog was successfully created.'
      redirect_to blog_url(:id => @blog)
    else
      render :action => "new"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to blog_url(:id => @blog) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blog_url }
      format.xml  { head :ok }
    end
  end
  
end