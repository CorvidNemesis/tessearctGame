class_name quotesResource
#TODO: PascalCase
extends Resource

@export var livingQuotes: Array[String]=[]
@export var dyingQuotes: Array[String]=[]

var lastLiving:int;
var lastDying:int;

func _showLivingQuotes()->String:
	if (livingQuotes.size() >0):
		var speak = randi_range(0,livingQuotes.size()-1)
		lastLiving = speak
		return livingQuotes[speak];
	return "..."
