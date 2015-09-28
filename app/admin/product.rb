ActiveAdmin.register Product do

  action_item :only => :index do
    link_to 'Upload XLS', :action => 'upload_xls'
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :description
      f.input :color
    end
    f.actions
  end

  batch_action :total_annihilation do
    Product.all.each do |product|
      product.destroy
    end
    redirect_to collection_path, alert: 'Everybody\'s dead'
  end

  collection_action :upload_xls do

  end

  collection_action :import_xls, method: :post do
    session[:new_products] = Product.import_xls params[:xls]
    redirect_to action: :upload_images
  end

  collection_action :upload_images do

    @new_id = session[:new_products]

  end

  collection_action :import_images, method: :post do

    session[:new_products].size.times do |i|
      product = Product.find(session[:new_products][i])
      product.image = params[:image][i]
      product.save
    end

    redirect_to action: :index
  end


end
