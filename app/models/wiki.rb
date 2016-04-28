class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  default_scope  { order('created_at DESC') }
  scope :visible_to, -> (user) {user && (user.premium? || user.admin?) ? all : where(:private => false) }

  validates :title, length:{maximum: 140}, presence: true
  validates :body, length: {minimum: 50}, presence: true

  def private_wiki
    self.private == true
  end
end
