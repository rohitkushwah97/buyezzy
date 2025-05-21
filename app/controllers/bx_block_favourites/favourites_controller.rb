module BxBlockFavourites
  class FavouritesController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch

    def index
      per_page = params[:per_page].presence&.to_i || 10
      page = params[:page].presence&.to_i || 1
      total_count = 0

      favourites = Favourite.where(user_id: current_user.id)

      if favourites.present?

        catalogue_ids = favourites.pluck(:favouriteable_id)

        catalogues = BxBlockCatalogue::Catalogue.includes(:product_content).where(id: catalogue_ids)

        if params[:sort_by].present?
          catalogues = sort_catalogues(catalogues, params[:sort_by]).pluck(:id)
          
          sanitized_sql = ActiveRecord::Base.sanitize_sql_array(["array_position(array[?], favouriteable_id::int)", catalogues])

          sorted_favourites = favourites.order(Arel.sql(sanitized_sql))
        else
          sorted_favourites = favourites.order(created_at: :desc)
        end

        if sorted_favourites
            # sorting favourites
            total_count = sorted_favourites.count
            sorted_favourites = paginate_catalogues(sorted_favourites, page, per_page)
        end

        render json: FavouriteSerializer.new(sorted_favourites).serializable_hash.merge(total_count: total_count),
        status: :ok
      else
        render json: [],
        status: :not_found
      end
    end

    def create
      favouriteable_type = find_favouriteable_type(params[:favouriteable_id])

      existing_favourite = Favourite.find_by(
        favouriteable_id: params[:favouriteable_id],
        user_id: current_user.id,
        favouriteable_type: favouriteable_type,
        product_variant_group_id: params[:product_variant_group_id]
        )

      unless existing_favourite

        favourite = Favourite.new(
          favourites_params.merge(
            user_id: current_user.id,
            favouriteable_type: favouriteable_type,
            product_variant_group_id: params[:product_variant_group_id]
            )
          )

        if favourite.save
          render json: BxBlockFavourites::FavouriteSerializer.new(favourite).serializable_hash,
          status: :ok
        else
          render json: { errors: favourite.errors },
          status: :unprocessable_entity
        end
      else
        render json: { message: "Product already exist in wishlist" },
          status: :ok
      end
    end

    def destroy
      favourite = BxBlockFavourites::Favourite.find(params[:id])
      if favourite.destroy
        render json: { message: "Destroy successfully" },
        status: :ok
      end
    end

    private

    def find_favouriteable_type(favouriteable_id)
      if params[:favouriteable_id].present?
        catalogue_exists = BxBlockCatalogue::Catalogue.exists?(id: params[:favouriteable_id])
        'BxBlockCatalogue::Catalogue' if catalogue_exists
      end
    end

    def favourites_params
      params.permit(:favouriteable_id, :user_id, :favouriteable_type, :product_variant_group_id)
    end
  end
end
