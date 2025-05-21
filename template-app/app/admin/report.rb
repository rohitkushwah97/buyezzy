ActiveAdmin.register BxBlockProfile::Report, as: 'Report' do
  menu label: 'Report'

  actions :index, :show,:destroy
  remove_filter :created_for, :created_by, :attachment_blob

  # Ensure reports are ordered by ID in descending order
  controller do
    def scoped_collection
      super.order(id: :desc) # Orders by ID in descending order
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :internship

    column 'Created For' do |report|
      if report.created_for.present?
        link_text = if report.created_for.is_a?(AccountBlock::BusinessUser)
                      # Display company name if available, otherwise "N/A"
                      report.created_for.company_detail&.company_name.presence || "N/A"
                    else
                      # For non-BusinessUser, fallback to full_name or "N/A"
                      report.created_for.full_name.presence || "N/A"
                    end

        # Link to appropriate user path
        if report.created_for.is_a?(AccountBlock::BusinessUser)
          link_to link_text, admin_business_user_path(report.created_for)
        else
          link_to link_text, admin_intern_user_path(report.created_for)
        end
      end
    end

    column 'Created By' do |report|
      if report.created_by.present?
        link_text = if report.created_by.is_a?(AccountBlock::BusinessUser)
                      # Display company name if available, otherwise "N/A"
                      report.created_by.company_detail&.company_name.presence || "N/A"
                    else
                      # For non-BusinessUser, fallback to full_name or "N/A"
                      report.created_by.full_name.presence || "N/A"
                    end

        # Link to appropriate user path
        if report.created_by.is_a?(AccountBlock::BusinessUser)
          link_to link_text, admin_business_user_path(report.created_by)
        else
          link_to link_text, admin_intern_user_path(report.created_by)
        end
      end
    end

    column 'Created At', :created_at
    column 'Updated At', :updated_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :internship

      row 'Created For' do |report|
        if report.created_for.present?
          link_text = if report.created_for.is_a?(AccountBlock::BusinessUser)
                        # Display company name if available, otherwise "N/A"
                        report.created_for.company_detail&.company_name.presence || "N/A"
                      else
                        # For non-BusinessUser, fallback to full_name or "N/A"
                        report.created_for.full_name.presence || "N/A"
                      end

          if report.created_for.is_a?(AccountBlock::BusinessUser)
            link_to link_text, admin_business_user_path(report.created_for)
          else
            link_to link_text, admin_intern_user_path(report.created_for)
          end
        end
      end

      row 'Created By' do |report|
        if report.created_by.present?
          link_text = if report.created_by.is_a?(AccountBlock::BusinessUser)
                        # Display company name if available, otherwise "N/A"
                        report.created_by.company_detail&.company_name.presence || "N/A"
                      else
                        # For non-BusinessUser, fallback to full_name or "N/A"
                        report.created_by.full_name.presence || "N/A"
                      end

          if report.created_by.is_a?(AccountBlock::BusinessUser)
            link_to link_text, admin_business_user_path(report.created_by)
          else
            link_to link_text, admin_intern_user_path(report.created_by)
          end
        end
      end

      row :created_at
      row :updated_at
    end
  end
end
