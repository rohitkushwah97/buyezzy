ActiveAdmin.register BxBlockCouponCg::CouponCode, as: 'Coupons' do
  menu if: proc { false }
  permit_params :title, :code, :discount, :valid_from, :valid_to
  actions :index, :show, :new, :create, :update, :edit

  action_item :delete_coupon, only: [:show] do
    if resource.persisted? && resource.subscribe_coupons.empty?
      link_to 'Delete Coupon', delete_coupon_admin_coupon_path(resource), method: :delete
    end
  end

  member_action :delete_coupon, method: :delete do
    resource.destroy
    redirect_to admin_coupons_path, notice: 'Coupon deleted successfully.'
  end

  scope 'All Coupons', default: true do |coupons|
    BxBlockCouponCg::CouponCode.where(account_id: nil)
  end

  scope 'My Coupons' do |coupons|
    BxBlockCouponCg::CouponCode.joins(:subscribe_coupons)
  end


  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, label: "Coupon Name"
      f.input :code, label: "Coupon Code"
      f.input :discount, input_html: { min: 0, type: 'text', class: 'required numeric-input' }
      f.input :valid_from, label: "Start Date", as: :datepicker, input_html: { min: Date.current.to_s }
      f.input :valid_to, label: "End Date", as: :datepicker, input_html: { min: Date.current.to_s }
    end
    f.actions
  end

  index do
    selectable_column
    column "Coupons Name", :title
    column "Coupons Code", :code
    column :discount
    column "Start Date", :valid_from
    column "End Date", :valid_to
    actions defaults: false do |row|
      div class: 'table_actions' do
        text_node link_to "View", admin_coupon_path(row),method: :get, class: "view_link member_link"
        text_node link_to "Edit", edit_admin_coupon_path(row), class: "edit_link member_link"
        
        unless row.subscribe_coupons.present?
          text_node link_to I18n.t('active_admin.delete'), delete_coupon_admin_coupon_path(row), method: :delete, data: { confirm: I18n.t('active_admin.delete_confirmation') }, class: "delete_link member_link"
        end
      end
    end
  end

  show do
    attributes_table do
      row :title
      row :code
      row :discount
      row :valid_from
      row :valid_to
      row :status
    end
  end
end
