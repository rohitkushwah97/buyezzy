# frozen_string_literal: true

ActiveAdmin.register BxBlockLikeAPost::RestrictedWord, as: "RestrictedWord" do
  permit_params :word

  controller do
    def create
      super do |format|
        if resource.errors.any?
          flash[:alert] = resource.errors.full_messages.to_sentence # Display validation errors
          format.html { render :new }
        else
          flash[:notice] = "Restricted word was successfully created."
        end
      end
    end

    def update
      super do |format|
        if resource.errors.any?
          flash[:alert] = resource.errors.full_messages.to_sentence # Display validation errors
          format.html { render :edit }
        else
          flash[:notice] = "Restricted word was successfully updated."
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :word
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :word
    column :created_at
    column :updated_at
    actions
  end
end
