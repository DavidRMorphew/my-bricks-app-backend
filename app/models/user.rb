class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: {case_sensitive: false}
    before_validation :downcase_email
    has_many :owned_sets
    has_many :lego_sets, through: :owned_sets

    def downcase_email
        self.email = self.email.downcase
    end
end