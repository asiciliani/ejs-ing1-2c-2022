!classDefinition: #CartTests category: 'TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 20:50:31'!
element1

	^ 'element1'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 20:50:43'!
element2

	^ 'element2'! !


!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 20:39:20'!
test01CartIsEmptyWhenCreated

	self assert: Cart new isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 20:50:31'!
test02CartIsNotEmptyAfterAddingElement
	
	| cart |
	cart := Cart new.
	cart add: self element1.
	
	self deny: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 20:51:30'!
test03CartSizeIsAmountOfNewAddedElements
	
	| cart |
	cart := Cart new.
	cart add: self element1.
	cart add: self element2.
	
	self assert: 2 equals: cart size.
	self deny: cart isEmpty ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'size' stamp: 'AS 10/27/2022 20:49:14'!
isEmpty
	
	^elements isEmpty ! !

!Cart methodsFor: 'size' stamp: 'AS 10/27/2022 20:49:14'!
size
	
	^elements size ! !


!Cart methodsFor: 'initialization' stamp: 'AS 10/27/2022 20:49:14'!
initialize

	elements := OrderedCollection new.! !


!Cart methodsFor: 'adding' stamp: 'AS 10/27/2022 20:49:14'!
add: anElement 

	elements add: anElement.! !
