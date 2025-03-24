extends Node2D

@onready var switch := $Switch
@onready var label := $Label
## "rect" will become the entity component
@onready var rect := $TmpEntity

func _ready() :
	switch.pressed.connect(switch_action)


func switch_action() -> void:
	if label.text == "IDLE" :
		_walk()
	elif label.text == "WALK":
		_attack()
	else:
		_idle()


func _idle() -> void:
	label.text = "IDLE"
	rect.color = Color.DIM_GRAY


func _walk() -> void:
	label.text = "WALK"
	rect.color = Color.PALE_GREEN


func _attack() -> void:
	label.text = "ATTACK"
	rect.color = Color.DARK_RED
