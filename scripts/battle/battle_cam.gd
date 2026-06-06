extends Camera2D

var isCameraSway:bool;
var centerScreen;
var sway: Tween;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centerScreen = self.position
	pass # Replace with function body.

# TODO: Make this in the camera node where it can be a function that sets it.
		
func _zoom_into_character(focus,xPos:int,yPos:int,offsetX:int):
	self.position = Vector2(xPos+offsetX,yPos)
	_killCam()
	var cameraZoom = create_tween().tween_property(self,"zoom",Vector2(2.0,2.0),0.5).set_ease(Tween.EASE_IN)
	_startLoopingCamera(10,10,self.position)
	print("Bah...")
	print(centerScreen.x)

func _startLoopingCamera(left:int,right:int,subject)->void:
		sway = create_tween()
		sway.set_loops()
		sway.tween_property($Battlers/BattleCam,"position",Vector2(subject.x+right,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_IN)
		sway.tween_property($Battlers/BattleCam,"position",Vector2(subject.x-left,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_OUT)

func _killCam()->void:
	sway.kill()
