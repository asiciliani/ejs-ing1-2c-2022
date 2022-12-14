!classDefinition: #CartTests category: 'TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: 'storeCatalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 23:16:38'!
item1SoldByStore

	^ 'item1'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 23:16:42'!
item2SoldByStore

	^ 'item2'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 21:17:51'!
itemNotSoldByStore
	
	^'itemNotSoldByStore'! !

!CartTests methodsFor: 'support' stamp: 'AS 10/27/2022 21:51:23'!
shouldFailWithMustBePositiveQuantityOfItemAddingQuantityOfItem: aQuantityOfItemToAdd
	
	self should: [cart add: aQuantityOfItemToAdd of: self item1SoldByStore]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: Cart quantityOfItemToAddMustBePositiveErrorMessage equals: anError messageText.
							   self assert: cart isEmpty].! !


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

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:26:25'!
test05CanAddToCartManyOfSameItem
	
	cart add: 5 of: self item1SoldByStore.
	
	self assert: 5 equals: cart size.
	self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:51:23'!
test06CanNotAddNegativeQuantityOfItem
	
	self shouldFailWithMustBePositiveQuantityOfItemAddingQuantityOfItem: -1! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:51:23'!
test07CanNotAddZeroQuantityOfItem
	
	self shouldFailWithMustBePositiveQuantityOfItemAddingQuantityOfItem: 	0! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 23:13:21'!
test08CanGetItemsInCart
	
	cart add: 2 of: self item1SoldByStore.
	cart add: self item2SoldByStore.
	
	self assert: (Bag with: self item1SoldByStore with: self item1SoldByStore with: self item2SoldByStore) equals: cart content.
	
	self assert: 3 equals: cart size.
	self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 23:15:12'!
test09CartContentIsTheSameEvenWhenAddingInDifferentOrder
	
	| cart2 |
	
	cart2 := Cart withCatalog: storeCatalog.
	
	cart add: 2 of: self item1SoldByStore.
	cart add: self item2SoldByStore.
	
	cart2 add: self item2SoldByStore.
	cart2 add: 2 of: self item1SoldByStore.
	
	self assert: cart2 content equals: cart content.
	self assert: 3 equals: cart size.
	self deny: cart isEmpty ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items storeCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'size' stamp: 'AS 10/27/2022 23:16:18'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'size' stamp: 'AS 10/27/2022 23:16:18'!
size
	
	^items size ! !


!Cart methodsFor: 'initialization' stamp: 'AS 10/27/2022 23:16:18'!
initializeWithCatalog: aStoreCatalog 
	
	items := Bag new.
	storeCatalog := aStoreCatalog.! !


!Cart methodsFor: 'error signal' stamp: 'AS 10/27/2022 21:35:38'!
canNotAddItemNotSoldByStoreErrorSignal

	^ self error: self class canNotAddItemNotSoldByStoreErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'AS 10/27/2022 21:37:06'!
quantityOfItemToAddMustBePositiveErrorSignal

	^ self error: self class quantityOfItemToAddMustBePositiveErrorMessage! !


!Cart methodsFor: 'adding' stamp: 'AS 10/27/2022 23:16:18'!
add: anItemToAddToCart 

	self assertIsSoldByStore: anItemToAddToCart.
	items add: anItemToAddToCart.! !

!Cart methodsFor: 'adding' stamp: 'AS 10/27/2022 21:43:48'!
add: aQuantityOfItemToAdd of: anItem 

	self assertIsPositive: aQuantityOfItemToAdd.
	
	aQuantityOfItemToAdd timesRepeat: [self add: anItem].! !


!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:38:04'!
assertIsNotNegative: aQuantityOfItemToAdd

	^ (aQuantityOfItemToAdd < 0) ifTrue: [self quantityOfItemToAddMustBePositiveErrorSignal]! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:43:03'!
assertIsNotZero: aQuantityOfItemToAdd

	^ aQuantityOfItemToAdd isZero ifTrue: [self quantityOfItemToAddMustBePositiveErrorSignal]! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:43:48'!
assertIsPositive: aQuantityOfItemToAdd

	self assertIsNotNegative: aQuantityOfItemToAdd.
	self assertIsNotZero: aQuantityOfItemToAdd! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:35:58'!
assertIsSoldByStore: anElement

	^ (storeCatalog includes: anElement) ifFalse: [self canNotAddItemNotSoldByStoreErrorSignal]! !


!Cart methodsFor: 'content' stamp: 'AS 10/27/2022 23:16:18'!
content
	
	^items ! !

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

!Cart class methodsFor: 'error message' stamp: 'AS 10/27/2022 21:35:08'!
quantityOfItemToAddMustBePositiveErrorMessage
	
	^'Quantity of item to add must be positive!!'! !
