class OwnedSet < ApplicationRecord
    belongs_to :user
    belongs_to :lego_set
    validates :lego_set, uniqueness: { scope: :user }
end
