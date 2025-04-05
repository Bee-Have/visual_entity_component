extends Node2D

@onready var sprites_parent: Node2D = $Poleaxe
@onready var skeleton:= $Skeleton2D
@onready var race_animator: AnimationPlayer = $RaceAnimator
@onready var class_animator: AnimationPlayer = $ClassAnimator
var weapon_node: Sprite2D

func _ready() ->void:
	_connect_sprites_to_skeleton()
	race_animator.root_node = skeleton.get_path()
	class_animator.root_node = skeleton.get_path()
	race_animator.stop()
	class_animator.stop()


func switch_animation(action: String) -> void:
	match action:
		"IDLE":
			if weapon_node != null:
				weapon_node.visible = false
			race_animator.play("IDLE")
			class_animator.stop()
		"WALK":
			race_animator.play("WALK")
		"FIGHT":
			if weapon_node != null:
				weapon_node.visible = true
			race_animator.play("DWARF_FIGHT_IDLE")
			class_animator.play("FIGHTER_FIGHT_IDLE")
		"ATTACK":
			race_animator.play("DWARF_ATTACK")
			class_animator.play("FIGHTER_ATTACK")
		"DAMAGE":
			race_animator.play("DWARF_DAMAGE")
			class_animator.play("FIGHTER_DAMAGE")
	print("RACE ANIM: [", race_animator.current_animation, "]\nCLASS ANIM: [", class_animator.current_animation, ']')


func _connect_sprites_to_skeleton() ->void:
	var _sprite_path: String = str(sprites_parent.get_path()) + "/"
	
	weapon_node = get_node_or_null(_sprite_path + sprites_parent.name)

	for bone_index in range(0, skeleton.get_bone_count()):
		var bone: Bone2D = skeleton.get_bone(bone_index)
		var body_part: Sprite2D = get_node_or_null(_sprite_path + bone.name)

		if body_part != null:
			var remote:= RemoteTransform2D.new()

			bone.add_child(remote)

			remote.scale = body_part.scale
			remote.global_position = body_part.global_position
			remote.global_rotation = body_part.global_rotation
			remote.remote_path = _sprite_path + bone.name

		else:
			continue
