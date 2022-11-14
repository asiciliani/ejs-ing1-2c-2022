!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 18:17:51'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 18:20:55'!
test02ShouldFailImportingInvalidRecordType

	self should: [(CustomerImporter from: self invalidData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter invalidRecordTypeErrorMessage equals: anError messageText.
							   self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 18:27:51'!
test03ShouldFailImportingWithRepeatedRecordType

	self should: [(CustomerImporter from: self repeatedRecordTypeData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter invalidRecordTypeErrorMessage equals: anError messageText.
							   self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 19:24:15'!
test04ShouldFailImportingWithEmptyRecordType

	self should: [(CustomerImporter from: self emptyRecordData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter invalidEmptyRecordErrorMessage equals: anError messageText.
							   self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 19:51:41'!
test05ShouldFailImportingWhenCustomerRecordSizeIsSmallerThanExpected

	self should: [(CustomerImporter from: self smallerThanExpectedCustomerRecordSizeData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter differentThanExpectedCustomerRecordSizeErrorMessage equals: anError messageText.
							   self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 19:51:21'!
test06ShouldFailImportingWhenCustomerRecordSizeIsBiggerThanExpected

	self should: [(CustomerImporter from: self biggerThanExpectedCustomerRecordSizeData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter differentThanExpectedCustomerRecordSizeErrorMessage equals: anError messageText.
							   self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 19:51:31'!
test07ShouldFailImportingWhenAddressRecordSizeIsSmallerThanExpected

	self should: [(CustomerImporter from: self smallerThanExpectedAddressRecordSizeData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter differentThanExpectedAddressRecordSizeErrorMessage equals: anError messageText.
							self assert: 0 equals: (session selectAllOfType: Address ) size.   
							self assert: 1 equals: (session selectAllOfType: Customer) size.].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 19:50:09'!
test08ShouldFailImportingWhenAddressRecordSizeIsBiggerThanExpected

	self should: [(CustomerImporter from: self biggerThanExpectedAddressRecordSizeData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter differentThanExpectedAddressRecordSizeErrorMessage equals: anError messageText.
							self assert: 0 equals: (session selectAllOfType: Address ) size.   
							self assert: 1 equals: (session selectAllOfType: Customer) size.].! !

!ImportTest methodsFor: 'tests' stamp: 'AS 11/14/2022 20:10:55'!
test09ShouldFailImportingAddressWithoutRespectiveCustomer

	self should: [(CustomerImporter from: self addressRecordWithoutCustomerData into: session) value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CustomerImporter canNotImportAddressWithoutCustomerErrorMessage equals: anError messageText.
							self assert: 0 equals: (session selectAllOfType: Address ) size.   
							self assert: 0 equals: (session selectAllOfType: Customer) size.].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 20:11:50'!
addressRecordWithoutCustomerData
		^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:50:41'!
biggerThanExpectedAddressRecordSizeData
		^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,X'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:51:21'!
biggerThanExpectedCustomerRecordSizeData
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,X'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:16:15'!
emptyRecordData
	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:10:05'!
invalidData

	^ReadStream on: 'X,Pepe,Sanchez,D,22333444'.! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 18:28:27'!
repeatedRecordTypeData
	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:51:31'!
smallerThanExpectedAddressRecordSizeData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'AS 11/14/2022 19:51:41'!
smallerThanExpectedCustomerRecordSizeData
	^ ReadStream on:
'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream record line newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'assertions' stamp: 'AS 11/14/2022 19:51:01'!
assertAddressRecordHasExpectedSize

	^record size = self class expectedAddressRecordSize ifFalse: [self error: self class differentThanExpectedAddressRecordSizeErrorMessage ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'AS 11/14/2022 19:42:12'!
assertCustomerRecordHasExpectedSize

	^record size = self class expectedNumberOfRecordsPerLine ifFalse: [self error: self class differentThanExpectedCustomerRecordSizeErrorMessage ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'AS 11/14/2022 20:16:46'!
assertCustomerWasImported

	^ newCustomer ifNil: [self canNotImportAddressWithoutCustomerErrorSignal]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'AS 11/14/2022 19:24:42'!
assertRecordIsNotEmpty

	^ record ifEmpty: [self invalidEmptyRecordErrorSignal]! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'AS 11/14/2022 18:08:11'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AS 11/14/2022 19:08:35'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AS 11/14/2022 19:19:38'!
value

	[self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord.].

	! !


!CustomerImporter methodsFor: 'error signal' stamp: 'AS 11/14/2022 20:15:53'!
canNotImportAddressWithoutCustomerErrorSignal

	^ self error: self class canNotImportAddressWithoutCustomerErrorMessage! !

!CustomerImporter methodsFor: 'error signal' stamp: 'AS 11/14/2022 19:24:42'!
invalidEmptyRecordErrorSignal

	^ self error: self class invalidEmptyRecordErrorMessage! !

!CustomerImporter methodsFor: 'error signal' stamp: 'AS 11/14/2022 18:35:28'!
invalidRecordTypeErrorSignal

	^ self error: self class invalidRecordTypeErrorMessage! !


!CustomerImporter methodsFor: 'record' stamp: 'AS 11/14/2022 19:38:39'!
isAddressRecord
	^record first = 'A'! !

!CustomerImporter methodsFor: 'record' stamp: 'AS 11/14/2022 19:31:44'!
isCustomerRecord
	^record first = 'C'! !


!CustomerImporter methodsFor: 'import' stamp: 'AS 11/14/2022 19:39:38'!
importAddress

	|  newAddress |
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'import' stamp: 'AS 11/14/2022 19:37:38'!
importCustomer
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'import' stamp: 'AS 11/14/2022 20:16:46'!
importRecord

	self assertRecordIsNotEmpty.
	
	(self isCustomerRecord) ifTrue: [ self assertCustomerRecordHasExpectedSize.^self importCustomer].
		(self isAddressRecord) ifTrue: [ self assertAddressRecordHasExpectedSize.
								self assertCustomerWasImported.
								^self importAddress].
		self invalidRecordTypeErrorSignal.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error message' stamp: 'AS 11/14/2022 20:15:02'!
canNotImportAddressWithoutCustomerErrorMessage
	
	^'Must have a customer to import address to!!'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'AS 11/14/2022 19:45:19'!
differentThanExpectedAddressRecordSizeErrorMessage
	
	^'Number of records per line should be ', self expectedAddressRecordSize asString, '!!'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'AS 11/14/2022 19:42:12'!
differentThanExpectedCustomerRecordSizeErrorMessage
	^'Number of records per line should be ', self expectedNumberOfRecordsPerLine asString, '!!'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'AS 11/14/2022 19:24:15'!
invalidEmptyRecordErrorMessage
	^'Can not import empty record!!'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'AS 11/14/2022 18:24:12'!
invalidRecordTypeErrorMessage
	^'Can not import invalid record type!!'! !


!CustomerImporter class methodsFor: 'testing' stamp: 'AS 11/14/2022 19:45:35'!
expectedAddressRecordSize
	^6! !

!CustomerImporter class methodsFor: 'testing' stamp: 'AS 11/14/2022 19:02:08'!
expectedNumberOfRecordsPerLine
	^5! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
