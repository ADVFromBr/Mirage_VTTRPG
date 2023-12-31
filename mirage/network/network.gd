extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENT = 2


var server = null
var client = null

var ip_adress = ""

func _ready() -> void:

	if OS.get_name() == "Windows":
			ip_adress = IP.get_local_addresses()[3]


	elif  OS.get_name() == "Android":
			ip_adress = IP.get_local_addresses()[0]


	else:
			ip_adress = IP.get_local_addresses()[3]
			
			for ip in IP.get_local_addresses():
					if ip.begins_with("192.168."):
							ip_adress = ip
							
	get_tree().connect("connected_to_server",self,"_connected_to_server",[])
	get_tree().connect("server_disconnected",self,"_server_disconnected",[])
	
	
func _connected_to_server() -> void:
		print("sucessufully connected to server")
		

func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_client(DEFAULT_PORT,MAX_CLIENT)
	get_tree().set_network_peer(server)
		
		
	


func _server_disconnected() -> void:
		print("disconnected to server")
