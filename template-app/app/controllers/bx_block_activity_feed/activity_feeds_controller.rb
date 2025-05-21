# frozen_string_literal: true

module BxBlockActivityFeed
  class ActivityFeedsController < BxBlockActivityFeed::ApplicationController
    require 'csv'
    before_action :validate_json_web_token, only: :account_feeds
    before_action :fetch_feed, only: :show

    def index
      if params[:page].present?
        page = params[:page]
      else
        page = 1  
      end
      if params[:items_per_page].present?
        items_per_page = params[:items_per_page]
      else
        items_per_page = 10
      end
      offsetVal = 0;
      if params[:trackable_type].present?
        feedscount = PublicActivity::Activity.where(trackable_type: params[:trackable_type]).count
      else
        feedscount = PublicActivity::Activity.all.count
      end
      if page == 1
        offsetVal = 0
      else
          offsetVal = (((page.to_i-1)*items_per_page.to_i)).to_i
        
      end  
      if params[:trackable_type].present?
        feeds = PublicActivity::Activity.where(trackable_type: params[:trackable_type]).limit(items_per_page).offset(offsetVal)
      else
        feeds = PublicActivity::Activity.all.limit(items_per_page).offset(offsetVal)
      end
      feed_response(feeds)
    end

    def export_csv
      feeddata = PublicActivity::Activity.all()
      feedcsvdata = []
      csv_column_names = ['trackable_type','trackable_id','key','created_at','updated_at','owner_username','owner_email','owner_id']
      feeddata.each do |fdata|
        owner = find_owner(fdata)
        myobj = {}
        csv_column_names.each do |x|
          if x == 'owner_username'
              myobj["#{x}"] = owner&.user_name
            elsif x == 'owner_email'
              myobj["#{x}"] = owner&.email
            elsif x == "created_at" || x == "updated_at"
               myobj["#{x}"] = fdata["#{x}"].strftime("%d-%m-%Y")
           else   
         myobj["#{x}"] = fdata["#{x}"]
        end
        end 
      feedcsvdata << myobj
      end

      # p feedcsvdata
      @csv_data = CSV.generate(headers: true) do |csv|
      fields = csv_column_names
          csv << fields
          feedcsvdata.each do |fdata|
              csv << fdata
            end
      end
      send_data @csv_data , :type => 'text/csv; charset=iso-8859-1; header=present',
                  :disposition => "attachment; filename=#{DateTime.now}.csv"

    end
      

    def account_feeds
      feeds = PublicActivity::Activity.where(
        owner_type: "AccountBlock::Account", owner_id: current_user.id
      )
      feed_response(feeds)
    end

    def show
      render json: {feed: @feed.as_json, code: 200}
    end

    private

    def feed_response(feeds)
      if feeds.present?
        render json: {
          activities: feeds.map do |feed|
            feed.as_json.merge(trackable: find_trackable(feed), owner: find_owner(feed))
          end, code: 200
        }
      else
        render json: {message: "No Records found", code: 404}, 
        status: :not_found
      end
    end

    def find_trackable(feed)
      trackable = feed.trackable
    end

    def find_owner(feed)
      trackable = feed.owner
    end

    def fetch_feed
      @feed = PublicActivity::Activity.find(params[:id])
    end
  end
end
