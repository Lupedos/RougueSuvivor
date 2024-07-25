class_name Inimigo
extends Node2D

@export var vida: int = 10 
@export var morte_prefab: PackedScene

func damage(amount: int) -> void:
	vida -= amount
	print("vida inimigo: " , vida )
	
	modulate = Color.RED
	var  tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	
	
	if vida <=0:
		die()
func die() -> void:
		if morte_prefab:
			var morte_objeto = morte_prefab.instantiate()
			morte_objeto.position = position
			get_parent().add_child(morte_objeto)
			
		queue_free()
