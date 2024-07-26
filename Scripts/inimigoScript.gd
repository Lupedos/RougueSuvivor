class_name Inimigo
extends Node2D

@export var vida: int = 10 
@export var morte_prefab: PackedScene
var dano_texto_prefab: PackedScene
@onready var danoTexto_Local = $Marker2D

@export var drop_chance: float = 0.1
@export var drop_itens: Array[PackedScene]
@export var drop_chances: Array[float]

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

		if randf() <= drop_chance:
			drop_item()
		GameManager.monster_counter += 1
		
		queue_free()
		

func drop_item() ->void:
	var drop = get_item().instantiate()
	drop.position = position
	get_parent().add_child(drop)
	

func get_item() ->PackedScene:
	if drop_itens.size() ==1:
		return drop_itens[0]
	
	var max_chance: float = 0.0
	for drop_chance in drop_chances:
		max_chance += drop_chance
		
	var random_value = randf() * max_chance
	
	
	var needle: float = 0.0
	for i in drop_itens.size():
		var drop_item = drop_itens[i]
		var drop_chance = drop_chances[i] if i< drop_chances.size() else 1
		if random_value <= drop_chance + needle:
			return drop_item
		needle += drop_chance
		
	return drop_itens[0]
	
	
