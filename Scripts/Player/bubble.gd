extends StaticBody2D
#Variables
var timeElapsed:float
var running=true
var creator:Player
var expanded=false
var damage:int

#Onreadys
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hit_box: Area2D = $hitBox
#Signals
signal popped

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running==true:
		#Basicly a stopwatch
		timeElapsed+=delta
		#Inceases the speed the longer you hold
		animation_player.speed_scale=timeElapsed*.8
	#When you stop charging the attack, it will alter the size based on how long you held the button
	if Input.is_action_just_released("bubble"):
		expand()
func expand():
	#Prevensts it from expanding twice
	if expanded==false:
		expanded=true
		#Resets the speed
		animation_player.speed_scale=1
		animation_player.stop()
		collision_shape_2d.disabled=false
		running=false
		scale=Vector2(1,1)*timeElapsed*1.6
		hit_box.monitoring=true
		#Plays the fade animation
		animation_player.play("fade")
		#Unlocks player movement
		creator.normalMove=true
		#Removes player blocking effect
		creator.blocking=false
		#Sends a signal to the player to start the cooldown
		popped.emit()
		
	
#Expands the bubble if you hold it for too long
func _on_timer_timeout() -> void:
	expand()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Enemy:
		#Increases damage based on time charged
		body.takeDamage(damage+int(timeElapsed),creator)
