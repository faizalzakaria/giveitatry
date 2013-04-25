class Image < ActiveRecord::Base
  attr_accessible :description, :url

  validates :url, :presence => true, :uniqueness => true, :uri => {
    :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  }
  validates :description, :presence => true, :length => { :minimum => 5 }

end
