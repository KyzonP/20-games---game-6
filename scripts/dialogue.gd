extends RichTextLabel

func _ready():
	EventBus.changeDialogue.connect(changeDialogue)
	
func changeDialogue(newText):
	self.visible = true
	text = "[center]" + newText

func _physics_process(delta):
	if Input.is_action_just_pressed("dialogue"):
		self.visible = false
