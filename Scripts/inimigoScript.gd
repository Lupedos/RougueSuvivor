class_name Inimigo
extends Node2D

@export var vida: int = 10 
@export var morte_prefab: PackedScene
var dano_texto_prefab: PackedScene
@onready var danoTexto_Local = $Marker2D
func _ready():
	dano_texto_prefab = preload("res://UI_Scene/dano_texto.tscn")

func damage(amount: int) -> void:
	vida -= amount
	print("vida inimigo: " , vida )
	
	modulate = Color.RED
	var  tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	
	var danoTexto = dano_texto_prefab.instantiate()
	danoTexto.value = amount
	if danoTexto_Local:
		danoTexto.global_position = danoTexto_Local.global_position
	else:
		danoTexto.global_position = global_position
	get_parent().add_child(danoTexto)
	
	if vida <=0:
		die()
func die() -> void:
		if morte_prefab:
			var morte_objeto = morte_prefab.instantiate()
			morte_objeto.position = position
			get_parent().add_child(morte_objeto)
			
		queue_free()
