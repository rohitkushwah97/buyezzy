ActiveAdmin.register BxBlockSubscriptionBilling::Subscription, as: 'Subscription' do
  permit_params :title, :amount
  actions :all, except: [:destroy, :new]

  form do |f|
    f.input :title, required: true
    f.input :amount, required: true
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :amount
    end
  end
end
