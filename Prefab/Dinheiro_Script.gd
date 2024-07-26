extends Node2D

@export var dinheiro_valor: int = 5

func _ready():
	$Area2D.body_entered.connect(on_body_entered)
	
func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player: Player = body
		player.dinheiro_coletado.emit(dinheiro_valor)
	queue_free()
	pass
