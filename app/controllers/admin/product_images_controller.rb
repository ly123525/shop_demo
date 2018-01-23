class Admin::ProductImagesController < Admin::BaseController
before_action :find_product
before_action :find_image, :only=>[:destroy, :update]
  def index
    @images = @product.product_images
  end

  def create
    params[:images].each do |image|
      @product.product_images << ProductImage.new(image: image)
    end
      redirect_to :back
  end

  def destroy
    @image.destroy
    flash[:notice] = '操作成功！'
    redirect_to :back
  end

  def update
    @image.weight = params[:weight]
    if @image.save
      flash[:notice] = '修改成功！'
    else
      flash[:notice]= '修改失败！'
    end
      redirect_to :back
  end

  private
  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_image
    @image = @product.product_images.find(params[:id])
  end
end