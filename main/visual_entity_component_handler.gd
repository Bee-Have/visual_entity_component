extends Node2D

@onready var sprites_parent: Node2D = $Shield
@onready var skeleton:= $Skeleton2D
@onready var animator: AnimationPlayer = $Animator
var weapon_node: Sprite2D

func _ready() ->void:
	animator.root_node = skeleton.get_path()
	animator.play("IDLE")
	animator.stop()
	_connect_sprites_to_skeleton()


func switch_animation(action: String) -> void:
	var entity_class: String = sprites_parent.name.to_upper()
	match action:
		"IDLE":
			if weapon_node != null:
				weapon_node.visible = false
			animator.play("IDLE")
		"WALK":
			if sprites_parent.name == "Staff":
				weapon_node.visible = true
			animator.play(entity_class + "_WALK")
		"FIGHT":
			if weapon_node != null:
				weapon_node.visible = true
			animator.play(entity_class + "_IDLE")
		"ATTACK":
			animator.play(entity_class + "_ATTACK")
		"DAMAGE":
			animator.play(entity_class + "_DAMAGE")
	print("ANIM: [", animator.current_animation, "]\n")


func _connect_sprites_to_skeleton() ->void:
	var _sprite_path: String = str(sprites_parent.get_path()) + "/"
	
	weapon_node = get_node_or_null(_sprite_path + sprites_parent.name)

	for bone_index in range(0, skeleton.get_bone_count()):
		var bone: Bone2D = skeleton.get_bone(bone_index)
		var body_part: Sprite2D = get_node_or_null(_sprite_path + bone.name)

		if body_part != null:
			var remote:= RemoteTransform2D.new()

			bone.add_child(remote)

			remote.scale = body_part.global_scale
			remote.global_position = body_part.global_position
			remote.global_rotation = body_part.global_rotation
			remote.remote_path = _sprite_path + bone.name

		else:
			continue
