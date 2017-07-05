class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
<<<<<<< HEAD
         
  has_many :questions  , dependent: :destroy
=======
  has_many :questions , dependent: :destroy
>>>>>>> 0d891d31cbccf21cc6c3e6f91a76de6d6abaf372
end
