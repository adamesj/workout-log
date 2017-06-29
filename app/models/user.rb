class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User" #friends is an alias for users

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    names_array = name.split(' ') # the string entered gets split into an array

    if names_array.size == 1 # if only a first name is entered
      where('first_name LIKE ? or last_name LIKE ?', # look up names where the first name is similar or last name is similar from the array
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name) # then order by the first name
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ?
        or last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
      # if more than one name is entered, the code above will be executed
      # the order of the names entered do not matter
    end
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
    # friendships returns an array, then we map over the array
    # and determine all of the friends
    # then check if the new_friend passed is included in the list
    # or test if the current user is a new friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end
end
