class_name Player 
extends CharacterBody2D

@export_category("Movemento")
@export var speed: float = 3

@export_category("Espada")
@export var DanoEspada: int = 2

@export_category("Magia")
@export var magia_damage: int = 2
@export var magia_interval: float = 15
@export var magia_scene: PackedScene

@export_category("Vida")
@export var maxVida: int = 100
@export var vida: int = maxVida 
@export var morte_prefab: PackedScene

@onready var sprite: Sprite2D = $PlayerSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Sword_area: Area2D = $EspadaColisao
@onready var HitBox_area: Area2D = $Hitbox

var input_vector: Vector2 = Vector2(0, 0)
var is_running: bool = false
var was_running: bool = false
var is_atacking: bool = false
var atack_cooldown: float = 0.0
var hitBox_cooldown: float = 0.0
var magic_cooldown: float = 0.0

func _process(delta: float) -> void:
	GameManager.player_position = position
	#Ler input
	read_Input()
	update_atack(delta)
	
	play_run_animation()
	rotate_sprite()
	
	if Input.is_action_just_pressed("atack"):
		atack()

func _physics_process(delta: float) -> void:
	# modificar velocidade
	var target_velocity = input_vector * speed * 100.0
	if is_atacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.05)
	if not is_running:
		velocity *= 0.0
	move_and_slide()
	update_Hitbox(delta)
	update_magic(delta)
	
	
func play_run_animation() -> void:
	# Animacao
	if not is_atacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("run")
			else:
				animation_player.play("idle")
	pass
	
func rotate_sprite() -> void:
	#girar
	if not is_atacking:
		if input_vector.x >0:
			sprite.flip_h = false
		elif input_vector.x <0:
			sprite.flip_h = true 
		
func atack() -> void:
	if is_atacking:
		return
	animation_player.play("atack_side1")
	#animation_player.play("atack_side2")
	atack_cooldown = 0.6
	is_atacking = true 
	
	
	pass
func aplicarDano() -> void:
	var bodies = Sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Inimigos"):
			var enemy: Inimigo = body
			
			var direction_to_enemy = (enemy.position - position).normalized()
			var atack_direction: Vector2
			if sprite.flip_h:
				atack_direction = Vector2.LEFT
			else:
				atack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(atack_direction)
			if dot_product >= 0.3:
				enemy.damage(DanoEspada)
		
func update_Hitbox(delta: float) -> void:
	hitBox_cooldown -= delta
	if hitBox_cooldown > 0 :	return
	
	hitBox_cooldown = 0.5
	
	var bodies = HitBox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Inimigos"):
			var enemy: Inimigo = body
			var dano_inimigo = 1
			damage(dano_inimigo)
	pass
	
func read_Input() -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	#Tirar deadzone
	var deadzone = 0.15
	if abs(input_vector.x) < 0.15:
		input_vector.x = 0.0
	if abs(input_vector.y) < 0.15:
		input_vector.y = 0.0
		
	was_running = is_running
	is_running = not input_vector.is_zero_approx()
	pass
	
func update_atack(delta: float) -> void:
	if is_atacking:
		atack_cooldown -= delta
		if atack_cooldown <= 0.0:
			is_atacking = false
			is_running = false
			animation_player.play("idle")

func update_magic(delta: float) -> void:
	magic_cooldown -= delta
	if magic_cooldown >0: return
	magic_cooldown = magia_interval
	
	var magia = magia_scene.instantiate()
	magia.damage = magia_damage
	add_child(magia)
	
	pass

func damage(amount: int) -> void:
	if vida <= 0: return
	vida -= amount
	print("vida Jogador: " , vida, "levou isso de dano: ", amount )
	
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

func cura(amount: int) -> int:
	vida += amount
	if vida > maxVida:
		vida = maxVida
	print(vida)
	return vida
	
	
