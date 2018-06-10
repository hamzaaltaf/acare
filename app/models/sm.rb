class Sm < ActiveRecord::Base
	validates_presence_of :to, :message
end
