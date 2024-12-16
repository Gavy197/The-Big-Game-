extends Resource
#class
class_name Inventory
#signal
signal updated

@export var slots: Array[InventorySlot]

func clear():
	for i in slots:
		var index = slots.find(i)
		remove_at_index(index)

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			
	updated.emit()

	
	
func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	slots[index] = inventorySlot.new()
	updated.emit()
	remove_at_index(index)
	
	
func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()
	
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()
	
	
func use_item(inventorySlot:InventorySlot) -> void:
	print(inventorySlot)
	var index = slots.find(inventorySlot)
	if index < 0 || index >= slots.size() || !slots[index].item: return
	updated.emit()
	
	remove_at_index(index)
	
	
	
