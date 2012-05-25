class PagesController < ApplicationController
  include TheSortableTreeController::Rebuild
  
  def mercury_update
    logger.info(params[:id])
    if params[:id] == 'root'
      page = Page.first(:conditions => {:root => true})
    else
      page = Page.find_by_slug(params[:id])
    end
    page.name = params[:content][:page_name][:value]
    page.content_en = params[:content][:page_content_en][:value]
    page.content_zh = params[:content][:page_content_zh][:value]
    page.save!
    render text: ""
  end
  
  def toggle_display
    @page = Page.find(params[:id])
    
    if @page.hidden
      @page.hidden = false
    else
      @page.hidden = true
    end
    
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_path, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.nested_set.all(:order => 'lft asc')
    @page = create_standard_page
    logger.info("::::::::::::::#{request.path}")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find_by_slug(params[:id])
    
    if @page
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @page }
      end
    else
      # rescue ActiveRecord::RecordNotFound
      render(:file => "#{Rails.root}/public/404.html", :layout => false, :status => 404)
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find_by_slug(params[:id])
    @page.sidebar = true
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_path, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find_by_slug(params[:id])
    
    if params[:content]
      @page.content_en = params[:content][:page_content_en][:value] if params[:content][:page_content_en] && params[:content][:page_content_en][:value]
      @page.content_zh = params[:content][:page_content_zh][:value] if params[:content][:page_content_zh] && params[:content][:page_content_zh][:value]
      @page.save!
    end

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find_by_slug(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
