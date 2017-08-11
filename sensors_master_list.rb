class SensorInformation
	def initialize (name, code, program, type, subtype, userOrGenerator)
		@sensorName = name
		@sensorCode = code
		@sensorProgram = program
		@sensorType = type
		@sensorSubtype = subtype
		if userOrGenerator == "user"
			@use = true
		else
			@use = false
		end
	end

	def Display()
		puts @sensorName, @sensorCode, @sensorProgram, @sensorType, @sensorSubtype
	end

	def to_s
		"Sensor: %33s ; Code: %19s ; program: %13s ; Type: %11s ; Subtype: %10s" % [@sensorName, @sensorCode, @sensorProgram, @sensorType, @sensorSubtype]
	end

	def GetProgram()
		return(@sensorProgram)
	end

	def GetType()
		return(@sensorType)
	end

	def GetSubtype()
		return(@sensorSubtype)
	end

	def GetName()
		return(@sensorName)
	end

	def GetCode()
		return(@sensorCode)
	end

	def GetUse()
		return(@use)
	end

		
end


def DefineAllSensors()
	arrayOfSensors = []
	arrayOfSensors << SensorInformation.new("Fans", "Fans", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Interior heat pumps", "interior heat pumps", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Exterior heat pumps", "Exterior heat pumps", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Water pumps", "Water pumps", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Water heaters", "Water heaters", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Elevator", "Elevator", "Common Areas", "electricity", "mechanical", "user")
	arrayOfSensors << SensorInformation.new("Financial Aid Plugs", "P22", "Financial Aid", "electricity", "plug", "user")
	arrayOfSensors << SensorInformation.new("Admissions Plugs", "P21", "Admissions", "electricity", "plug", "user")
	arrayOfSensors << SensorInformation.new("Kern Kafe Plugs", "P12", "Kern Kafe", "electricity", "plug", "user")
	arrayOfSensors << SensorInformation.new("Classrooms Plugs", "P11", "Classrooms", "electricity", "plug", "user")
	arrayOfSensors << SensorInformation.new("Common Areas Plugs", "PB1", "Common Areas", "electricity", "plug", "user")
	arrayOfSensors << SensorInformation.new("Financial Aid Lights", "L22", "Financial Aid", "electricity", "lights", "user")
	arrayOfSensors << SensorInformation.new("Admissions Lights", "L21", "Admissions", "electricity", "lights", "user")
	arrayOfSensors << SensorInformation.new("Classrooms Lights", "L11", "Classrooms", "electricity", "lights", "user")
	arrayOfSensors << SensorInformation.new("Common Areas lights", "LB1", "Common Areas", "electricity", "lights", "user")
	arrayOfSensors << SensorInformation.new("Inverter", "Inverter", "Common Areas", "electricity", "lights", "user")
	arrayOfSensors << SensorInformation.new("Solar Generator", "PV Solar", "Common Areas", "electricity", "solar", "generator")
	arrayOfSensors << SensorInformation.new("Water Out of Cistern 1", "FM1", "Common Areas", "water", "collection", "generator")
	arrayOfSensors << SensorInformation.new("Water Out of Cistern 2", "FM2", "Common Areas", "water", "collection", "generator")
	arrayOfSensors << SensorInformation.new("Municipal Water", "FM3", "Common Areas", "water", "collection", "generator")
	arrayOfSensors << SensorInformation.new("Treated Water", "FM4", "Common Areas", "water", "collection", "generator")
	arrayOfSensors << SensorInformation.new("Hot Water", "FM5", "Common Areas", "water", "hot", "user")
	arrayOfSensors << SensorInformation.new("Cold Water", "FM6", "Common Areas", "water", "cold", "user")
	arrayOfSensors << SensorInformation.new("Irrigation", "FM7", "Common Areas", "water", "hydrant", "user")
	arrayOfSensors << SensorInformation.new("Gray Water to Planters", "FM8", "Common Areas", "gray water", "use", "user")
	arrayOfSensors << SensorInformation.new("Gray Water to Constructed Wetland", "FM9", "Common Areas", "gray water", "use", "user")
	arrayOfSensors << SensorInformation.new("just testing", "JD1", "Common Areas", "gray mater", "use", "user")

	puts "Right now we have %d sensors." % arrayOfSensors.length()
	#puts arrayOfSensors
	return(arrayOfSensors)
end

#DefineAllSensors()

