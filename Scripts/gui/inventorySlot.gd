extends Resource
#resources can only be loaded once so, can't do the stacking in the inventoryItem.gd
class_name InventorySlot

@export var item: InventoryItem
#stor the amount of items per slot to stack
@export var amount: int 

func new():
	var instance= self.duplicate()
	instance.amount=0
	instance.item=null
	
