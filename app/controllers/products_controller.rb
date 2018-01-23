class ProductsController < ApplicationController

  def show
    @categories = ProductCategory.nested_set_scope
    @product = Product.find(params[:id])
  end
end