module CsvImportable
  extend ActiveSupport::Concern

  included do
    def perform(csv_data, model_class_name)
      model_class = model_class_name.constantize
      errors = []
      batch_size = 50
      batch = []

      csv_table = CSV.parse(csv_data, headers: true)
      headers = csv_table.headers

      csv_table.each do |row|
        user = build_user_from_row(model_class, row)
        original_row = row.to_h
        batch << { user: user, original_row: original_row }

        if batch.size >= batch_size
          process_batch(batch, errors)
          batch.clear
        end
      end

      process_batch(batch, errors) if batch.any?
      handle_errors_and_notifications(errors, headers)
    end
  end

  private

  def process_batch(batch, errors)
    ActiveRecord::Base.transaction do
      batch.each do |item|
        user = item[:user]
        original_row = item[:original_row]

        unless user.save
          error_messages = user.errors.full_messages.join(', ')
          original_row['error'] = error_messages
          errors << original_row
        end
      end
    end
  end

  def handle_errors_and_notifications(errors, headers)
    if errors.any?
      error_csv_path = Rails.root.join('public', "errors_#{Time.now.to_i}.csv")
      CSV.open(error_csv_path, 'w') do |csv|
        csv << headers + ['error']
  
        errors.each do |error_row|
          csv << error_row.values
        end
      end
      notification = BxBlockNotifications::AdminNotification.create(
        message: 'CSV import failed. Please check the attached file for errors.'
      )
      notification.attachment.attach(io: File.open(error_csv_path), filename: 'errors.csv')
      File.delete(error_csv_path) if File.exist?(error_csv_path)
    else
      BxBlockNotifications::AdminNotification.create(
        message: 'Users successfully imported!'
      )
    end
  end
end
