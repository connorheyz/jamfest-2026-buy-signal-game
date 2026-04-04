extends Resource
class_name Utils

static func int_to_day(value: int) -> String:
	var residue = value % 7
	match residue:
		0:
			return "Monday"
		1:
			return "Tuesday"
		2:
			return "Wednesday"
		3:
			return "Thursday"
		4:
			return "Friday"
		5:
			return "Saturday"
	return "Sunday"
