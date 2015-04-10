
extends Node2D

var level_scene
var current_pack
var current_level
var player
var level_node
var boxes_left = 0

func load_level(var pack, var level):
	current_level = level
	current_pack = pack
	boxes_left = 0
	level_scene = load(str("res://levels/", pack, "/level_", level, ".xml"))
	for i in range(get_child_count()):
		get_child(i).queue_free()
	level_node = level_scene.instance()
	add_child(level_node)
	player.set_pos(level_node.get_node("start").get_pos() + Vector2(32,32))
	player.level_load(level_node)

func retry_level():
	load_level(current_pack, current_level)

func box_fell():
	boxes_left = boxes_left - 1
	print(boxes_left)
	if(boxes_left == 0):
		load_level(current_pack, int(current_level) + 1)
	
func box_add():
	boxes_left = boxes_left + 1

func _input(event):
	if(event.is_action("retry") && event.is_pressed() && !event.is_echo()):
		retry_level()

func _ready():
	player = get_node("../player_holder/player")
	set_process_input(true)

