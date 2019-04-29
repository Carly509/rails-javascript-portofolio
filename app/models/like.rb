class Like < ApplicationRecord
    belongs_to :user
 belongs_to :tweet

 
 validates_uniqueness_of :user, scope: :tweet
end
