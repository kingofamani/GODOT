#開二個視窗：除錯/運行多個實例
extends Node2D

var peer = ENetMultiplayerPeer.new()

@export var player_scene:PackedScene

func _on_host_pressed():
	#cmd輸入netstat -aon，找狀態LISENTING的port
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	
func _add_player(id=1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)#新增player到scene

func _on_join_pressed():
	peer.create_client("localhost",135)
	
	
