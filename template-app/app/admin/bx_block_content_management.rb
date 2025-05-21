# module BxBlockContentManagement

# end

# ActiveAdmin.register BxBlockContentManagement::ContentManagement, as: 'Content Management' do


# 	permit_params :title, :description, :status, :price, :quantity, :user_type, images:[]

#   	index do
# 	  	selectable_column
# 	        id_column
# 	        column :title
# 			column :price
# 			column :user_type
# 			column :quantity
# 			column :image
# 	        column :description
# 	        column :status
# 	    actions
#   	end

#   	show do
# 	    attributes_table do
# 	      row :title
# 	      row :description
# 		  row :price
# 		  row :quantity
# 		  row :user_type
# 	      row :status
#           row :images do |s|
# 			s.images.map do |img|
# 			  span do
# 				image_tag(img, height: '100', width: '100') rescue nil
# 				end
# 			  ""
# 			  end
# 			end
# 	      #row :created_at
# 	      #row :updated_at

# 	    end
#   	end

#     form do |f|
#         f.semantic_errors *f.object.errors.keys
#         f.inputs do
# 	      	f.inputs :title
# 	        f.inputs :description
# 			f.inputs :price
# 			f.inputs :quantity
# 			f.inputs :user_type
# 	        f.inputs :status
#             f.input :images, as: :file, input_html: { multiple: true }
#         end
#         f.actions
#     end
# end
# # end
