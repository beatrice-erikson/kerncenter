def createTestData()
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
				sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
				for d in 0..50
					for x in 0..2
						Measurement.create(sensor_id: sensor.id, date: d.days.ago, amount: prng.rand(50.00))
					end
				end
			end
		end
		subgenlist.each do |subname|
			subtype = Subtype.create(type_id: resource.id, name: subname, usage?: false)
			for i in 0..1
				sensor = Sensor.create(subtype_id: subtype.id, program_id: program.id)
				for d in 0..50
					for x in 0..2
						Measurement.create(sensor_id: sensor.id, date: d.days.ago, amount: prng.rand(150.00))
					end
				end
			end
		end
	end
end

require_relative 'sensors_master_list'
def PutValueIntoDatabase(value, dateAndTime, codeOfSensor)
	value = value.to_f()
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
	return()
end
require 'csv'
def processCSVFiles()
	# what are the names of the csv files in the directory?
	# the full path needs to be specified below.
	listOfCSVFiles = Dir.glob(Rails.root.join("db","*.csv"))
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
					dateTime = lineOfData[0]
					#PutValueIntoDatabase(lineOfData[2], dateTime, "PV Solar")
					PutValueIntoDatabase(lineOfData[3], dateTime, "PV Solar")
					#PutValueIntoDatabase(lineOfData[7], dateTime, "Inverter")
					#PutValueIntoDatabase(lineOfData[8], dateTime, "Elevator")
					#PutValueIntoDatabase(lineOfData[9], dateTime, "PB1")
					#PutValueIntoDatabase(lineOfData[10], dateTime, "P11")
					#PutValueIntoDatabase(lineOfData[11], dateTime, "P12")
					#PutValueIntoDatabase(lineOfData[12], dateTime, "P21")
					#PutValueIntoDatabase(lineOfData[13], dateTime, "P22")
					#PutValueIntoDatabase(lineOfData[14], dateTime, "LB1")
					#PutValueIntoDatabase(lineOfData[15], dateTime, "L11")
					#PutValueIntoDatabase(lineOfData[16], dateTime, "L21")
					#PutValueIntoDatabase(lineOfData[17], dateTime, "L22")
				end
			end
		end
	end
end

def createRealData()
	allOfTheSensors = DefineAllSensors()
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

	processCSVFiles()
end

#createTestData()
createRealData()