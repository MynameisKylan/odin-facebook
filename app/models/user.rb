class User < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # User Profile Picture Validation
  validates_integrity_of :profile_picture
  validates_processing_of :profile_picture

  has_many :posts
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, class_name: 'Post', source: 'post'

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
