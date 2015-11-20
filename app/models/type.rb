class Type < ActiveRecord::Base
	has_many :subtypes
	has_many :sensors, :through => :subtypes
end