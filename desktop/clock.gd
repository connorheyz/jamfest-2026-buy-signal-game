extends Label
class_name StockClock

func update_time_label(time: int):
	var hour = ((time+1) / 2) + 9
	var minute = int(time % 2 == 0) * 30
	text = str(hour) + ":" + (str(minute) if minute > 0 else "00")
