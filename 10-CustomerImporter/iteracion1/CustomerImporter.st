!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'AS 11/10/2022 20:23:08'!
assertNumberOfImportedCustomersIs: aNumberOfCustomers

	^ self assert: aNumberOfCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/10/2022 20:23:12'!
test01Import
	
	
	(CustomerImporter from: readStream into: session) value. 
	
	self assertNumberOfImportedCustomersIs: 2.
	self assertCustomerPepeSanchezWasCorrectlyImported.
	self assertCustomerJuanPerezWasCorrectlyImported.! !


!ImportTest methodsFor: 'support' stamp: 'AS 11/10/2022 19:31:38'!
validData

	^ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'assertions' stamp: 'AS 11/10/2022 20:23:48'!
assertCustomerJuanPerezWasCorrectlyImported
	
	| customerJuanPerez customerPepeFirstAddress |
	
	customerJuanPerez := self customerWithId: '23-25666777-9'.
	self assertImportedCustomer: customerJuanPerez importedNameIs: 'Juan' lastNameIs: 'Perez' idTypeIs: 'C'.

	customerPepeFirstAddress := customerJuanPerez addressWithStreetName: 'Alem' ifNone: [self fail].
	self assertImportedAddress: customerPepeFirstAddress importedStreetNumberIs: 1122 townIs: 'CABA'  zipCodeIs: 1001 provinceIs: 'CABA'.! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 11/10/2022 20:18:35'!
assertCustomerPepeSanchezWasCorrectlyImported
	
	| customerPepe customerPepeFirstAddress customerPepeSecondAddress |
	
	customerPepe := self customerWithId: '22333444'.
	self assertImportedCustomer: customerPepe importedNameIs: 'Pepe' lastNameIs: 'Sanchez' idTypeIs: 'D'.
	
	customerPepeFirstAddress := customerPepe addressWithStreetName: 'San Martin' ifNone: [self fail].
	self assertImportedAddress: customerPepeFirstAddress importedStreetNumberIs: 3322 townIs: 'Olivos' zipCodeIs: 1636 provinceIs: 'BsAs'.
	
	customerPepeSecondAddress := customerPepe addressWithStreetName: 'Maipu' ifNone: [self fail].
	self assertImportedAddress: customerPepeSecondAddress importedStreetNumberIs: 888 townIs: 'Florida' zipCodeIs: 1122 provinceIs: 'Buenos Aires'.! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 11/10/2022 20:18:35'!
assertImportedAddress: customerPepeFirstAddress importedStreetNumberIs: aStreetNumber townIs: aTown zipCodeIs: aZipCode provinceIs: aProvince    

	self assert: (customerPepeFirstAddress streetNumberIs: aStreetNumber).
	self assert: (customerPepeFirstAddress townIs: aTown).
	self assert: (customerPepeFirstAddress zipCodeIs: aZipCode).
	self assert: (customerPepeFirstAddress provinceIs: aProvince)! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 11/10/2022 20:06:28'!
assertImportedCustomer: aCustomer importedNameIs: aCustomerFirstName lastNameIs: aCustomerLastName idTypeIs: aCustomerIdType
	
	self assert: (aCustomer firstNameIs: aCustomerFirstName).
	self assert: (aCustomer lastNameIs: aCustomerLastName).
	self assert: (aCustomer idTypeIs: aCustomerIdType).
! !

!ImportTest methodsFor: 'assertions' stamp: 'AS 11/10/2022 20:03:31'!
customerWithId: aCustomerId
	
	^(session select: [:aCustomer | aCustomer idIs: aCustomerId] ofType: Customer) anyOne. ! !


!ImportTest methodsFor: 'set up / tear down' stamp: 'AS 11/10/2022 19:52:07'!
setUp
	
	readStream := self validData.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'set up / tear down'!
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
province: aProvince

	province := aProvince
	! !

!Address methodsFor: 'province' stamp: 'AS 11/10/2022 19:16:31'!
provinceIs: aProvince

	^province = aProvince
	! !


!Address methodsFor: 'street'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'AS 11/10/2022 19:12:32'!
streetNameIs: aStreetName 
	
	^streetName = aStreetName ! !

!Address methodsFor: 'street'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !

!Address methodsFor: 'street' stamp: 'AS 11/10/2022 19:12:55'!
streetNumberIs: aStreetNumber

	^streetNumber = aStreetNumber.! !


!Address methodsFor: 'twon'!
town: aTown

	town := aTown! !

!Address methodsFor: 'twon' stamp: 'AS 11/10/2022 19:15:46'!
townIs: aTownName
	
	^town = aTownName .! !


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

!Customer methodsFor: 'addresses' stamp: 'AS 11/10/2022 19:49:59'!
addressWithStreetName: aStreetName ifNone: aNoneBlock
	
	^(addresses select: [:anAddress | anAddress streetNameIs: aStreetName.]) anyOne.! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'AS 11/10/2022 19:52:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'AS 11/10/2022 19:52:47'!
value

	|   newCustomer line |
	line := readStream nextLine.
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
			newAddress province: addressData sixth.].

		line := readStream nextLine. ].
	
readStream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'AS 11/10/2022 19:52:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


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
