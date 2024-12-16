# Second Quarter Template

### Gameplay Features to Be Graded (Max 8)
* Movement and Collision
* Enemies and Traps
* Tilemaps and Worldbuilding
* Combat
* Inventory
* GUI

### Examples/Locations of Implemented Features for Grading
* Inheritance - This project uses inheritance in the enemies, which can be found in the baseEnemy.gd file. It also uses inheritance in the inventory, inside the inventoryItem.gd file. The golem enemy overides it's parent on_range_body_entered function in order to allow it to attack other enemies. All the eniemies use all the other logic found in their parent, exepct for attacking, taking damage, and dying. These were abstacted. The inventory items all use the logic from their parent class.
* Encapsulation - Logic of classes was grouped togehter into variables, onreadys, and preloads. No private varibels are used.
* Polymorphism - 
* Abstraction - 
* Godot Features
	* Node Types - This project uses a variety of nodes, such as Character Bodies, Static Bodies, a variety of control nodes, tile 			map layers, and more.
	* Signals - This project includes several cutom signals. The enimies each have a raycast with a custom signal that detects 			colision. The player has a customm signal that updates the health bar. The Invtory has a custom signal to 			update the slots when you pick up or use an item.
	* Scenes - This project has many organized scenes, to allow for easy level creation and modification.
   	* Resources - The inventory system utalizes resources in many diffrent spots. It has a resource for each item and a resource 			to keep track of all the items in the inventory.
* Movement and Collisions - 
* Enemies and Traps - 
* Tilemaps and Worldbuilding - 
* Combat -
* Inventory -
* GUI -
* 
  ####Roles####
  Zane - 
  Gavy - 
  Dan - 
