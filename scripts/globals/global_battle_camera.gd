extends Camera2D

signal focus_on_me(focus,x,y)

var isCameraSway:bool;
var centerScreen;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gl_camera.focus_on_me.connect(_zoom_into_character)
	print(self.position)
	centerScreen = Vector2(960.0, 548.0)
	self.position=centerScreen
	pass # Replace with function body.

# TODO: Make this in the camera node where it can be a function that sets it.
		
func _zoom_into_character(focus,xPos:int,yPos:int,offsetX:int):
	self.position = Vector2(xPos+offsetX,yPos)
	print("Zoomed" + str(self.position))
	_killCam()
	# var cameraZoom = create_tween().tween_property(self,"zoom",Vector2(2.0,2.0),0.5)
	_startLoopingCamera(10,10,self.position)
	print("Bah...")
	print(centerScreen.x)

func _startLoopingCamera(left:int,right:int,subject)->void:
		var tween = create_tween();
		tween.set_loops()
		tween.tween_property(self,"position",Vector2(subject.x+right,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_IN)
		tween.tween_property(self,"position",Vector2(subject.x-left,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_OUT)

func _killCam()->void:
	var tween = create_tween();
	tween.kill()
