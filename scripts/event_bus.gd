extends Node

@warning_ignore("UNUSED_SIGNAL")

# Emitted when the player dies, primarily
signal restart()
@warning_ignore("UNUSED_SIGNAL")

# When player dies, but doesn't restart everything - just the player position
signal smallRestart()
