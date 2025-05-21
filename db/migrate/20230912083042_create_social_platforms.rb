class CreateSocialPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :social_platforms do |t|
      t.string :social_media
      t.string :social_media_url

      t.timestamps
    end
  end
end
