extends KinematicBody2D

var arrow_num = null
var	speed  = 20000
var motion = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	if arrow_num != null:
		motion.y = -(speed * delta)
		motion = move_and_slide(motion)

func set_arrow(num):
	arrow_num = num
	$Sprite.region_rect = Rect2(( arrow_num * 57 ), 57, 57, 57)


func _on_action_button_entered(area):
	if area.is_in_group("ArrowBTN"):
		var sprite = area.get_node("..") 
		if sprite.on==true:
			var factor = 1
			if Global.playing ==  "dad":
				factor = -1
			else:
				factor = 1

			var canvas = sprite.get_node("../../Canvas")
			var LifeBar = canvas.get_node("LifeBar")
			if LifeBar.value > 0:
				var lbRivals = canvas.get_node("lbRivals")
				lbRivals.global_position.x-=(10 * factor)
				LifeBar.value-=(2 * factor)

			self.queue_free()

func _on_action_button_exited(area):
	if area.is_in_group("ArrowBTN"):
		var sprite = area.get_node("..")
		if sprite.on==false:
			var factor = 1
			if Global.playing ==  "dad":
				factor = -1
			else:
				factor = 1
				
			var canvas = sprite.get_node("../../Canvas")
			var LifeBar = canvas.get_node("LifeBar")
			if LifeBar.value < 100:
				var lbRivals = canvas.get_node("lbRivals")
				lbRivals.global_position.x += (10 * factor)
				LifeBar.value +=  (2 * factor)

func _on_Notifier_screen_exited():
	self.queue_free()
