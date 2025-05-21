class AddBannerGroupToBanner < ActiveRecord::Migration[6.0]
  def change
    add_reference :banners, :banner_group, foreign_key: { to_table: :banners }
  end
end
