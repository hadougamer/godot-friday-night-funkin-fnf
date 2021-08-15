extends Node2D

# Preload Action Arrow
var pre_arrow = preload("res://Scenes/ActionArrow.tscn")
var rng = RandomNumberGenerator.new()

# Arrow buttons
var arrow_btns = {}

func _ready():
	# Sets the arrow buttons
	arrow_btns["left"]    = $Canvas.get_node("ArrowLeft")
	arrow_btns["right"]   = $Canvas.get_node("ArrowRight")
	arrow_btns["top"]     = $Canvas.get_node("ArrowTop")
	arrow_btns["bottom"]  = $Canvas.get_node("ArrowBottom")

	# Starts a timer with the turn time
	$Timer.set_wait_time( Global.turn_time )
	$Timer.one_shot=true
	$Timer.start()
	
	Global.setLevel(self)

	_load_random_player_arrow()

	$AudioPlayer.stream=Global.song[ Global.playing ]
	$AudioPlayer.play()

func _load_random_player_arrow():
	rng.randomize()
	var arrow_num = rng.randi_range(0, 3)
	var action_arrow = pre_arrow.instance()
	var arrow_pos = $Canvas.get_node("ActionArrowsPositions").get_child(arrow_num).global_position
	
	action_arrow.global_position= arrow_pos
	action_arrow.set_arrow(arrow_num)
	
	$Canvas.add_child(action_arrow)

func _process(delta):
	rng.randomize()
	if rng.randf_range(0, 100) > 96.1:
		_load_random_player_arrow()

	if Global.playing == "boy":	
		if Input.is_action_pressed("ui_left"):
			arrow_btns["left"].on=true
			arrow_btns["left"].play("On")
		else:
			arrow_btns["left"].on=false
			arrow_btns["left"].play("Off")

		if Input.is_action_pressed("ui_right"):
			arrow_btns["right"].on=true
			arrow_btns["right"].play("On")
		else:
			arrow_btns["right"].on=false
			arrow_btns["right"].play("Off")

		if Input.is_action_pressed("ui_up"):
			arrow_btns["top"].on=true
			arrow_btns["top"].play("On")
		else:
			arrow_btns["top"].on=false
			arrow_btns["top"].play("Off")

		if Input.is_action_pressed("ui_down"):
			arrow_btns["bottom"].on=true
			arrow_btns["bottom"].play("On")
		else:
			arrow_btns["bottom"].on=false
			arrow_btns["bottom"].play("Off")
	elif Global.playing == "dad":
		# IA for Dad pressing buttons
		var actions = ["left", "right", "top", "bottom"]
		var pressed = rng.randi_range(0, 3)
		
		# Turn all the btns off
		for i in range(0, ( actions.size() ) ):
			if rng.randi_range(0, 100) > 90:
				arrow_btns[actions[i]].on=false
				arrow_btns[actions[i]].play("Off")

		# Turn the random btn on
		arrow_btns[actions[pressed]].on=true
		arrow_btns[actions[pressed]].play("On")

func _on_Timer_timeout():
	print('Player is')
	print(Global.playing);

	# Switch between 2 players
	if Global.playing == "boy":
		Global.playing =  "dad"
	elif Global.playing == "dad":
		Global.playing =  "boy"

	# Change the singer
	# Load current position
	var music_pos = $AudioPlayer.get_playback_position()
	$AudioPlayer.stop()
	$AudioPlayer.stream=Global.song[ Global.playing ]
	
	# Play from poition
	$AudioPlayer.play(music_pos)

	$Timer.start()
