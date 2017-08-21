# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
program = Program.create(name: "Admissions")


require_relative 'sensors_master_list'
allOfTheSensors = DefineAllSensors()

listOfPrograms = ['Admissions', 'Financial Aid', 'Kern Kafe', 'Classrooms', 'Common Areas']
listOfPrograms.each do |program|
	programToAdd =  Program.find_or_initialize_by(name: program)
	programToAdd.name = program
	programToAdd.save!
end

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
			i = i
			sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
			for d in 0..50
				for x in 0..2
					x = x
					Measurement.create(sensor_id: sensor.id, date: d.days.ago, amount: prng.rand(50.00))
				end
			end
		end
	end
	subgenlist.each do |subname|
		subtype = Subtype.create(type_id: resource.id, name: subname, usage?: false)
		for i in 0..1
			i = i
			sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
			for d in 0..50
				for x in 0..2
					x = x
					Measurement.create(sensor_id: sensor.id, date: d.days.ago, amount: prng.rand(150.00))
				end
			end
		end
	end
end


# The code above generates records used for tesing purposes.
# The code below places programs and sensors that will probably match
# what will be used in the end.
# Comment and uncomment one section or the other
# according to your needs.
#

# The next three lines erase data from tables, 
# and make sure that new ids will be assigned starting at 1.
# Comment these lines out if you want the code below
# to use the record ids assigned by the code above.
ActiveRecord::Base.connection.execute("TRUNCATE table programs RESTART IDENTITY cascade")
ActiveRecord::Base.connection.execute("TRUNCATE table types RESTART IDENTITY cascade")
ActiveRecord::Base.connection.execute("TRUNCATE table sensors RESTART IDENTITY cascade")


# add programs based on the information 
# from the master list of sensors
allOfTheSensors.each do |thisSensor|
	program = thisSensor.GetProgram()
	programToAdd =  Program.find_or_initialize_by(name: program)
	programToAdd.name = program
	programToAdd.save!
end

# add resource types and subtypes based on the information 
# from the master list of sensors
allOfTheSensors.each do |thisSensor|
	sensorType         = thisSensor.GetType()
	typeToAdd          =  Type.find_or_initialize_by(resource: sensorType) 
	typeToAdd.resource = sensorType
	typeToAdd.save!
	sensorSubtype      = thisSensor.GetSubtype()
	# is this subtype "registered" in the subtypes table
	# under this type?
	# First off, what's the ID of this type?
	idForThisTypeOfSensor = Type.find_by(resource: sensorType).id()
	#puts "we're going to check for subtype %s, which is of type %s, which has id %d" % [sensorSubtype, sensorType, idForThisTypeOfSensor]
	sensorSubtypeToAdd = Subtype.find_or_initialize_by(type_id: idForThisTypeOfSensor, name: sensorSubtype)
	sensorSubtypeToAdd.type_id = idForThisTypeOfSensor
	sensorSubtypeToAdd.name = sensorSubtype
	if thisSensor.GetUse() == true
		sensorSubtypeToAdd[:usage?] = true
	else
		sensorSubtypeToAdd[:usage?] = false
	end
	sensorSubtypeToAdd.save!
end

# Now add sensors based on the information 
# from the master list of sensors.
allOfTheSensors.each do |thisSensor|
	# which program does it belong to?
	sensorProgram = thisSensor.GetProgram()
	# What's the ID for this program?
	sensorProgramID = Program.find_by(name: sensorProgram).id()
	# What's the name of the sensor?
	sensorName    = thisSensor.GetName()
	# what's the sensor code?
	sensorCode    = thisSensor.GetCode()
	# what's the sensor type id?
	# (we'll need this in case the subtype name is not unique)
	sensorType    = thisSensor.GetType()
	# What's the sensor type id?
	sensorTypeID  = Type.find_by(resource: sensorType).id()
	# what's the sensor subtype?
	sensorSubtype = thisSensor.GetSubtype()
	# What's the ID for this subtype?
	sensorSubtypeID = Subtype.find_by(type_id: sensorTypeID, name: sensorSubtype).id()
        sensorToAdd = Sensor.find_or_initialize_by(sensorName: sensorName)
	sensorToAdd.subtype_id = sensorSubtypeID
	sensorToAdd.program_id = sensorProgramID
	sensorToAdd.sensorName = sensorName
	sensorToAdd.sensorCode = sensorCode
	sensorToAdd.save!
end


# Now we look into csv files for data
# so that we can write it into the measurements table.
#
require 'csv'



def PutValueIntoDatabase(arrayWithInformation, positionInTheArray, codeOfSensor, previousReading)
	dateAndTime = arrayWithInformation[0]
	value       = arrayWithInformation[positionInTheArray].to_f()
	if value < 0
		value = 0
	end
	#date = dateAndTime.split(' ')[0]
	#time = dateAndTime.split(' ')[1]
	sensorID = Sensor.find_by(sensorCode: codeOfSensor).id()
	#thisMeasurement = Measurement.find_or_initialize_by(sensor_id: sensorID, date: date, time: time)
	thisMeasurement = Measurement.find_or_initialize_by(sensor_id: sensorID, date: dateAndTime)
	thisMeasurement.amount = value
	thisMeasurement.save!
	previousReading[positionInTheArray] = value
	return()
end


# what are the names of the csv files in the directory?
# the full path needs to be specified below.
listOfCSVFiles = Dir.glob("/home/jaime/Kern/New/2prime/kerncenter-master/db/*.csv")
# create an array that stores previous meter values
# so we can compute interval metrics later on.
# this array will very likely be too big,
# but it certainly won't be too small,
# and this will allow us to use
# the same index values twice.
listOfCSVFiles.each() do |fileName|
	puts "we need to process %s" % fileName
	arrayOfData = CSV.read(fileName)
	previousValues = Array.new(arrayOfData[2].length())
	arrayOfData.each do |lineOfData|
		if lineOfData.length() > 0 # skip blank lines
			if lineOfData[0][0] != 'D' # skip header lines
				#PutValueIntoDatabase(lineOfData, 2, "PV Solar", previousValues)
				PutValueIntoDatabase(lineOfData, 3, "PV Solar", previousValues)
				#PutValueIntoDatabase(lineOfData, 7, "Inverter", previousValues)
				#PutValueIntoDatabase(lineOfData, 8, "Elevator", previousValues)
				#PutValueIntoDatabase(lineOfData, 9, "PB1", previousValues)
				#PutValueIntoDatabase(lineOfData, 10, "P11", previousValues)
				#PutValueIntoDatabase(lineOfData, 11, "P12", previousValues)
				#PutValueIntoDatabase(lineOfData, 12, "P21")
				#PutValueIntoDatabase(lineOfData, 13, "P22")
				#PutValueIntoDatabase(lineOfData, 14, "LB1")
				#PutValueIntoDatabase(lineOfData, 15, "L11")
				#PutValueIntoDatabase(lineOfData, 16, "L21")
				#PutValueIntoDatabase(lineOfData, 17, "L22")
			end
		end
	end
end
