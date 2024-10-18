class_name BehaviorTreeComposite
extends BehaviorTreeNode

@onready var children: Array = get_children() as Array

func _ready():
	assert(get_child_count() > 1,
		"A Composite node must have more than one child.")
