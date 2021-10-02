class User < ApplicationRecord
    validates :email, uniqueness: {case_sensitive: false}
    before_validation :downcase_email
    has_secure_password

    def downcase_email
        self.email = self.email.downcase
    end
end
