class_name BehaviorTreeLeafWrap
extends BehaviorTreeNode

onready var _child = get_child(0) as BehaviorTreeNode

func _ready():
	assert(get_child_count() == 1,
		"A Leaf wrap node should have one child")