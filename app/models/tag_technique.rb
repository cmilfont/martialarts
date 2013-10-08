class TagTechnique < ActiveRecord::Base
  belongs_to :tag
  belongs_to :technique
end
