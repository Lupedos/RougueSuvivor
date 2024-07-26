extends CanvasLayer

@onready var Timer_label: Label = $Timer
@onready var Dinheiro_label: Label = $Dinheiro


func _process(delta: float):
	
	Timer_label.text = GameManager.Time_elapsed_string
	Dinheiro_label.text = str("Dinheiro: " , GameManager.dinheiro_counter)


