class Sensor < ActiveRecord::Base
	has_many :measurements
	belongs_to :subtype
	delegate :type, to: :subtype
	belongs_to :program
	
	def amounts (start, stop)
		self.measurements.
		where("date >= ?", start).
		where("date < ?", stop).
		map {|m| m.amount}
	end
	def times
		self.measurements.map {|m| m.date}
	end
end