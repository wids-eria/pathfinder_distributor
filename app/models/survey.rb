class Survey < ActiveRecord::Base
  attr_accessible :version,:created_at

  validates_presence_of :version
  validates_uniqueness_of :version
end
