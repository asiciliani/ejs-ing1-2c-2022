!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'AS 11/10/2022 19:16:42'!
test01Import
	
	| customerPepe customerPepeAddresses firstAddress |
	
	self importCustomers. 
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	
	customerPepe := (session select: [:aCustomer | aCustomer idIs: '22333444'] ofType: Customer) anyOne. 
	self assert: (customerPepe firstNameIs: 'Pepe').
	self assert: (customerPepe lastNameIs: 'Sanchez').
	self assert: (customerPepe idTypeIs: 'D').
	
	customerPepeAddresses := (session select: [:anAddress | customerPepe hasAddress: anAddress] ofType: Address) ifEmpty: [self fail].
	firstAddress := customerPepeAddresses anyOne.
	
	self assert: (firstAddress streetNameIs: 'San Martin').
	self assert: (firstAddress streetNumberIs: 3322).
	self assert: (firstAddress townIs: 'Olivos').
	self assert: (firstAddress zipCodeIs: 1636).
	self assert: (firstAddress provinceIs: 'BsAs').! !


!ImportTest methodsFor: 'as yet unclassified' stamp: 'AS 11/10/2022 19:17:41'!
importCustomers

	| inputStream  newCustomer line |
	inputStream := StandardFileStream new open: 'input.txt' forWrite: false.
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.
			session persist: newCustomer].

		line := inputStream nextLine. ].
	
inputStream close! !

!ImportTest methodsFor: 'as yet unclassified'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified'!
tearDown

	session commit.
	session close! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province'!
province

	^province! !

!Address methodsFor: 'province'!
province: aProvince

	province := aProvince
	! !

!Address methodsFor: 'province' stamp: 'AS 11/10/2022 19:16:31'!
provinceIs: aProvince

	^province = aProvince
	! !


!Address methodsFor: 'street'!
streetName

	^streetName ! !

!Address methodsFor: 'street'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'AS 11/10/2022 19:12:32'!
streetNameIs: aStreetName 
	
	^streetName = aStreetName ! !

!Address methodsFor: 'street'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !

!Address methodsFor: 'street' stamp: 'AS 11/10/2022 19:12:55'!
streetNumberIs: aStreetNumber

	^streetNumber = aStreetNumber.! !


!Address methodsFor: 'twon'!
town

	^town! !

!Address methodsFor: 'twon'!
town: aTown

	town := aTown! !

!Address methodsFor: 'twon' stamp: 'AS 11/10/2022 19:15:46'!
townIs: aTownName
	
	^town = aTownName .! !


!Address methodsFor: 'zip code'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code'!
zipCode: aZipCode

	zipCode := aZipCode! !

!Address methodsFor: 'zip code' stamp: 'AS 11/10/2022 19:16:14'!
zipCodeIs: aZipCode
	
	^zipCode = aZipCode.! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'AS 11/10/2022 19:10:43'!
hasAddress: anAddress 
	^addresses includes: anAddress ! !


!Customer methodsFor: 'name'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name'!
firstNameIs: aCustomerFirstNameToCompareTo 
	
	^firstName = aCustomerFirstNameToCompareTo .! !

!Customer methodsFor: 'name'!
lastName: aLastName

	lastName := aLastName
! !

!Customer methodsFor: 'name'!
lastNameIs: aCustomerLastNameToCompareTo 
	
	^lastName  = aCustomerLastNameToCompareTo ! !


!Customer methodsFor: 'identification'!
idIs: aCustomerId 
	
	^identificationNumber = aCustomerId.! !

!Customer methodsFor: 'identification'!
idTypeIs: aCustomerIdTypeIs
	
	^identificationType  = aCustomerIdTypeIs.! !

!Customer methodsFor: 'identification'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
