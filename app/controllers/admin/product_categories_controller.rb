class Admin::ProductCategoriesController < Admin::BaseController
  include CollectiveIdea::Acts::NestedSet::Helper
before_action :set_category, :only=>[:edit, :update, :destroy, :up, :down]
  def index
    @categories = ProductCategory.nested_set_scope
  end

  def new
    @category = ProductCategory.new
  end

  def create
    @category = ProductCategory.new(category_params)
    if @category.save
      redirect_to admin_product_categories_url, :notice=>'创建成功'
    else
      render :new
    end
  end

  def edit
      render :new
  end

  def update
    if @category.update(category_params)
      redirect_to admin_product_categories_url, :notice=>'修改成功！'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_product_categories_url, :notice=>'操作成功！'
    else
      render :back
    end
  end

  def up
    @category.move_left
    redirect_to admin_product_categories_url, :notice=>'向上移动成功'
  end

  def down
    @category.move_right
    redirect_to admin_product_categories_url, :notice=>'向下移动成功'
  end

  private
  def category_params
    params.require(:product_category).permit(:title, :parent_id, :lft, :rgt, :depth, :children_count, :position)
  end

  def set_category
    @category = ProductCategory.find(params[:id])
  end
end