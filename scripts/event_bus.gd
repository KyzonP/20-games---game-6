extends Node

@warning_ignore("UNUSED_SIGNAL")

# Emitted when the player dies, primarily
signal restart()

@warning_ignore("UNUSED_SIGNAL")
# When player dies, but doesn't restart everything - just the player position
signal smallRestart()

@warning_ignore("UNUSED_SIGNAL")
# When one of the 'characters' is reached
signal progress()

@warning_ignore("UNUSED_SIGNAL")
signal completeGame()

@warning_ignore("UNUSED_SIGNAL")
signal changeDialogue()
