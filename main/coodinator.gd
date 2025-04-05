extends Node2D

@onready var switch: Button = $Switch
@onready var label: Label = $Label
## "rect" will become the entity component
@onready var rect: ColorRect = $TmpEntity
@onready var entity: Node2D = $Handler
var index: int = 0

func _ready() -> void:
	switch.pressed.connect(switch_action)
	switch_action()


func switch_action() -> void:
	var text: String
	var color: Color

	match index:
		0:
			text = "IDLE"
			color = Color.DIM_GRAY
		1:
			text = "WALK"
			color = Color.PALE_GREEN
		2:
			text = "FIGHT"
			color = Color.PALE_VIOLET_RED
		3:
			text = "ATTACK"
			color = Color.DARK_GOLDENROD
		4:
			text = "DAMAGE"
			color = Color.RED
	entity.switch_animation(text)
	_update(text, color)
	
	index += 1
	if index > 4:
		index = 0


func _update(text: String, color: Color) -> void:
	label.text = text
	rect.color = color
