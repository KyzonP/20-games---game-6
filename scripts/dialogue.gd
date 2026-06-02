extends RichTextLabel

var proceedText
var textBox

func _ready():
	EventBus.changeDialogue.connect(changeDialogue)
	
	textBox = get_parent().get_node("TextBox")
	proceedText = get_parent().get_node("ProceedText")
	
func changeDialogue(newText):
	self.visible = true
	textBox.visible = true
	proceedText.visible = true
	text = "[center]" + newText
	
	EventBus.emit_signal("freeze")

func _physics_process(_delta):
	if Input.is_action_just_pressed("dialogue"):
		if self.visible:
			self.visible = false
			textBox.visible = false
			proceedText.visible = false
			EventBus.emit_signal("unfreeze")
		
