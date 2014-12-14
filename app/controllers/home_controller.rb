class HomeController < ApplicationController

  def fetch_friend_data
    client=Twitter::REST::Client.new do |config|
      config.consumer_key = "6udOb18hbicIWoJOBlZIIEENP"
      config.consumer_secret= "QPYFqYsOA3hPGHRploGXLYHqMfMOEj9ROsxqEaoLx7TXrJiPmV"
      config.access_token= "#{current_user.oauth_token}"
      config.access_token_secret="#{current_user.oauth_secret}"
    end
    @friends = client.friends.to_a
    @friends.each do |f|
      if f.location.present?
        location_value = Geocoder.coordinates("#{f.location}")
        if location_value
          Friend.get_friend_data(f,location_value,current_user.id)
        end
      end
    end
    redirect_to map_display_index_path
  end

end
