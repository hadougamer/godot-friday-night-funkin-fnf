extends Camera2D

var cam_position = {}

func _ready():
	cam_position["boy"] = Vector2(512,300)
	cam_position["dad"] = Vector2(265,85)
	
	# Points the cam to whos is playing
	global_position=cam_position[Global.playing]

func _process(delta):
	goto(Global.playing, delta)


func goto(who, delta):
	var time = 2 * delta
	var new_position = cam_position[who]
	
	if global_position != new_position:
		global_position=global_position.linear_interpolate(new_position, time)
