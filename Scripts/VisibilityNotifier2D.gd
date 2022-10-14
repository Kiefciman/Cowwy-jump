extends VisibilityNotifier2D

onready var visibility_notifier := $"."

func _ready() -> void:
	visibility_notifier.connect("screen_entered", self, "show")
	visibility_notifier.connect("screen_exited", self, "hide")
	visible = false
