extends Node2D

@export var regeneration_valor: int = 10

 

func _ready():
	$Area2D.body_entered.connect(on_body_entered)
	
func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player: Player = body
		player.cura(regeneration_valor)
		queue_free()
	pass
