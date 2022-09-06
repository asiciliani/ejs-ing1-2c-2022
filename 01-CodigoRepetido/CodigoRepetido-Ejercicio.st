!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 16:08:12'!
assert: customerBook activeCustomersIs: activeCustomers suspenderCustomersIs: suspendedCustomersAmount customersIs: customersAmount   

	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomersAmount equals: customerBook numberOfSuspendedCustomers.
	self assert: customersAmount equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:06:17'!
assert: aBlock takesLessThan: anAmountOfTime

	self assert: (self measureTimeOf: aBlock) < anAmountOfTime.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:01:23'!
measureTimeOf: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^millisecondsAfterRunning - millisecondsBeforeRunning ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:53:17'!
should: aBlock raise: anException assert: assertionBlock
	
	aBlock on: anException do: [ :anError | assertionBlock value: anError ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:50:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:14:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook with: paulMcCartney.
	  
	self assert: [customerBook removeCustomerNamed: paulMcCartney] takesLessThan: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:52:36'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self should:[ customerBook addCustomerNamed: ''.
			self fail ]
		raise: Error 
		assert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:54:48'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney'.
				self fail ]
		raise: NotFound 
		assert: [:anError | 
				self assert: customerBook numberOfCustomers = 1.
			   	self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 16:08:12'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook with: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: customerBook activeCustomersIs: 0 suspenderCustomersIs: 1 customersIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 16:09:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook with: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: customerBook activeCustomersIs: 0 suspenderCustomersIs: 0 customersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:56:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: 'George Harrison'.
			self fail ] 
		raise: CantSuspend
		assert: [:anError | 
				self assert: customerBook numberOfCustomers = 1.
			    	self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AS 9/6/2022 15:56:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: johnLennon.
				self fail ]
		raise: CantSuspend 
		assert: [:anError | 
				self assert: customerBook numberOfCustomers = 1.
				self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !

!CustomerBook methodsFor: 'initialization' stamp: 'AS 9/6/2022 15:16:35'!
initializeWith: aCustomer 
	self addCustomerNamed: aCustomer.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !


!CustomerBook class methodsFor: 'instance creation' stamp: 'AS 9/6/2022 15:15:31'!
with: aCustomer
	^self new initializeWith: aCustomer ! !
