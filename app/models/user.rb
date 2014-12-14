class User < ActiveRecord::Base
  has_many :friends
  def self.create_with_omniauth(auth)
    location = auth["info"]["location"] || ""
    if location.present?
      user_location = Geocoder.coordinates("#{location}")
    else
      user_location = []
      user_location[0] = 41.87194
      user_location[1] = 12.56738
    end
    create! do |user|
      user.provider=auth["provider"]
      user.uid=auth["uid"]
      user.name=auth["info"]["name"] || ""
      user.address=auth["info"]["location"] || ""
      user.avatar=auth["info"]["image"] || ""
      user.oauth_token=auth["credentials"]["token"] || ""
      user.oauth_secret=auth["credentials"]["secret"] || ""
      user.latitude = user_location.first
      user.longitude = user_location.second
    end
  end
end
