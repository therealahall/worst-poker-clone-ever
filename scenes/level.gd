extends Node2D

var cardScene: PackedScene = preload("res://scenes/playing-card.tscn")
var maxCards: int = 5
var opponentHand: Dictionary = {}
var playerHand: Dictionary = {}
var discard: Dictionary = {}
var playingArea: Dictionary = {}
var cards: Dictionary = {}
var suits: Array = ['hearts', 'spades', 'clubs', 'diamonds']

var screenSize: Vector2
var positionPlayingAreaX: float
var positionPlayingAreaY: float
var positionPlayerHandX: float
var positionPlayerHandY: float

func _ready():
	screenSize = get_viewport().get_visible_rect().size
	positionPlayingAreaX = screenSize[0] * .15
	positionPlayingAreaY = screenSize[1] / 2
	positionPlayerHandX = screenSize[0] * .45
	positionPlayerHandY
	
	for suit in suits:
		playerHand.merge({suit: []})
		opponentHand.merge({suit: []})
		cards.merge({suit: []})
		discard.merge({suit: []})
		playingArea.merge({suit: []})
		for num in range(1,13):
			cards[suit].append(num)

	var cardRotation = -20

	for num in range(0,maxCards):
		var opponentCardScene = cardScene.instantiate()
		$"Opponents Cards".add_child(opponentCardScene)
		var opponentCard = generateRandomCard(opponentHand)

		var playerCardScene = cardScene.instantiate()
		$"Player Cards".add_child(playerCardScene)
		var playerCard = generateRandomCard(playerHand)
		var playerCardNode = playerCardScene.get_child(0)
		match num:
			1,2:
				positionPlayerHandY -= 10
			3,4:
				positionPlayerHandY += 25
			_:
				positionPlayerHandY = screenSize[1] - 30

		playerCardNode.setTexture(playerCard[0], playerCard[1])
		playerCardNode.setPosition(positionPlayerHandX, positionPlayerHandY)
		playerCardNode.setRotation(cardRotation)
		positionPlayerHandX += 50
		cardRotation += 10

	burnAndTurn(3,3)
	burnAndTurn(1,1)
	burnAndTurn(1,1)
	pass

func burnAndTurn(burn: int, generate: int):
	for num in range(0,burn):
		generateRandomCard(discard)

	for num in range(0,generate):
		var inPlayCardScene = cardScene.instantiate()
		$"Card Area".add_child(inPlayCardScene)
		var inPlayCard = generateRandomCard(playingArea)
		var inPlayCardNode = inPlayCardScene.get_child(0)
		inPlayCardNode.setTexture(inPlayCard[0], inPlayCard[1])
		inPlayCardNode.setPosition(positionPlayingAreaX, positionPlayingAreaY)
		inPlayCardNode.setSize(0.75)
		positionPlayingAreaX += 230


func generateRandomCard(destination: Dictionary):
	var random = RandomNumberGenerator.new()
	var suitArrayKey = random.randi_range(0,3)
	var suit = suits[suitArrayKey]
	var cardValue = cards[suit].pick_random()
	cards[suit].erase(cardValue)
	destination[suit].append(cardValue)
	return [suit, cardValue]
