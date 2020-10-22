class User < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Make user omniauthable
  devise :omniauthable, omniauth_providers: %i[facebook]
  
  # User Profile Picture Validation
  validates_integrity_of :profile_picture
  validates_processing_of :profile_picture

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, class_name: 'Post', source: 'post'
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :incoming_friend_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id', dependent: :destroy
  has_many :outgoing_friend_requests, class_name: 'FriendRequest', foreign_key: 'from_id', dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]   # assuming the user model has a name
      user.last_name = auth.info.name.split[1]
      user.profile_picture = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
