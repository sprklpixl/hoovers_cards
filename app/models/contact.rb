class Contact < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address", "content", "created_at", "email", "facebook", "id", "id_value", "instagram", "phone", "snapchat", "tiktok", "title", "twitter", "updated_at"]
  end
end
