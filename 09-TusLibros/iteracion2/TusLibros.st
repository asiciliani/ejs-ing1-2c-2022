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

!CartTests methodsFor: 'support' stamp: 'AS 10/31/2022 17:57:12'!
shouldFailWithMustBePositiveQuantityOfItemAddingQuantityOfItem: aQuantityOfItemToAdd
	
	self should: [cart add: aQuantityOfItemToAdd of: self item1SoldByStore]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart quantityOfItemToAddMustBePositiveErrorMessage.
							   self assert: cart isEmpty].! !


!CartTests methodsFor: 'setup' stamp: 'AS 10/27/2022 21:20:48'!
setUp
	
	storeCatalog := OrderedCollection with: self item1SoldByStore with: self item2SoldByStore.
	cart := Cart withCatalog: storeCatalog.! !


!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:54'!
test01CartIsEmptyWhenCreated
	
	self assert: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/31/2022 17:41:56'!
test02CartIsNotEmptyAfterAddingItemsAndIncludesThem
	
	cart add: self item1SoldByStore.
	
	self deny: cart isEmpty.
	self assert: cart includes: self item1SoldByStore ! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/27/2022 21:20:48'!
test03CartSizeIsAmountOfNewAddedItems
	
	cart add: self item1SoldByStore.
	cart add: self item2SoldByStore.
	
	self assert: 2 equals: cart size.
	self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'AS 10/31/2022 17:57:39'!
test04CanNotAddItemNotInStoreCatalog
	
	self should: [cart add: self itemNotSoldByStore]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart canNotAddItemNotSoldByStoreErrorMessage.
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

!CartTests methodsFor: 'tests' stamp: 'AS 10/31/2022 18:11:42'!
test09CanNotAddNonIntegerQuantityOfItem
	
	self should: [cart add: 1.5 of: self item1SoldByStore]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart quantityOfItemToAddMustBePositiveIntegerErrorMessage.
							   self assert: cart isEmpty].! !


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

!Cart methodsFor: 'error signal' stamp: 'AS 10/31/2022 17:52:37'!
quantityOfItemToAddMustBePositiveIntegerErrorSignal

	^ self error: self class quantityOfItemToAddMustBePositiveIntegerErrorMessage! !


!Cart methodsFor: 'adding' stamp: 'AS 10/27/2022 23:16:18'!
add: anItemToAddToCart 

	self assertIsSoldByStore: anItemToAddToCart.
	items add: anItemToAddToCart.! !

!Cart methodsFor: 'adding' stamp: 'AS 10/31/2022 17:53:12'!
add: aQuantityOfItemToAdd of: anItem 

	self assertIsPositiveInteger: aQuantityOfItemToAdd.
	
	aQuantityOfItemToAdd timesRepeat: [self add: anItem].! !


!Cart methodsFor: 'assertions' stamp: 'AS 10/31/2022 17:53:28'!
assertIsInteger: aQuantityOfItemToAdd

	^ aQuantityOfItemToAdd isInteger ifFalse: [self quantityOfItemToAddMustBePositiveIntegerErrorSignal]! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:38:04'!
assertIsNotNegative: aQuantityOfItemToAdd

	^ (aQuantityOfItemToAdd < 0) ifTrue: [self quantityOfItemToAddMustBePositiveErrorSignal]! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:43:03'!
assertIsNotZero: aQuantityOfItemToAdd

	^ aQuantityOfItemToAdd isZero ifTrue: [self quantityOfItemToAddMustBePositiveErrorSignal]! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/31/2022 17:53:28'!
assertIsPositiveInteger: aQuantityOfItemToAdd

	self assertIsNotNegative: aQuantityOfItemToAdd.
	self assertIsNotZero: aQuantityOfItemToAdd.
	self assertIsInteger: aQuantityOfItemToAdd.! !

!Cart methodsFor: 'assertions' stamp: 'AS 10/27/2022 21:35:58'!
assertIsSoldByStore: anElement

	^ (storeCatalog includes: anElement) ifFalse: [self canNotAddItemNotSoldByStoreErrorSignal]! !


!Cart methodsFor: 'content' stamp: 'AS 10/27/2022 23:16:18'!
content
	
	^items ! !

!Cart methodsFor: 'content' stamp: 'AS 10/31/2022 17:40:58'!
includes: anItem
	
	^items includes: anItem ! !

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

!Cart class methodsFor: 'error message' stamp: 'AS 10/31/2022 17:50:55'!
quantityOfItemToAddMustBePositiveIntegerErrorMessage
	
	^'Quantity of item to add must be a positive integer!!'! !
