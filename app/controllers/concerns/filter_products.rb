module FilterProducts
  extend ActiveSupport::Concern

  private

  def filter_products(params)
    if params[:type]
      Product.where(type: params[:type])
    elsif params[:manufacturer]
      Product.where(manufacturer: params[:manufacturer])
    else
      nil
    end
  end

end