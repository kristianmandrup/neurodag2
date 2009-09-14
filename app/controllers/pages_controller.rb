class PagesController < ApplicationController
  before_filter :get_pages, :except => [:new, :create, :index]

  # GET /page
  def show
    @title = @page.title
    @content = @page.body
    @embedded_video_html = @page.embedded_video_html
    @videos = @page.videos
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @post.to_xml }
    end    
  end
  
  
  # GET /pages
  def index
    @pages = Page.paginate :page => params[:page], :per_page => 2, :order => 'created_at DESC'
    @title = "Pages"

    respond_to do |format|
      format.html # index.rhtml
    end
  end

  # GET /page/new
  def new
    @page = Page.new
    @parent_page_id = params[:page]
    @conference_id = params[:conference_id]
    @title = "Add a new page"
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])   
    parent_id = params[:parent_id]
    if parent_id != ""
      @parent_page = Page.find(parent_id)
    else
      conf_id = params[:conference_id]
      @conference = Conference.find(conf_id)
    end     
    respond_to do |format|
      # save created page and attempt to add it as child of parent page!
      if @page.save 
        if @parent_page
          @parent_page.children << @page
        else
           @conference.pages << @page
        end
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to page_url(:id => @page) }
        format.xml  { head :created, :location => page_url(:id => @page) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors.to_xml }
      end
    end
  end


  # GET /page/1;edit
  def edit
    @title = "Edit #{@page.title}"
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to page_url(:id => @page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors.to_xml }
      end
    end        
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.xml  { head :ok }
    end
  end  

private
  def get_pages
    @page = Page.find(params[:id], :include => :videos)
    # find alle ancestors (parents)
    # @ancestors = @page.ancestors
  end
  
end
