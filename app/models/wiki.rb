class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope  { order('created_at DESC') }
  scope :visible_to, -> (user) {user && (user.premium? || user.admin?) ? all : where(:private => [false,nil]) }
  scope :private_wikis, -> (user) {user && (user.premium? || user.admin?) ? where(:private => true ): nil}

  def private_wiki
    self.private == true
  end
end
