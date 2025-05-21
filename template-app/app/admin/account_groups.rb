# unless AccountGroups::Load.is_loaded_from_gem
#   # Register resource only if not loaded from the gem
#   ActiveAdmin.register BxBlockAccountGroups::Group do
#     permit_params :name, :settings, :account_ids

#     index do
#       selectable_column
#       id_column
#       column :name
#       column :settings
#       column :account_ids
#       actions
#     end

#     filter :name
#     filter :created_at

#     form do |f|
#       f.inputs do
#         f.input :name
#         f.input :settings
#         f.input :account_ids
#       end
#       f.actions
#     end
#   end
# end
