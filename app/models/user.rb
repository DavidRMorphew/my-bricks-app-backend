class User < ApplicationRecord
    has_secure_password
    validates :name, :email, presence: true
    before_validation :downcase_email
    validates :email, uniqueness: {case_sensitive: false}
    has_many :owned_sets
    has_many :lego_sets, through: :owned_sets

    def downcase_email
        self.email = self.email.downcase if self.email
    end
end
