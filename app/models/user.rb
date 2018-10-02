require 'bcrypt'

class User < ApplicationRecord
    validates :user_id, :password, :password_confirmation, :name, :contact, presence:true
    #validates :user_id, :password, :name, :contact, presence:true
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :user_id, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    #VALID_PASSWORD_REGEX = /(?=.*\d)(?=.*([a-z]))(?=.*([A-Z]))([\x20-\x7E]){8,20}/
    #validates :password, format: { with: VALID_PASSWORD_REGEX }
    validates :password, confirmation: true
    validates :password, length:{minimum:8}

    validates :name, length:{minimum:2}

    validates :contact, numericality: true, length:{is:10}
end
