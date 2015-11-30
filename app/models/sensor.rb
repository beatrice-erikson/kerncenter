class Sensor < ActiveRecord::Base
	has_many :measurements
	belongs_to :subtype
	delegate :type, to: :subtype
	belongs_to :room
	
	def amounts (start, stop)
		self.measurements.
		where("time >= ?", start).
		where("time < ?", stop).
		map {|m| m.amount}
	end
	def times
		self.measurements.map {|m| m.time}
	end
end