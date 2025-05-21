ActiveAdmin.register BxBlockPosts::Post, as: "Posts" do
	NAME = "Account Name"
  menu label: 'Posts'

  actions :all, except: [:edit, :new]

  index do
    selectable_column
    id_column
    column :name
    column :account_id
    column NAME, sortable: 'accounts.full_name' do |post|
      post.account&.full_name || post.account&.company_detail.company_name
    end
    column :created_at

    actions defaults: false do |post|
      links = []
      links << link_to("View", admin_post_path(post), class: "member_link")
      links << link_to("Delete", admin_post_path(post), method: :delete, data: { confirm: "Are you sure?" }, class: "member_link")
      safe_join(links, " | ")
    end
  end

  filter :name
  filter :account_id
  filter :account_full_name, as: :string, label: NAME
  filter :body
  filter :created_at

  show do
    attributes_table do
      row :name
      row :body
      row :account_id
      row NAME do |post|
        post.account&.full_name || post.account&.company_detail.company_name
      end
      row :created_at
      row :updated_at
    end

    panel "Likes Data" do
      likes = BxBlockLike::Like.where(likeable_id: resource.id).includes(:like_by)
      if likes.any?
        table_for likes do
          column "User ID", :like_by_id
          column "User Name" do |like|
            like.like_by&.full_name || like.like_by&.company_detail.company_name
          end
          column "Created At", :created_at
        end
      else
        div "No likes yet."
      end
    end

    # panel "Images" do
    #   if resource.images.attached?
    #     div do
    #       resource.images.each do |image|
    #         div do
    #           image_tag url_for(image), size: "200x200"
    #         end
    #       end
    #     end
    #   else
    #     div "No images available."
    #   end
    # end

  end
end
