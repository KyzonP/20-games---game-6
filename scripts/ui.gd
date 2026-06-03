extends CanvasLayer

func _ready():
	if Global.showTimer:
		$Timer.visible = true
	else:
		#$Timer.visible = false
		pass
		
	if Global.showDeaths:
		$Deaths.visible = true
	else:
		$Deaths.visible = false

func _physics_process(_delta):
	$Timer.text = "%.2f" % get_parent().timer
	$Deaths.text = str(get_parent().deaths) + " deaths"
