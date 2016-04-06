class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :sort_by_newest, -> { order('created_at DESC') }
end
