class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :sort_by_newest, -> { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : where(public: true)}
end
