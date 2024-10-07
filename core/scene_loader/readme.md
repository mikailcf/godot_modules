1. Place the main SceneLoader node at the same level as your level node (the one that'll be swapped for a new scene)
2. Set its NodePathToReplace propoerty in the interface, choosing the level node
3. Place a SceneLoaderNode anywhere down the tree (it must be in the same tree as the main SceneLoader node)
4. Set its NewScenePath property in the interface with the scene that it should load and replace the node
5. Call the `change_scene` function on that node to change the scene
