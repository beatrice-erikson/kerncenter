# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
program = Program.create(name: "Admissions")

prng = Random.new

rlist = [
	['water',
		['hot', 'cold', 'hydrant'],
		['collection']],
	['electricity',
		['plug', 'lights', 'mechanical'],
		['solar']]]

rlist.each do |rname, subuselist, subgenlist|
	resource = Type.create(resource: rname)
	subuselist.each do |subname|
		subtype = Subtype.create(type_id: resource.id, name: subname, usage?: true)
		for i in 0..1
			sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
			for h in 0..200
				for x in 0..2
					Measurement.create(sensor_id: sensor.id, time: (h*5).hours.ago, amount: prng.rand(50.00))
				end
			end
		end
	end
	subgenlist.each do |subname|
		subtype = Subtype.create(type_id: resource.id, name: subname, usage?: false)
		for i in 0..1
			sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
			for h in 0..200
				for x in 0..2
					Measurement.create(sensor_id: sensor.id, time: (h*5).hours.ago, amount: prng.rand(150.00))
				end
			end
		end
	end
end