!classDefinition: #CartTests category: 'TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: 'storeCatalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 21:17:35'!
item1SoldByStore

	^ 'element1'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 21:17:17'!
item2SoldByStore

	^ 'element2'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 21:17:51'!
itemNotSoldByStore
	
	^'itemNotSoldByStore'! !


!CartTests methodsFor: 'setup' stamp: 'AS 10/27/2022 21:20:48'!
setUp
	
	storeCatalog := OrderedCollection with: self item1SoldByStore with: self item2SoldByStore.
	cart := Cart withCatalog: storeCatalog.! !


!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:54'!
test01CartIsEmptyWhenCreated
	
	self assert: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:48'!
test02CartIsNotEmptyAfterAddingItems
	
	cart add: self item1SoldByStore.
	
	self deny: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:48'!
test03CartSizeIsAmountOfNewAddedItems
	
	cart add: self item1SoldByStore.
	cart add: self item2SoldByStore.
	
	self assert: 2 equals: cart size.
	self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:48'!
test04CanNotAddItemNotInStoreCatalog
	
	self should: [cart add: self itemNotSoldByStore]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: Cart canNotAddItemNotSoldByStoreErrorMessage equals: anError messageText.
							   self assert: cart isEmpty].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'elements storeCatalog'
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

!Cart methodsFor: 'initialization' stamp: 'AS 10/27/2022 21:10:39'!
initializeWithCatalog: aStoreCatalog 

	storeCatalog := aStoreCatalog.! !


!Cart methodsFor: 'adding' stamp: 'AS 10/27/2022 21:12:28'!
add: anElement 

	(storeCatalog includes: anElement) ifFalse: [self error: self class canNotAddItemNotSoldByStoreErrorMessage].
	
	elements add: anElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AS 10/27/2022 21:10:30'!
withCatalog: aStoreCatalog

	^self new initializeWithCatalog: aStoreCatalog ! !


!Cart class methodsFor: 'error message' stamp: 'AS 10/27/2022 21:13:01'!
canNotAddItemNotSoldByStoreErrorMessage
	
	^'Item not sold by Store!!'! !
