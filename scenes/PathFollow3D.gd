extends PathFollow3D

@export var next_follow_path: NodePath
@export var look_at_path: NodePath
@export var speed = 0.05

@onready var look_at_obj = get_node(look_at_path)
var old_unit_offset = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit(0)
	progress_ratio += delta*speed
	var cam: Camera3D
	if get_child_count() > 0:
		cam = get_child(0)
	if progress_ratio < old_unit_offset and cam and not next_follow_path.is_empty():
		remove_child(cam)
		var next_follow = get_node(next_follow_path)
		next_follow.add_child(cam)
		next_follow.old_unit_offset = 0
		next_follow.progress_ratio = 0
	if look_at_obj and cam:
		cam.look_at(look_at_obj.global_transform.origin)
	old_unit_offset = progress_ratio
