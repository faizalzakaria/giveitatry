class Image < ActiveRecord::Base
  attr_accessible :description, :url, :title

  validates :url, :presence => true, :uniqueness => true, :uri => {
    :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  }
  validates :title, :presence => true, :length => { :maximum => 20 }
  validates :description, :length => { :maximum => 100 }

end
