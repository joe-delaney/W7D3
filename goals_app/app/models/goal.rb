class Goal < ApplicationRecord
  validates :title,:user_id, presence:true
  validates :private?,:completed?, inclusion: {in: [true,false]}

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
