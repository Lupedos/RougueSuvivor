extends Node2D

@export  var monsters: Array[PackedScene]
@export var mob_por_minuto: float = 60.0

@onready var path_follow_2d: PathFollow2D = $Path2D/follow
var cooldown: float = 0.0

func _process(delta: float):
	cooldown -= delta
	if cooldown> 0: return
	
	
	var interval = 60.0 /mob_por_minuto
	cooldown = interval
	
	var index = randi_range(0, monsters.size()-1)
	var monster_scene = monsters[index]
	var monster = monster_scene.instantiate()
	monster.global_position = get_point()
	get_parent().add_child(monster)
	pass

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.position

