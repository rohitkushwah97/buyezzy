ActiveAdmin.register BxBlockBlockUsers::BlockUser, as: 'Block Users' do
  menu label: 'Blocked Users'

  NAME = "Account Name"
  actions :all, :except => :destroy
  actions :all, :except => :edit
  actions :all, :except => :new

  filter :email
  filter :activated

  permit_params :date_of_birth,  :email, :password,:full_phone_number,
                :address,:first_name, :company_name,
                :full_name,:update_by,:is_blacklisted,:device_id,
                profile_attributes: [:id, :country_id, :city_id, :photo]
  
  index do
    selectable_column
    id_column
    column :blocker_username do |obj|
      obj.current_user.full_name
    end

    column NAME, sortable: 'accounts.full_name' do |block_user|
      if block_user.account.type.eql?("BusinessUser")
        block_user.account&.company_detail.company_name
      else
        block_user.account&.full_name
      end
    end

    column :email do |obj|
      obj.account.email
    end
    column :type do |obj|
      obj.account.type
    end
    column :activated do |obj|
      obj.account.activated
    end

    column 'created_at' do |obj|
      obj.account.created_at.in_time_zone
    end
    column 'updated_at' do |obj|
      obj.account.updated_at.in_time_zone
    end
    actions
  end

  show do
    attributes_table do
      row :full_name do |obj|
        obj.account
      end

      row :email do |obj|
        obj.account.email
      end
      row :type do |obj|
        obj.account.type
      end
      row :activated do |obj|
        obj.account.activated
      end

    end
  end
end