class_name BehaviorTreeDecorator
extends BehaviorTreeNode

onready var _child = get_child(0) as BehaviorTreeNode

func _ready():
	assert(get_child_count() == 1,
		"A Decorator node should have one child")
