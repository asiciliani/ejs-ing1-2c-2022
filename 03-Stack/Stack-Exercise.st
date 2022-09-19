!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:29:40'!
test01FindInEmptyStackReturnEmptyCollection

|finder prefix|
	finder := SentenceFinderByPrefix with: OOStack new.
	prefix := 'abc'.
	^self assert: (finder findSentencesWithPrefix: prefix) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 14:47:31'!
test02FindInNonEmptyStackWithoutLookedForElementReturnsEmptyCollection

	| finder prefix anOOStack | 
	
	anOOStack := OOStack new.
	
	anOOStack push: 'casa'.
	anOOStack push: 'auto'.
	anOOStack push: 'rayo'.
	anOOStack push: 'monte'.
	
	finder := SentenceFinderByPrefix with: anOOStack.
	
	prefix := 'ho'.
	
	^self assert: (finder findSentencesWithPrefix: prefix) isEmpty.
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 14:49:26'!
test03FindInNonEmptyStackWithLookedForElementsReturnsCollectionWithThem

	| anOOStack finder prefix | 
	anOOStack := OOStack new.
	
	anOOStack push: 'Hola'.
	anOOStack push: 'Hora'.
	anOOStack push: 'hora'.
	
	finder := SentenceFinderByPrefix with: anOOStack.
	
	prefix := 'Ho'.
	
	^self assert: ((finder findSentencesWithPrefix: prefix) isEqualTo: (OrderedCollection with: 'Hora' with: 'Hola')).
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 14:51:25'!
test04FindInNonEmptyStackWithLookedForElementsWithDifferentCaseSensitivityEmptyCollection

	| finder prefix anOOStack | 
	anOOStack := OOStack new.
	
	anOOStack push: 'Hola'.
	anOOStack push: 'Hora'.
	anOOStack push: 'hHora'.
	anOOStack push: 'hOora'.
	anOOStack push: 'AHora'.
	
	finder := SentenceFinderByPrefix with: anOOStack.
	
	prefix := 'ho'.
	
	^self assert: (finder findSentencesWithPrefix: prefix) isEmpty
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 14:53:21'!
test05FindInNonEmptyStackWithLookedForElementsDoesNotModifyStack

	| finder prefix anOOStack | 
	anOOStack := OOStack new.
	
	anOOStack push: 'casa'.
	anOOStack push: 'auto'.
	anOOStack push: 'rayo'.
	anOOStack push: 'monte'.
	
	finder := SentenceFinderByPrefix with: anOOStack.	
	prefix := 'ho'.
	finder findSentencesWithPrefix: prefix.
	
	self assert: anOOStack pop = 'monte'.
	self assert: anOOStack pop = 'rayo'.
	self assert: anOOStack pop = 'auto'.
	self assert: anOOStack pop = 'casa'! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 14:55:02'!
test06FindInNonEmptyStackWithPrefixLongerThanLookedForElementsReturnsEmptyCollection

	| finder prefix anOOStack | 
	anOOStack := OOStack new.
	
	anOOStack push: 'hora'.
	anOOStack push: 'ho'.
	anOOStack push: 'HO'.
	anOOStack push: 'comadreja'.
	
	finder := SentenceFinderByPrefix with: anOOStack.	
	prefix := 'horario'.
	^self assert: (finder findSentencesWithPrefix: prefix) isEmpty .! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elemento elementos state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'verificacion' stamp: 'FA 9/18/2022 11:15:26'!
isEmpty
 	^elementos isEmpty.! !

!OOStack methodsFor: 'verificacion' stamp: 'FA 9/18/2022 11:24:18'!
size
 	^elementos size.! !

!OOStack methodsFor: 'verificacion' stamp: 'FA 9/18/2022 11:53:52'!
top
	(self size = 0) ifTrue: [^self error: self class stackEmptyErrorDescription].
	^elementos last! !

!OOStack methodsFor: 'verificacion' stamp: 'FA 9/19/2022 09:24:35'!
topEmpty
	^self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'verificacion' stamp: 'FA 9/19/2022 09:25:37'!
topNoEmpty
	^elementos last! !


!OOStack methodsFor: 'Acciones' stamp: 'FA 9/18/2022 12:24:49'!
initialize 
	elementos := OrderedCollection new.
	state := OOStackEmpty new! !

!OOStack methodsFor: 'Acciones' stamp: 'FA 9/18/2022 12:27:37'!
pop
	^state pop: self.! !

!OOStack methodsFor: 'Acciones' stamp: 'FA 9/18/2022 12:26:54'!
popEmpty
	^self error: self class stackEmptyErrorDescription
! !

!OOStack methodsFor: 'Acciones' stamp: 'FA 9/19/2022 09:23:17'!
popNoEmpty
	|elementoPopeado|
	elementoPopeado := elementos removeLast.
	state := OOStackState handlerOfState: self size.
	^elementoPopeado .! !

!OOStack methodsFor: 'Acciones' stamp: 'FA 9/18/2022 12:27:13'!
push: unElementoAAgregar 
	elementos add: unElementoAAgregar.
	state := OOStackNoEmpty new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:21:58'!
handlerOfState: cantDeElementos
	^ (self subclasses detect: [:aSubClass | aSubClass handleState: cantDeElementos]) new.! !


!classDefinition: #OOStackEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 15:17:23'!
pop: contextoDelStack
	^contextoDelStack popEmpty

! !

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:24:13'!
top: contextoDeOOStack
	^ contextoDeOOStack topEmpty
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackEmpty class' category: 'Stack-Exercise'!
OOStackEmpty class
	instanceVariableNames: ''!

!OOStackEmpty class methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:20:40'!
handleState: cantDeElementos

	^cantDeElementos = 0.! !


!classDefinition: #OOStackNoEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackNoEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNoEmpty methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 15:17:33'!
pop: contextoDeStack
	^contextoDeStack popNoEmpty
	! !

!OOStackNoEmpty methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:25:05'!
top: contextoDeOOStack
	contextoDeOOStack topNoEmpty
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNoEmpty class' category: 'Stack-Exercise'!
OOStackNoEmpty class
	instanceVariableNames: ''!

!OOStackNoEmpty class methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:20:50'!
handleState: cantDeElementos
	^cantDeElementos > 0.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'myOOStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'FA 9/19/2022 09:42:40'!
initializeWith: anOOStack 
	myOOStack := anOOStack.! !


!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 15:14:47'!
findSentencesWithPrefix: aSentence
	|findResult auxiliaryOOStack|
	
	auxiliaryOOStack := OOStack new.
	
	findResult := self transferElementsFromStack: myOOStack toStack: auxiliaryOOStack andReturnCollectionWithThoseThatSatisfy:[:elem | elem beginsWith: aSentence ].
	
	self transferElementsFromStack: auxiliaryOOStack toStack: myOOStack .

	^findResult 	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:41:42'!
transferElementsFromStack: anOOStack toStack: anotherOOStack .

	^self transferElementsFromStack: anOOStack toStack: anotherOOStack  andReturnCollectionWithThoseThatSatisfy: [:elem|false]! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FA 9/19/2022 09:39:46'!
transferElementsFromStack: anOOStack toStack: anotherOOStack andReturnCollectionWithThoseThatSatisfy: aCondition 
	|aCollectionOfElementsThatSatisfyACondition element|
	aCollectionOfElementsThatSatisfyACondition := OrderedCollection new.
	
	[anOOStack isEmpty not] whileTrue: [
		element := anOOStack pop.
		(aCondition value: element) ifTrue: [aCollectionOfElementsThatSatisfyACondition addLast: element].
		anotherOOStack push: element. 
		].
	^aCollectionOfElementsThatSatisfyACondition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'FA 9/19/2022 09:30:49'!
with: anOOStack 
	^self new initializeWith: anOOStack ! !
