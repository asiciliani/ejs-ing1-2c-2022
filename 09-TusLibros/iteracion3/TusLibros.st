!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #SystemFacadeTest category: 'TusLibros'!
TestCase subclass: #SystemFacadeTest
	instanceVariableNames: 'testObjectsFactory salesBook debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'AS 11/6/2022 01:05:46'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!SystemFacadeTest methodsFor: 'setup' stamp: 'AS 11/6/2022 01:05:27'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	salesBook := OrderedCollection new.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!SystemFacadeTest methodsFor: 'support' stamp: 'AS 11/3/2022 21:02:43'!
invalidCartId
	
	^'invalidCartId'! !

!SystemFacadeTest methodsFor: 'support' stamp: 'AS 11/3/2022 20:07:35'!
invalidClientId
	
	^'invalidClientId'! !

!SystemFacadeTest methodsFor: 'support' stamp: 'AS 11/3/2022 20:06:01'!
invalidClientPassword

	^ 'invalidPassword'! !

!SystemFacadeTest methodsFor: 'support' stamp: 'AS 11/3/2022 20:05:48'!
validClientId

	^ 'validId'! !

!SystemFacadeTest methodsFor: 'support' stamp: 'AS 11/3/2022 20:06:16'!
validClientPassword

	^ 'validPassword'! !


!SystemFacadeTest methodsFor: 'tests' stamp: 'AS 11/6/2022 01:06:18'!
test01CanNotCreateCartWithInvalidClientIdOrPassword
	
	| systemFacade |
	
	systemFacade := SystemFacade withClientAuthenticator: (ClientAuthenticatorDouble thatAlwaysFails) acceptingItemsOf: testObjectsFactory defaultCatalog chargingWith: self onDate: testObjectsFactory today registeringOn: salesBook.
	
	self should: [systemFacade createCartForClientId: self validClientId withPassword: self invalidClientPassword] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: SystemFacade invalidClientIdOrPasswordErrorMessage].
	
	! !

!SystemFacadeTest methodsFor: 'tests' stamp: 'AS 11/6/2022 01:06:22'!
test02CanCreateCartWithValidClientIdAndPassword
	
	| cartId systemFacade |
	
	systemFacade := SystemFacade withClientAuthenticator: (ClientAuthenticatorDouble thatAlwaysSucceeds) acceptingItemsOf: testObjectsFactory defaultCatalog chargingWith: self onDate: testObjectsFactory today registeringOn: salesBook.
	
	cartId := systemFacade createCartForClientId: self validClientId withPassword: self validClientPassword.
	
	self assert: (OrderedCollection with: 0) equals: (systemFacade listCartOf: cartId)! !

!SystemFacadeTest methodsFor: 'tests' stamp: 'AS 11/6/2022 01:06:27'!
test03CanNotListCartOfInvalidCartId
	
	|  systemFacade |
	
	systemFacade := SystemFacade withClientAuthenticator: (ClientAuthenticatorDouble thatAlwaysSucceeds) acceptingItemsOf: testObjectsFactory defaultCatalog chargingWith: self onDate: testObjectsFactory today registeringOn: salesBook.
	
	self should: [systemFacade listCartOf: self invalidCartId]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: SystemFacade canNotListCartOfInvalidCartIdErrorMessage]! !

!SystemFacadeTest methodsFor: 'tests' stamp: 'AS 11/6/2022 01:06:31'!
test04CanCorrectlyAddToCart
	
	| cartId systemFacade |
	
	systemFacade := SystemFacade withClientAuthenticator: (ClientAuthenticatorDouble thatAlwaysSucceeds) acceptingItemsOf: testObjectsFactory defaultCatalog chargingWith: self onDate: testObjectsFactory today registeringOn: salesBook.
	
	cartId := systemFacade createCartForClientId: self validClientId withPassword: self validClientPassword.
	systemFacade add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	self assert: (OrderedCollection with: 0 with: testObjectsFactory itemSellByTheStore with: 2) 	equals: (systemFacade listCartOf: cartId)! !

!SystemFacadeTest methodsFor: 'tests' stamp: 'AS 11/7/2022 15:44:44'!
test05CanCheckoutCartAndCorrectlyListPurchases
	
	| cartId systemFacade |
	
	systemFacade := SystemFacade withClientAuthenticator: (ClientAuthenticatorDouble thatAlwaysSucceeds) acceptingItemsOf: testObjectsFactory defaultCatalog chargingWith: self onDate: testObjectsFactory today registeringOn: salesBook.
	
	cartId := systemFacade createCartForClientId: self validClientId withPassword: self validClientPassword.
	systemFacade add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	systemFacade checkout: cartId withCard: testObjectsFactory notExpiredCreditCard.
	self assert: (OrderedCollection with: salesBook first) equals: (systemFacade listPurchasesOf: self validClientId withPassword: self validClientPassword).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AS 11/7/2022 14:43:29'!
createSale

	^ Sale of: cart amountingTo: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientAuthenticatorDouble category: 'TusLibros'!
Object subclass: #ClientAuthenticatorDouble
	instanceVariableNames: 'authenticationResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientAuthenticatorDouble methodsFor: 'authentication' stamp: 'AS 11/3/2022 20:43:43'!
authenticateClientId: aClientId withPassword: aClientPassword
 
	
	^authenticationResult.! !


!ClientAuthenticatorDouble methodsFor: 'initialization' stamp: 'AS 11/3/2022 20:51:39'!
initializeWithAuthenticationResult: anAuthenticationResult
	
	authenticationResult := anAuthenticationResult.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientAuthenticatorDouble class' category: 'TusLibros'!
ClientAuthenticatorDouble class
	instanceVariableNames: ''!

!ClientAuthenticatorDouble class methodsFor: 'instance creation' stamp: 'AS 11/3/2022 20:49:52'!
thatAlwaysFails

	^self new initializeWithAuthenticationResult: false! !

!ClientAuthenticatorDouble class methodsFor: 'instance creation' stamp: 'AS 11/3/2022 20:50:03'!
thatAlwaysSucceeds

	^self new initializeWithAuthenticationResult: true! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total cart id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AS 11/7/2022 14:20:03'!
initializeOf: aCart amountToTotal: aTotal

	total := aTotal.
	cart := aCart ! !


!Sale methodsFor: 'cart' stamp: 'AS 11/7/2022 14:49:19'!
isAssociatedToCart: aCart 
	^cart == aCart.! !


!Sale methodsFor: 'id' stamp: 'AS 11/7/2022 16:02:19'!
id
	^id! !

!Sale methodsFor: 'id' stamp: 'AS 11/7/2022 15:11:36'!
saleId: aSaleId 
	id := aSaleId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AS 11/7/2022 00:51:31'!
of: aCart amountingTo: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeOf: aCart amountToTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #SystemFacade category: 'TusLibros'!
Object subclass: #SystemFacade
	instanceVariableNames: 'clientAuthenticator carts lastCartId storeCatalog cartItems merchantProcessor date salesBook lastTransactionId clientCartIds clientSalesIds'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacade methodsFor: 'initialization' stamp: 'AS 11/7/2022 15:27:33'!
initializeWithClientAuthenticator: aClientAuthenticator acceptingItemsOf: aStoreCatalog chargingWith: aMerchantProcessor onDate: aDate registeringOn: aSalesBook     

	clientAuthenticator := aClientAuthenticator.
	storeCatalog := aStoreCatalog.
	merchantProcessor := aMerchantProcessor.
	date := aDate.
	salesBook := aSalesBook.
	carts := Dictionary new.
	cartItems := Dictionary new.
	clientCartIds := Dictionary new.
	clientSalesIds := Dictionary new.
	lastCartId := 1.
	lastTransactionId := 1.! !


!SystemFacade methodsFor: 'error signal' stamp: 'AS 11/3/2022 20:53:37'!
invalidClientIdOrPasswordErrorSignal

	^ self error: self class invalidClientIdOrPasswordErrorMessage! !


!SystemFacade methodsFor: 'assertions' stamp: 'AS 11/3/2022 20:54:40'!
assertId: aClientId authenticatesWithPassword: aClientPassword

	(clientAuthenticator authenticateClientId: aClientId withPassword: aClientPassword) ifFalse: [self invalidClientIdOrPasswordErrorSignal].
 
	! !


!SystemFacade methodsFor: 'cart' stamp: 'AS 11/7/2022 15:26:53'!
createCartForClientId: aClientId withPassword: aClientPassword

	| cartId |
	
	self assertId: aClientId authenticatesWithPassword: aClientPassword.
	
	cartId := lastCartId+1.
	carts at: cartId put: (Cart acceptingItemsOf: storeCatalog).
	cartItems at: cartId put: OrderedCollection new.
	clientCartIds at: aClientId put: (OrderedCollection with: cartId).
	^cartId. 
	! !

!SystemFacade methodsFor: 'cart' stamp: 'AS 11/5/2022 22:40:53'!
listCartOf: aCartId
	
	| cart listCartResult | 
	
	cart := carts at: aCartId ifAbsent: [self error: self class canNotListCartOfInvalidCartIdErrorMessage].
	listCartResult := OrderedCollection with: 0.
	(cartItems at: aCartId) do: [:anItemInCart | listCartResult add: anItemInCart.
									 listCartResult add: (cart occurrencesOf: anItemInCart)].
	^listCartResult ! !


!SystemFacade methodsFor: 'adding' stamp: 'AS 11/5/2022 22:37:30'!
add: aQuantityToAdd of: aBookISBNToAdd to: aCartIdToAddTo 
	
	| cart |
	cart := (carts at: aCartIdToAddTo).
	cart add: aQuantityToAdd of: aBookISBNToAdd.
	(cartItems at: aCartIdToAddTo ifAbsent: [OrderedCollection new]) add: aBookISBNToAdd.! !


!SystemFacade methodsFor: 'checkout' stamp: 'AS 11/7/2022 16:03:03'!
checkout: aCartIdToCheckout withCard: aCreditCardToCharge 

	| clientId saleId |
	
	(Cashier toCheckout: (carts at: aCartIdToCheckout) 
			charging: aCreditCardToCharge 
			throught: merchantProcessor
			on: date 
			registeringOn: salesBook) checkOut.
	
	saleId := lastTransactionId + 1.
	salesBook last saleId: saleId. 
	'Fue lo que se nos ocurrio para no acoplar id al checkout del cashier... No es lo mejor pues: no se crea el objeto completo, si otro sistema usa el modelo, el id no se estar?a utilizando.'.
	
	clientId := (clientCartIds keys select: [:key | (clientCartIds at: key) includes: aCartIdToCheckout]) first.
	
	clientSalesIds at: clientId put: (OrderedCollection with: saleId).
	^saleId.! !


!SystemFacade methodsFor: 'purchases' stamp: 'AS 11/7/2022 16:09:30'!
listPurchasesOf: aClientId withPassword: aClientPassword
	 
	
	
	self assertId: aClientId authenticatesWithPassword: aClientPassword.
	
	^salesBook select: [:aSale | (clientSalesIds at: aClientId) includes: aSale id].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemFacade class' category: 'TusLibros'!
SystemFacade class
	instanceVariableNames: ''!

!SystemFacade class methodsFor: 'instance creation' stamp: 'AS 11/6/2022 00:58:24'!
withClientAuthenticator: aClientAuthenticator acceptingItemsOf: aStoreCatalog chargingWith: aMerchantProcessor onDate: aDate registeringOn: aSalesBook    

	^self new initializeWithClientAuthenticator: aClientAuthenticator acceptingItemsOf: aStoreCatalog chargingWith: aMerchantProcessor onDate: aDate registeringOn: aSalesBook ! !


!SystemFacade class methodsFor: 'error message' stamp: 'AS 11/3/2022 21:05:36'!
canNotListCartOfInvalidCartIdErrorMessage
	
	^'Can not list cart of an invalid cart id!!'! !

!SystemFacade class methodsFor: 'error message' stamp: 'AS 11/3/2022 20:45:13'!
invalidClientIdOrPasswordErrorMessage
	
	^'Could not authenticate client, invalid id or password!!'! !
