class LostRequest < ApplicationRecord
    validates :item_type, :color, :brand, presence:true 

    validate :date_cannot_be_future_date

    def date_cannot_be_future_date
        if date.present? && date > Date.today
            errors.add(:date, "can't be a future date.")
        end
    end  



end
