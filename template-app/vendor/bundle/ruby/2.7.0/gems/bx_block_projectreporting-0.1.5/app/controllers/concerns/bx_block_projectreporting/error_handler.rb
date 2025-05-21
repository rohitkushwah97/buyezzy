module BxBlockProjectreporting
  module ErrorHandler
    def format_activerecord_errors(errors)
      errors.map do |attribute, error|
        { attribute => error }
      end
    end

    def item_not_found(type, id)
      render json: {
               errors: [{
                 type.to_s => "Record with id=#{id} not found"
               }]
             },
             status: :not_found
    end
  end
end
