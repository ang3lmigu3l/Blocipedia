class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope  { order('created_at DESC') }
  scope :visible_to, -> (user) {user && (user.premium? || user.admin?) ? all : where(:private => [false,nil]) }
  scope :private_wikis, -> (user) {user && (user.premium? || user.admin?) ? where(:private => true ): nil}

  validates :title, length:{maximum: 140}, presence: true
  validates :body, length: {minimum: 50}, presence: true

  def private_wiki
    self.private == true
  end
end
