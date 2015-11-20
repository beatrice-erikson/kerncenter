# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
room = Room.create(name: "bathroom")

prng = Random.new

rlist = [
	['water',
		['hot', 'cold', 'hydrant', 'east', 'west']],
	['electricity',
		['plug', 'lights', 'mechanical']]]

rlist.each do |rname, sublist|
	resource = Type.create(resource: rname)
	sublist.each do |subname|
		subtype = Subtype.create(type_id: resource.id, name: subname)
		for i in 0..2
			sensor = Sensor.create(subtype_id: subtype.id, room_id: room.id)
			for i in 0..10
				Measurement.create(sensor_id: sensor.id, time: DateTime.now, amount: prng.rand(50.00) - 25.00)
			end
		end
	end
end