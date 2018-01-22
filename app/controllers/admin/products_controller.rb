class Admin::ProductsController < Admin::BaseController
  before_action :set_product_category
  before_action :set_product, :only=>[:edit, :update, :destroy]
  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.product_category= @category
    if @product.save
      redirect_to admin_product_category_products_url(@category), :notice=>'创建成功！'
    else
      render :new
    end
  end

  def edit
    render :new
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_category_products_url(@category), :notice=>'修改成功！'
    else
      render :new
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_product_category_products_url(@category), :notice=>'操作成功！'
    else
      render :back
    end
  end

  private
  def product_params
    params.require(:product).permit(:product_category_id, :title, :status, :uuid, :msrp, :price,
                                    :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_category
    @category = ProductCategory.find(params[:product_category_id])
  end
end