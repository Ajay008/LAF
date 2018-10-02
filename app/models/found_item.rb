class FoundItem < ApplicationRecord
    validates :item_type, :color, :brand, :storage_loc, :locker_id, presence:true 
end
