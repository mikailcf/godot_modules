class_name BehaviorTreeLeaf
extends BehaviorTreeNode

func _ready():
	assert(get_child_count() == 0,
		"A Leaf node cannot have children")