extends Camera2D

var isCameraSway:bool;
var centerScreen;

func _ready() -> void:
	signal_manager.focus_on_me.connect(_zoom_into_character);
	centerScreen = self.position

func _zoom_into_character(xPos:int,yPos:int,offsetX:int):
	self.position = Vector2(xPos-offsetX,yPos)
	_killCam()
	var cameraZoom = create_tween().tween_property(self,"zoom",Vector2(2.0,2.0),0.5).set_ease(Tween.EASE_IN)
	signal_manager.emit_signal("hide_me")
	await cameraZoom.finished

func _reset_camera()->void:
	var cameraZoom = create_tween()
	cameraZoom.tween_property(self,"zoom",Vector2(1.0,1.0),2).set_ease(Tween.EASE_OUT)
	self.position = centerScreen;
	self.reparent($"..")
	await cameraZoom.finished

func _focus_on_battler(entity:BattleEntity)->void:
	self.reparent(entity)
	var cameraZoom = create_tween()
	cameraZoom.tween_property(self,"zoom",Vector2(1.5,1.5),2).set_ease(Tween.EASE_OUT)
	cameraZoom.tween_property(self,"position",Vector2(0,0),1).set_ease(Tween.EASE_OUT)
	await cameraZoom.finished

func _startLoopingCamera(left:int,right:int,subject)->void:
		var tween =create_tween();
		tween.set_loops()
		tween.tween_property($Battlers/BattleCam,"position",Vector2(subject.x+right,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_IN)
		tween.tween_property($Battlers/BattleCam,"position",Vector2(subject.x-left,subject.y),randi_range(2, 5)).set_ease(Tween.EASE_OUT)

func _killCam()->void:
	var tween =create_tween();
	tween.kill()
