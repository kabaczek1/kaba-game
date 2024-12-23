# Project > ProjectSettings > Input Map > screenshot | gif | reset_gif 
# Project > ProjectSettings > General > Application > Config > Use Custom User Dir
# Project > ProjectSettings > General > Application > Config > Custom User Dir Name

extends Node

var camera
var ssCount = 1
var gif_recording = false
var gifFramerate = 30 #fps
var record_region = Rect2i(0,0,320,320)

func _ready() -> void:
	camera = Camera2D.new()
	add_child(camera)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	dir = DirAccess.open("user://screenshots")
	for i in dir.get_files():
		ssCount += 1

func _input(event) -> void:
	if event.is_action_pressed("screenshot"):
		screenshot()
	if event.is_action_pressed("gif"):
		print("toggle_gif()")
		toggle_gif()
	if event.is_action_pressed("reset_gif"):
		print("clear folder")
		clear_folder()

func screenshot():
	await RenderingServer.frame_post_draw
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.get_region(record_region).save_png("user://screenshots/ss"+str(ssCount)+".png")
	ssCount += 1

func clear_folder():
	var dir = DirAccess.open("user://screenshots")
	for i in dir.get_files():
		dir.remove(i)
	ssCount = 1

func toggle_gif():
	if gif_recording == false:
		gif_recording = true
		record_gif()
	else:
		gif_recording = false

func record_gif():
	if gif_recording:
		print("GIF "+str(ssCount)+" ("+str(1.0/gifFramerate)+")")
		screenshot()
		get_tree().create_timer(1.0/gifFramerate, false).connect("timeout", record_gif)
