# Game Root

## How to use
1. create a Root scene in your project
2. add an instance of the GameRoot scene as a child of it
3. set its children as editable
4. attach a new script to the Game node within GameRoot and connect the game_started signal from GameRoot to it, use this script as wanted from now on
5. add the level scene as a child of the SceneContainer node
