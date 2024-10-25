class_name BehaviorTreeLeaf
extends BehaviorTreeNode

func _ready():
	var children = get_children()
	var behavior_tree_children_count = 0
	
	for child in children:
		if child is BehaviorTreeNode:
			behavior_tree_children_count += 1
	
	assert(behavior_tree_children_count == 0, "A Leaf node cannot have children")
