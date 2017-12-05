const SECONDS_PER_DAY = 86400

const MERIDIEM_ANTE = "am"
const MERIDIEM_POST = "pm"

class DateAndTime extends Reference:
	var seconds = 0
	var minutes = 0
	var hours = 0
	var days = 0
	var months = OS.MONTH_JANUARY
	var years = 0
	func serialize_save_binary(p_stream):
		p_stream.store_8(seconds)
		p_stream.store_8(minutes)
		p_stream.store_8(hours)
		p_stream.store_16(days)
		p_stream.store_8(months)
		p_stream.store_32(years)
	
	func serialize_load_binary(p_stream):
		seconds = p_stream.get_8()
		minutes = p_stream.get_8()
		hours = p_stream.get_8()
		days = p_stream.get_16()
		months = p_stream.get_8()
		years = p_stream.get_32()

static func get_month_from_string(p_string):
	var lower_string = p_string.to_lower()
	
	if(lower_string == "january"):
		return OS.MONTH_JANUARY
	elif(lower_string == "february"):
		return OS.MONTH_FEBRUARY
	elif(lower_string == "march"):
		return OS.MONTH_MARCH
	elif(lower_string == "april"):
		return OS.MONTH_APRIL
	elif(lower_string == "may"):
		return OS.MONTH_MAY
	elif(lower_string == "june"):
		return OS.MONTH_JUNE
	elif(lower_string == "july"):
		return OS.MONTH_JULY
	elif(lower_string == "august"):
		return OS.MONTH_AUGUST
	elif(lower_string == "september"):
		return OS.MONTH_SEPTEMBER
	elif(lower_string == "october"):
		return OS.MONTH_OCTOBER
	elif(lower_string == "november"):
		return OS.MONTH_NOVEMBER
	elif(lower_string == "december"):
		return OS.MONTH_DECEMBER
	else:
		return -1
		
static func get_string_from_month(p_month):
	if(p_month == OS.MONTH_JANUARY):
		return "January"
	elif(p_month == OS.MONTH_FEBRUARY):
		return "February"
	elif(p_month == OS.MONTH_MARCH):
		return "March"
	elif(p_month == OS.MONTH_APRIL):
		return "April"
	elif(p_month == OS.MONTH_MAY):
		return "May"
	elif(p_month == OS.MONTH_JUNE):
		return "June"
	elif(p_month == OS.MONTH_JULY):
		return "July"
	elif(p_month == OS.MONTH_AUGUST):
		return "August"
	elif(p_month == OS.MONTH_SEPTEMBER):
		return "September"
	elif(p_month == OS.MONTH_OCTOBER):
		return "October"
	elif(p_month == OS.MONTH_NOVEMBER):
		return "November"
	elif(p_month == OS.MONTH_DECEMBER):
		return "December"
	else:
		return ""
		
static func get_string_from_month_tr(p_month):
	if(p_month == OS.MONTH_JANUARY):
		return "MONTH_JANUARY"
	elif(p_month == OS.MONTH_FEBRUARY):
		return "MONTH_FEBRUARY"
	elif(p_month == OS.MONTH_MARCH):
		return "MONTH_MARCH"
	elif(p_month == OS.MONTH_APRIL):
		return "MONTH_APRIL"
	elif(p_month == OS.MONTH_MAY):
		return "MONTH_MAY"
	elif(p_month == OS.MONTH_JUNE):
		return "MONTH_JUNE"
	elif(p_month == OS.MONTH_JULY):
		return "MONTH_JULY"
	elif(p_month == OS.MONTH_AUGUST):
		return "MONTH_AUGUST"
	elif(p_month == OS.MONTH_SEPTEMBER):
		return "MONTH_SEPTEMBER"
	elif(p_month == OS.MONTH_OCTOBER):
		return "MONTH_OCTOBER"
	elif(p_month == OS.MONTH_NOVEMBER):
		return "MONTH_NOVEMBER"
	elif(p_month == OS.MONTH_DECEMBER):
		return "MONTH_DECEMBER"
	else:
		return ""
		
static func get_string_from_weekday(p_day):
	if(p_day == OS.DAY_SUNDAY):
		return "Sunday"
	elif(p_day == OS.DAY_MONDAY):
		return "Monday"
	elif(p_day == OS.DAY_TUESDAY):
		return "Tuesday"
	elif(p_day == OS.DAY_WEDNESDAY):
		return "Wednesday"
	elif(p_day == OS.DAY_THURSDAY):
		return "Thursday"
	elif(p_day == OS.DAY_FRIDAY):
		return "Friday"
	elif(p_day == OS.DAY_SATURDAY):
		return "Saturday"
	else:
		return ""
		
static func get_string_from_weekday_tr(p_day):
	if(p_day == OS.DAY_SUNDAY):
		return "DAY_SUNDAY"
	elif(p_day == OS.DAY_MONDAY):
		return "DAY_MONDAY"
	elif(p_day == OS.DAY_TUESDAY):
		return "DAY_TUESDAY"
	elif(p_day == OS.DAY_WEDNESDAY):
		return "DAY_WEDNESDAY"
	elif(p_day == OS.DAY_THURSDAY):
		return "DAY_THURSDAY"
	elif(p_day == OS.DAY_FRIDAY):
		return "DAY_FRIDAY"
	elif(p_day == OS.DAY_SATURDAY):
		return "DAY_SATURDAY"
	else:
		return ""

static func get_is_leap_year(p_year):
	var is_leap_year
	
	if ((p_year % 4) || ((p_year % 100 == 0) && (p_year % 400))):
		is_leap_year = false
	else:
		is_leap_year = true
		
	return is_leap_year

static func get_number_of_days_for_current_month(p_month, p_year):
	var days_in_month;
	
	if (p_month == OS.MONTH_FEBRUARY):
		if(get_is_leap_year(p_year)):
			days_in_month = 29
		else:
			days_in_month = 28
	else:
		days_in_month = 31 - (p_month - 1) % 7 % 2
	
	return days_in_month
	
static func get_month_and_day_for_current_day_of_the_year(p_day, p_year):
	var day_incrementation = 0
	var days_in_month = 0
	var month_and_day = {}
	
	for current_month in range(OS.MONTH_JANUARY, OS.MONTH_DECEMBER+1):
		days_in_month = get_number_of_days_for_current_month(current_month, p_year)
			
		if(p_day > day_incrementation and p_day <= day_incrementation + days_in_month):
			month_and_day["day"] = p_day - day_incrementation
			month_and_day["month"] = current_month
			break
			
		day_incrementation += days_in_month
			
	return month_and_day
	
static func get_number_of_days_for_current_year(p_year):
	if(get_is_leap_year(p_year)):
		return 366
	else:
		return 365
	
static func determine_day_of_the_week(p_day, p_month, p_year):
	var offset = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
	var week = [OS.DAY_SUNDAY, OS.DAY_MONDAY, OS.DAY_TUESDAY, OS.DAY_WEDNESDAY, OS.DAY_THURSDAY, OS.DAY_FRIDAY, OS.DAY_SATURDAY]
	
	var after_feburary = 1
	
	if(p_month > 2):
		after_feburary = 0
		
	var aux = int(p_year) - 1700 - after_feburary
	
	var days_of_week = 5
	days_of_week += (aux + after_feburary) * 365                  
	days_of_week += aux / 4 - aux / 100 + (aux + 100) / 400     
	days_of_week += offset[int(p_month) - 1] + (int(p_day) - 1)               
	days_of_week = days_of_week % 7
	
	return week[days_of_week]
	
static func determine_day_of_the_year(p_day, p_month, p_year):
	var n1 = floor(275 * p_month / 9)
	var n2 = floor((p_month + 9) / 12)
	var n3 = (1 + floor ( (p_year - 4 * floor (p_year / 4) + 2) / 3) )
	return n1 - (n2 * n3) + p_day - 30