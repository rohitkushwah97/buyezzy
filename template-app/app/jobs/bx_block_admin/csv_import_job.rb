module BxBlockAdmin
  class CsvImportJob < BuilderBase::ApplicationJob
    include CsvImportable

    private

    def build_user_from_row(model_class, row)
      model_class.new(email: row['email'], password: row['password'])
    end
  end
end