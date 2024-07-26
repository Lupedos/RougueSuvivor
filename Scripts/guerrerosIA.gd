extends Node 

@export var speed: float = 1

#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var sprite: AnimatedSprite2D

var enemy: Inimigo

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")
	pass
	
func _physics_process(delta: float) -> void:
	if GameManager.is_game_over: return
	var player_position = GameManager.player_position
	var differnce = player_position - enemy.position
	var input_vector = differnce.normalized()
	
	
	enemy.velocity = input_vector * speed * 100.0
	enemy.move_and_slide()
	
	
	#girar
	if input_vector.x >0:
		sprite.flip_h = false
	elif input_vector.x <0:
		sprite.flip_h = true
