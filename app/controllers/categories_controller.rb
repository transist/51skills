class CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild
  before_filter :yield_page
  before_filter :current_user_admin!
  
  def yield_page
    @page = create_standard_page
  end
  
  def index
    @categories = Category.nested_set.all(:order => 'lft asc')
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.create(params[:category])
    redirect_to categories_path, notice: 'Category was successfully created.' 
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "The Category #{@category.name(I18n.locale)} was successfully destroyed."
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    redirect_to categories_path, notice: "The Category #{@category.name(I18n.locale)} was successfully updated."
  end
  
  def sub_categories
    main_category = Category.find(params[:category_id])
    render json: main_category.sub_categories
  end
  
  def show
    @category = Category.find params[:id]
    @category.counting(1) unless current_user_admin?
    if @category.main_category?
      all_courses = []
      @category.children.each do |child|
        all_courses = all_courses | child.courses
      end
      @courses = all_courses.paginate(:page => params[:page], :per_page => 12)
    else
      @courses = @category.courses.paginate(:page => params[:page], :per_page => 12)
    end
    render 'courses/index'
  end
end
