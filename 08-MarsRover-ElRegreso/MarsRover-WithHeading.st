!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'support' stamp: 'AS 10/24/2022 21:47:09'!
eastHead

	^ MarsRoverHeadingEast headAsString! !

!MarsRoverLoggerTest methodsFor: 'support' stamp: 'AS 10/24/2022 20:09:02'!
north

	^MarsRoverHeadingNorth ! !

!MarsRoverLoggerTest methodsFor: 'support' stamp: 'AS 10/24/2022 21:47:21'!
northHead

	^ MarsRoverHeadingNorth headAsString! !

!MarsRoverLoggerTest methodsFor: 'support' stamp: 'AS 10/24/2022 21:47:35'!
southHead

	^ MarsRoverHeadingSouth headAsString! !

!MarsRoverLoggerTest methodsFor: 'support' stamp: 'AS 10/24/2022 21:47:28'!
westHead

	^ MarsRoverHeadingWest headAsString! !


!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'AS 10/27/2022 12:19:22'!
test01WhenOnlyLoggingPositionLogsAreEmptyWhenMarsRoverProcessesEmptyCommand

	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	logger := (MarsRoverLogger logPositionChangesOn: marsRover).
	marsRover process: ''.
	
	self assert: logger logs isEmpty! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'AS 10/27/2022 12:36:01'!
test02WhenOnlyLoggingPositionLogsOnlyShowNewPositionsAfterOnlyMovingInOneDirection

	| marsRover logger|
	marsRover := MarsRover at: 1@1 heading: self north.
	
	logger := (MarsRoverLogger logPositionChangesOn: marsRover).
	marsRover process: 'ff'.
	
	self assert: '1@2' equals: logger logs first.
	self assert: '1@3' equals: logger logs second.

	! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'AS 10/27/2022 12:29:49'!
test03WhenOnlyLoggingHeadLogsShowNewHeadingsAfterRotatingToAllPosibleDirections

	| marsRover logger|
	marsRover := MarsRover at: 1@1 heading: self north.
	
	logger := (MarsRoverLogger logHeadChangesOn: marsRover).
	marsRover process: 'rlll'.
	
	self assert: self eastHead equals: logger logs first.
	self assert: self northHead equals: logger logs second.
	self assert: self westHead equals: logger logs third.
	self assert: self southHead equals: logger logs fourth.

	! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'AS 10/27/2022 12:05:04'!
test04WhenLoggingPositionAndHeadLogsShowNewPositionAndNewHeadingAfterMovingAndThenRotating

	| marsRover logger|
	marsRover := MarsRover at: 1@1 heading: self north.
	
	logger := (MarsRoverLogger for: marsRover).
	marsRover process: 'fr'.
	
	self assert: '1@2' equals: logger logs first.
	self assert: self eastHead equals: logger logs second.
	

	! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'AS 10/27/2022 12:39:55'!
test05WhenLoggingPositionAndHeadLogsShowNewHeadingAndNewPositionAfterRotatingAndThenMoving

	| marsRover logger|
	marsRover := MarsRover at: 1@1 heading: self north.
	
	logger := (MarsRoverLogger for: marsRover).
	marsRover process: 'rf'.
	
	self assert: self eastHead equals: logger logs first.
	self assert: '2@1' equals: logger logs second.
	

	! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionLogger headingLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'AS 10/27/2022 10:29:54'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand .]
! !

!MarsRover methodsFor: 'command processing' stamp: 'AS 10/27/2022 09:58:33'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ self moveForward. ^self logPosition. ].
	(self isBackwardCommand: aCommand) ifTrue: [ self moveBackward.  ^self logPosition. ].
	(self isRotateRightCommand: aCommand) ifTrue: [ self rotateRight.  ^self logHead.  ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ self rotateLeft. ^self logHead. ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'logging' stamp: 'AS 10/27/2022 15:15:26'!
logHead

	^ headingLogger ifNotNil: [headingLogger value: head]! !

!MarsRover methodsFor: 'logging' stamp: 'AS 10/24/2022 21:32:58'!
logHeadingWith: aMarsRoverHeadingLogger 

	headingLogger := aMarsRoverHeadingLogger.! !

!MarsRover methodsFor: 'logging' stamp: 'AS 10/27/2022 15:07:11'!
logPosition

	^ positionLogger ifNotNil: [positionLogger value: position]! !

!MarsRover methodsFor: 'logging' stamp: 'AS 10/24/2022 21:36:36'!
logPositionWith: aMarsRoverPositionLogger 

	positionLogger := aMarsRoverPositionLogger.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!MarsRoverHeading class methodsFor: 'asString' stamp: 'AS 10/24/2022 21:45:57'!
headAsString
	self subclassResponsibility .! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'asString' stamp: 'AS 10/24/2022 21:46:03'!
headAsString
	
	^'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'asString' stamp: 'AS 10/24/2022 21:46:07'!
headAsString
	^'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !



!MarsRoverHeadingSouth methodsFor: 'error handling' stamp: 'AS 10/24/2022 21:42:42'!
error: aString 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'asString' stamp: 'AS 10/24/2022 21:46:11'!
headAsString
	
	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'asString' stamp: 'AS 10/24/2022 21:46:16'!
headAsString
	
	^'West'! !


!classDefinition: #MarsRoverHeadingFollower category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeadingFollower
	instanceVariableNames: 'marsRoverToLogHeadOn logs marsRoverLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingFollower methodsFor: 'initialization' stamp: 'AS 10/27/2022 15:14:58'!
initializeFor: aMarsRoverLogger 

	marsRoverLogger := aMarsRoverLogger.
	marsRoverLogger marsRover logHeadingWith: [:aHeading | self logHead: aHeading].
	logs := OrderedCollection new.! !


!MarsRoverHeadingFollower methodsFor: 'logging' stamp: 'AS 10/27/2022 12:15:38'!
logHead: aMarsRoverHeading

	marsRoverLogger logHead: aMarsRoverHeading ! !


!MarsRoverHeadingFollower methodsFor: 'operations' stamp: 'AS 10/24/2022 21:34:58'!
logs

	^logs! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingFollower class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingFollower class
	instanceVariableNames: ''!

!MarsRoverHeadingFollower class methodsFor: 'instance creation' stamp: 'AS 10/27/2022 12:09:25'!
for: aMarsRoverLogger
	
	^self new initializeFor: aMarsRoverLogger ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'marsRoverToLog positionFollower headFollower logs marsRoverToLogHeadChangesOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 12:24:21'!
initialize

	logs := OrderedCollection new.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 14:54:44'!
initializeFor: aMarsRoverToLogPositionAndHeadOn 

	marsRoverToLog := aMarsRoverToLogPositionAndHeadOn.
	positionFollower := MarsRoverPositionFollower for: self.
	headFollower := MarsRoverHeadingFollower for: self.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 12:31:13'!
initializeLoggingHeadChangesOn: aMarsRoverToLogHeadChangesOn 

	marsRoverToLog := aMarsRoverToLogHeadChangesOn.
	headFollower := MarsRoverHeadingFollower for: self.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 12:28:54'!
initializeLoggingPositionChangesOn: aMarsRoverToLogPositionOn

	marsRoverToLog := aMarsRoverToLogPositionOn.
	positionFollower := MarsRoverPositionFollower for: self.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 12:15:44'!
logHead: aMarsRoverHeading

	logs add: aMarsRoverHeading class headAsString ! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AS 10/27/2022 12:14:51'!
logPosition: aPosition 

	logs add: aPosition asString.! !


!MarsRoverLogger methodsFor: 'logs' stamp: 'AS 10/27/2022 12:15:56'!
logs
	^logs! !


!MarsRoverLogger methodsFor: 'mars rover' stamp: 'AS 10/27/2022 12:09:04'!
marsRover

	^marsRoverToLog ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'AS 10/25/2022 15:09:47'!
for: aMarsRoverToLogPositionAndHeadOn
	
	^self new initializeFor: aMarsRoverToLogPositionAndHeadOn ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'AS 10/27/2022 12:30:26'!
logHeadChangesOn: aMarsRoverToLogHeadChangesOn

	^self new initializeLoggingHeadChangesOn: aMarsRoverToLogHeadChangesOn ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'AS 10/27/2022 12:21:16'!
logPositionChangesOn: aMarsRoverToLogPositionOn
	^self new initializeLoggingPositionChangesOn: aMarsRoverToLogPositionOn ! !


!classDefinition: #MarsRoverPositionFollower category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverPositionFollower
	instanceVariableNames: 'marsRoverToLogPositionOf logs marsRoverLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionFollower methodsFor: 'initialization' stamp: 'AS 10/27/2022 15:14:07'!
initializeFor: aMarsRoverLogger 
	
	marsRoverLogger := aMarsRoverLogger.
	marsRoverLogger marsRover logPositionWith: [:aPosition | self logPosition: aPosition].
	logs := OrderedCollection new.! !


!MarsRoverPositionFollower methodsFor: 'operations' stamp: 'AS 10/24/2022 21:34:50'!
logs
	^logs! !


!MarsRoverPositionFollower methodsFor: 'logging' stamp: 'AS 10/27/2022 12:12:53'!
logPosition: aPosition 

	marsRoverLogger logPosition: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionFollower class' category: 'MarsRover-WithHeading'!
MarsRoverPositionFollower class
	instanceVariableNames: ''!

!MarsRoverPositionFollower class methodsFor: 'instance creation' stamp: 'AS 10/27/2022 12:05:45'!
for: aMarsRoverLogger

	^self new initializeFor: aMarsRoverLogger ! !
