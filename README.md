# Second Quarter Template

### Gameplay Features to Be Graded (Max 8)
* Movement and Collision
* Enemies and Traps
* Tilemaps and Worldbuilding
* Combat
* Inventory
* GUI

### Examples/Locations of Implemented Features for Grading
* Inheritance - This project uses inheritance in the enemies, which can be found in the baseEnemy.gd file. It also uses inheritance in the inventory, inside the inventoryItem.gd file. The traps also use inhertance.(trapBase.gd) The golem enemy overides it's parent on_range_body_entered function in order to allow it to attack other enemies. All the eniemies use all the other logic found in their parent, exepct for attacking, taking damage, and dying. These were abstacted. The inventory items all use the logic from their parent class. The traps share the player detection logic.
* Encapsulation - Logic of classes was grouped togehter into variables, onreadys, and preloads. No private varibels or functions are used.
* Polymorphism - Polymorphism is used in both the enemies, which can be found in the baseEnemy.gd file, and inventory, inside the inventory.gd file. The enemies all have function argument using an object type that is implemented by several classes, whenever they die or take damage. The golem enemy is a class golem, and a class enemy. This can be seen in the golem.gd file. The slash attack (found in slash.gd) and the bubble attack(found in bubble.gd) both use the "is" keyword to make sure that they only apply damage to the correct targets. The traps also use the "is" keyword in order to make sure they only activate on the player.(trapBase.gd)
* Abstraction - As mentioned breifely in inheritance, the enemies have the abstract funcitons of attacking, taking damage, and dying. This is because each enemy has it's own form of attacking, which requries a slighly diffrent code for each, so I decided to use abstraction. Taking damage and dying are both simular stories. Both of those also would require slightly diffrent code based on the enemies. All of these can be found in the enemies.gd file. The traps also use abstraction via a abstract activate funciton to allow for their diffrent behavior. (trapBase.gd)
* Godot Features
	* Node Types - This project uses a variety of nodes, such as Character Bodies, Static Bodies, a variety of control nodes, tile 			map layers, and more.
	* Signals - This project includes several cutom signals. The enimies each have a raycast with a custom signal that detects 			colision. The player has a customm signal that updates the health bar. The Invtory has a custom signal to 			update the slots when you pick up or use an item.
	* Scenes - This project has many organized scenes, to allow for easy level creation and modification.
   	* Resources - The inventory system utalizes resources in many diffrent spots. It has a resource for each item and a resource 			to keep track of all the items in the inventory. This can be seen in most inventory files, including 				inventoryItem.gd, and inventory.gd. Along with each item's coresponding .tres file. 
* Movement and Collisions - The player can move about the world. The player also has an additional dash movement function. The project has 7 or so colsion layers, only 2 are used by the tileset. These can be found in the overworld.tscn and the
* Enemies and Traps - The enmies are as folow:
  		* All enemies share the same logic for moving and chasing the player. They use raycasts to detect obsticles, and will 		give up if the player gets to far away for too long, or if the player is behind a wall for too long.
  		* Basic 1- Goblin: The goblin is the basic enemy, it has a basic attack, and moderate health (goblin.tscn)
    		* Basic 2- Slime: The sime has the added ability of being able to split itself into other slimes. Each slime only can 		splt while on screen, and each slime is capped at only spliting into 16 slimes. They are also the only enemy that can 		continue to move while attakcing. They have low helath and cloned slimes take amplifed damage. (slime.tscn)
    		* Basic 3- Wolf: The wolf's ability is to call other wolves to its aid when one dies. When a wolf dies, all nearby 		wolves will attempt to go to the player, even if they weren't targeting it. Wolves also get a health, damage, and 		speed buff when one dies. If enough wolves die, wolves can begin to outrun the player. Wolves are exclusive to the 		overwolrd (wolf.tscn)
  		* Intelligent Enemy- Golem: The golem enemy is a ranged enemy that shoots projectiles. It has the added intelligence 		of being able to detect how far away it's target is, and falling back if its target gets too close to it. 			Golems have high health and moderate damage. The golem is exusive to the maze.(golem.tscn)
  		* Neutral Enemy- Golem: The Golem enemy is a ranged enemy that shoots projectiles. In adition to targeting the player, 		it will attack any enemy that it sees. When a enemy is attacked, it will fight back against the golem.(golem.tscn)
		###Traps###
  		* Spike Trap: The spike trap activates and deals damage to the player after a short delay. When a spike trap is 			activated, it'll also activate adjacent spike traps. If the player continues to stand on the trap, it won't 			activate again until they move. (spikeTrap.tscn)
		* Fire Trap: The fire trap activates after a slightly longer delay. When a fire trap is activated, it'll deal 10 			damage every second the player remains standing on it. Steping off will deactivate the trap. (fireTrap.tscn)
  		*Each trap has 3 diffren modes, controlled by the stepTolerance varible:
  			*visible- the trap is visble and activates normaly (-1 step tolerance)
    			*hidden- the trap is hidden and will become visible when activated. Activates normaly(0 step tolerance)
    			*smart- the trap is hidden and won't unhide or activate until the second time a player touches it.(1 step 				tolerance)
  		* These can be found inside each trap scene(inside the trap folder)  
  
* Tilemaps and Worldbuilding - We use 3 tilesets, two for the overworld and one for the maze. Our tilesets use physics layers. They do not use navigation layers or terrain ###Start here###
* Combat -
* Inventory -
* GUI -
* 
  ####Roles####
  Zane - 
  Gavy - 
  Dan - 
