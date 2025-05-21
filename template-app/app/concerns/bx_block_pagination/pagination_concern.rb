module BxBlockPagination
  module PaginationConcern
    extend ActiveSupport::Concern

    included do
      before_action :set_pagination
    end

    def set_pagination
      page = params[:page].to_i.positive? ? params[:page].to_i : 1
      per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 10
      @current_page = page
      @per_page = per_page
    end

    def next_page
      @current_page + 1 if @current_page < @total_pages
    end

    def prev_page
      @current_page - 1 if @current_page > 1
    end

    def merge_pagination_attributes(collection)
      @total_pages = collection.total_count
      @pagination_attributes = { 
        meta: {
          pagination: {
            current_page: @current_page,
            next_page: next_page,
            prev_page: prev_page,
            total_pages: @total_pages,
            total_count:collection.count,
            per_page: @per_page
          }
        }
      }
    end
  end
end
