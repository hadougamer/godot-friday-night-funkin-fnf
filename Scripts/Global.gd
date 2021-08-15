extends Node

# Songs
var song = {}

# Time turn for the current player
var turn_time = 10 

# Who is current player
var playing   = "boy"

# Camera Object
var pre_cam   = preload("res://Scenes/Camera.tscn")

# Camera and Level
var camera    = null
var level     = null

func _ready():
	# Preload musicas
	song["boy"] = preload("res://Music/fnf-bopeebo-music.ogg")
	song["dad"] = preload("res://Music/fnf-bopeebo-music-dad.ogg")

	# Configures Camera
	camera=pre_cam.instance()
	camera.current=true

func setLevel(lvl):
	level=lvl
	level.add_child(camera)
