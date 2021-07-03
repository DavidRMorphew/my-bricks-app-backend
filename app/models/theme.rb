class Theme < ApplicationRecord
    has_many :lego_sets, dependent: :destroy
end
