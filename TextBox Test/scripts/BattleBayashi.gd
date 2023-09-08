extends Node2D

var monster_hp = null
var player_hp = null
var player_pseudo = "YouLeGamer"
var choice = 0
var progress = 0
var index = "PLAYER"

func _ready():
	monster_hp = 100
	player_hp = 100
	$SquareButtons/Action1.visible = false
	$SquareButtons/Action2.visible = false
	$SquareButtons/Action3.visible = false
	$SquareButtons/Action4.visible = false
	$SquareButtons/Action5.visible = false
	$SquareButtons/Action6.visible = false
	$Labels/CanvasLayer/Situation1.text = "* Brace yourself!"
	$Labels/CanvasLayer/Situation2.text = "* Bayashi is ready to deep fry you!"
	
func _process(delta):
	$Labels/MonsterHp.text = str(monster_hp)
	$Labels/PlayerHp.text = str(player_pseudo, "     ", player_hp)
	if Input.is_action_just_pressed("confirm"):
		if index == "PLAYER" or index == "SPARE_ACCEPTED" or index == "SPARE_FLEE" or index == "LOST" or index == "WON":
			pass
		elif index == "BAYASHI":
			player_turn(progress, choice)
		elif index == "ACT" or index == "SPARE_REFUSED" or index == "ITEM" or index == "FIGHT":
			bayashi_turn(progress, choice)
	if monster_hp <= 0:
		if monster_hp < 0:
			monster_hp = 0
			player_win()
		else:
			player_win()
			
func turn_action_buttons_visible():
	$ActionButtons.visible = true
			
func turn_action_buttons_invisible():
	$ActionButtons.visible = false

func turn_buttons_invisible():
	$SquareButtons/Action1.visible = false
	$SquareButtons/Action2.visible = false
	$SquareButtons/Action3.visible = false
	$SquareButtons/Action4.visible = false
	$SquareButtons/Action5.visible = false
	$SquareButtons/Action6.visible = false
	
func turn_buttons_visible():
	$SquareButtons/Action1.visible = true
	$SquareButtons/Action2.visible = true
	$SquareButtons/Action3.visible = true
	$SquareButtons/Action4.visible = true
	$SquareButtons/Action5.visible = true
	$SquareButtons/Action6.visible = true
	
func turn_situation_visible():
	$Labels/CanvasLayer/Situation1.visible = true
	$Labels/CanvasLayer/Situation2.visible = true
	$Labels/CanvasLayer/Situation3.visible = true
	
func turn_situation_invisible():
	$Labels/CanvasLayer/Situation1.visible = false
	$Labels/CanvasLayer/Situation2.visible = false
	$Labels/CanvasLayer/Situation3.visible = false
	

func _on_act_button_pressed():
	turn_situation_invisible()
	turn_buttons_visible()
	choice = 2
	$SquareButtons/Action1.text = "Check"
	$SquareButtons/Action2.text = "Eat Bayashi"
	$SquareButtons/Action3.text = "Deep Fry"
	$SquareButtons/Action4.text = "Eat Cheese"
	$SquareButtons/Action5.text = "Talk"
	$SquareButtons/Action6.text = "Extinguish"


func _on_action_1_pressed():
	if choice == 1:
		index = "FIGHT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation1.text = "* You decided to one shot Bayashi."
		$Labels/CanvasLayer/Situation2.text = "* His deep frier did not save him from your wrath."
		$Labels/CanvasLayer/Situation3.visible = false
		monster_hp = 0
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation1.text = "* BAYASHI - ATK 10 DEF 200"
		$Labels/CanvasLayer/Situation2.text = "* A mad deep frier, ready for anything."
		$Labels/CanvasLayer/Situation3.visible = false
	elif choice == 3:
		index = "ITEM"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation1.text = "* You eat the God Food."
		$Labels/CanvasLayer/Situation1.text = "* Yummy!"
		$Labels/CanvasLayer/Situation1.text = "* You found your full health back!"
		player_hp = 100
	elif choice == 4:
		if progress == 4:
			index = "SPARE_ACCEPTED"
			turn_action_buttons_invisible()
			turn_buttons_invisible()
			turn_situation_visible()
			$Labels/CanvasLayer/Situation1.text = "* YOU WON!"
			$Labels/CanvasLayer/Situation2.text = "* You didn't win anything, this is a demo!"
			$Labels/CanvasLayer/Situation3.visible = false
		else:
			index = "SPARE_REFUSED"
			turn_action_buttons_invisible()
			turn_buttons_invisible()
			turn_situation_visible()
			$Labels/CanvasLayer/Situation1.text = "* You spare Bayashi, but Bayashi doesn't spare you!"
			$Labels/CanvasLayer/Situation2.text = "* The fight continues!"
			$Labels/CanvasLayer/Situation3.visible = false

func _on_action_2_pressed():
	if choice == 1:
		index = "FIGHT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation1.text = "* You attacked Bayashi."
		$Labels/CanvasLayer/Situation2.text = "* You damaged Bayashi of 10 HP!"
		$Labels/CanvasLayer/Situation3.visible = false
		monster_hp -= 10
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation2.visible = false
		$Labels/CanvasLayer/Situation1.text = "* You can't really eat Bayashi, can you?"
		$Labels/CanvasLayer/Situation3.visible = false
	elif choice == 3:
		pass
	elif choice == 4:
		index = "SPARE_FLEE"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		$Labels/CanvasLayer/Situation1.text = "You've flown away."
		$Labels/CanvasLayer/Situation2.visible = false
		$Labels/CanvasLayer/Situation3.visible = false

func _on_action_3_pressed():
	if choice == 1:
		pass
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		if progress == 2:
			$Labels/CanvasLayer/Situation1.text = "* You put Bayashi in the deep frier."
			$Labels/CanvasLayer/Situation2.text = "* The oil begins to violently bubble."
			$Labels/CanvasLayer/Situation3.visible = false
			progress += 1
		elif progress <= 1:
			$Labels/CanvasLayer/Situation1.text = "* The deep frier didn't even start..."
			$Labels/CanvasLayer/Situation2.visible = false
			$Labels/CanvasLayer/Situation3.visible = false
		elif progress >= 3:
			$Labels/CanvasLayer/Situation1.text = "* Bayashi was already deep fried..."
			$Labels/CanvasLayer/Situation2.visible = false
			$Labels/CanvasLayer/Situation3.visible = false

func _on_action_4_pressed():
	if choice == 1:
		pass
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		if progress == 0:
			$Labels/CanvasLayer/Situation1.text = "* You eat the cheese."
			$Labels/CanvasLayer/Situation2.text = "* Bayashi looks at you longingly."
			$Labels/CanvasLayer/Situation3.text = "* He wants to deep fry you even more!"
		elif progress == 1:
			$Labels/CanvasLayer/Situation1.text = "* You eat the cheese."
			$Labels/CanvasLayer/Situation2.text = "* Bayashi takes what remains, and violently"
			$Labels/CanvasLayer/Situation3.text = "  throws it in the deep frier."
			progress += 1
		elif progress > 1:
			$Labels/CanvasLayer/Situation1.text = "* Sadly, you don't have any more cheese..."
			$Labels/CanvasLayer/Situation2.visible = false
			$Labels/CanvasLayer/Situation3.visible = false

func _on_action_5_pressed():
	if choice == 1:
		pass
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		if progress == 0:
			$Labels/CanvasLayer/Situation1.text = "* You try talking to Bayashi."
			$Labels/CanvasLayer/Situation2.text = "* He seems not to listen to you and begins"
			$Labels/CanvasLayer/Situation3.text = "  putting oil in his deep frier."
			progress += 1
		elif progress > 0:
			$Labels/CanvasLayer/Situation1.text = "* You try talking to Bayashi."
			$Labels/CanvasLayer/Situation2.text = "* He doesnt listen to you anymore."
			$Labels/CanvasLayer/Situation3.text = "* Looks like talking is useless now..."

func _on_action_6_pressed():
	if choice == 1:
		pass
	elif choice == 2:
		index = "ACT"
		turn_action_buttons_invisible()
		turn_buttons_invisible()
		turn_situation_visible()
		if progress <= 2:
			$Labels/CanvasLayer/Situation1.text = "* What do you want to extinguish?"
			$Labels/CanvasLayer/Situation2.visible = false
			$Labels/CanvasLayer/Situation3.visible = false
		elif progress == 3:
			$Labels/CanvasLayer/Situation1.text = "* You take Bayashi out of the deep frier."
			$Labels/CanvasLayer/Situation2.text = "* He looks sad but relieved."
			$Labels/CanvasLayer/Situation3.text = "* You proved Bayashi you're a deep frier too!"
			progress += 1
		else:
			$Labels/CanvasLayer/Situation1.text = "* Bayashi spares you!"
			$Labels/CanvasLayer/Situation3.visible = false
			$Labels/CanvasLayer/Situation2.visible = false
			
func bayashi_turn(progress, choice):
	index = "BAYASHI"
	turn_action_buttons_invisible()
	turn_buttons_invisible()
	turn_situation_visible()
	$Labels/CanvasLayer/Situation1.text = "* Bayashi throws you boiling oil!"
	$Labels/CanvasLayer/Situation2.text = "* -10 HP"
	$Labels/CanvasLayer/Situation3.visible = false
	player_hp -= 10
	if player_hp <= 0:
		if player_hp < 0:
			player_hp = 0
			player_lose()
		else:
			player_lose()
		
func player_lose():
	index = "LOSE"
	turn_action_buttons_invisible()
	turn_buttons_invisible()
	turn_situation_visible()
	$Labels/CanvasLayer/Situation1.visible = false
	$Labels/CanvasLayer/Situation2.text = "Y o u   a r e   d e a d."
	$Labels/CanvasLayer/Situation3.visible = false		
		
func player_turn(progress, choice):
	turn_action_buttons_visible()
	index = "PLAYER"
	if progress == 0:
		$Labels/CanvasLayer/Situation1.text = "* Bayashi angrily prepares his deep frier."
		$Labels/CanvasLayer/Situation2.visible = false
		$Labels/CanvasLayer/Situation3.visible = false
	elif progress == 1:
		$Labels/CanvasLayer/Situation1.text = "* Bayashi puts oil in the deep frier!"
		$Labels/CanvasLayer/Situation2.visible = false
		$Labels/CanvasLayer/Situation3.visible = false
	elif progress == 2:
		$Labels/CanvasLayer/Situation1.text = "* Bayashi throws your cheese in the deep frier."
		$Labels/CanvasLayer/Situation2.text = "* A way better end for it."
		$Labels/CanvasLayer/Situation3.visible = false
	elif progress == 3:
		$Labels/CanvasLayer/Situation1.text = "* Bayashi seems to enjoy the deep frier."
		$Labels/CanvasLayer/Situation2.text = "* A little tear, though, runs down his face."
		$Labels/CanvasLayer/Situation3.visible = false
	elif progress >= 4:
		$Labels/CanvasLayer/Situation1.text = "* Bayashi spares you!"
		$Labels/CanvasLayer/Situation2.visible = false
		$Labels/CanvasLayer/Situation3.visible = false
	
func _on_spare_button_pressed():
	choice = 4
	turn_situation_invisible()
	$SquareButtons/Action3.visible = false
	$SquareButtons/Action4.visible = false
	$SquareButtons/Action5.visible = false
	$SquareButtons/Action6.visible = false
	$SquareButtons/Action1.visible = true
	$SquareButtons/Action2.visible = true
	$SquareButtons/Action1.text = "Spare"
	$SquareButtons/Action2.text = "Flee"


func _on_item_button_pressed():
	choice = 3
	turn_situation_invisible()
	$SquareButtons/Action3.visible = false
	$SquareButtons/Action4.visible = false
	$SquareButtons/Action5.visible = false
	$SquareButtons/Action6.visible = false
	$SquareButtons/Action1.visible = true
	$SquareButtons/Action2.visible = false
	$SquareButtons/Action1.text = "God Food"
	
func _on_fight_button_pressed():
	choice = 1
	turn_situation_invisible()
	$SquareButtons/Action3.visible = false
	$SquareButtons/Action4.visible = false
	$SquareButtons/Action5.visible = false
	$SquareButtons/Action6.visible = false
	$SquareButtons/Action1.visible = true
	$SquareButtons/Action2.visible = true
	$SquareButtons/Action1.text = "One Shot"
	$SquareButtons/Action2.text = "Normal Attack"

func player_win():
	index = "WON"
	turn_action_buttons_invisible()
	turn_buttons_invisible()
	turn_situation_visible()
	$Labels/CanvasLayer/Situation1.text = "* YOU WON!"
	$Labels/CanvasLayer/Situation2.text = "* You didn't win anything, this is a demo!"
	$Labels/CanvasLayer/Situation3.visible = false
	
	
	
	
	
