!classDefinition: #NumeroTest category: 'Pre-Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pre-Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'AS 9/12/2022 14:33:04'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'AS 9/12/2022 15:36:05'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'AS 9/12/2022 15:51:09'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'AS 9/12/2022 15:51:16'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'AS 9/12/2022 13:12:29'!
setUp
	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Pre-Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pre-Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:58:06'!
* aMultiplier 

	^aMultiplier multiplyWith: self.
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:31:29'!
+ anAdder 
	
	^anAdder addTo: self.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 15:48:02'!
// aDivisor 
	
	^aDivisor divide: self.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:30:22'!
addToEntero: anEntero
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 15:49:47'!
negated
	
	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 15:51:43'!
printOn: aStream
	
	self subclassResponsibility .! !


!Numero methodsFor: 'testing' stamp: 'AS 9/12/2022 13:18:25'!
isNegative
	
	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'AS 9/12/2022 13:18:07'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'AS 9/12/2022 13:14:21'!
isZero

	self subclassResponsibility.! !




!Numero methodsFor: 'comparing' stamp: 'AS 9/12/2022 14:23:37'!
= anObject

	self subclassResponsibility .! !

!Numero methodsFor: 'comparing' stamp: 'AS 9/12/2022 14:23:54'!
hash
	self subclassResponsibility .! !


!Numero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 12:11:42'!
addTo: aNumber
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Pre-Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !



!classDefinition: #Entero category: 'Pre-Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pre-Numero-Exercise'!

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:22:56'!
= anObject
	^value = anObject integerValue! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:31:36'!
addTo: aNumeroToAddTo
	^aNumeroToAddTo addToEntero: self.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:18:38'!
addToEntero: anEnteroToAddTo
	^self class with: value + anEnteroToAddTo integerValue.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:07:04'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:24:03'!
hash
	^value hash! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 13:11:48'!
initializeWith: aValue

	value := aValue.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:10:32'!
integerValue

	^value.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 13:18:46'!
isNegative

	^value < 0.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 13:18:36'!
isOne

	^value = 1.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 13:13:45'!
isZero

	^value = 0.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:29:04'!
multiplyEntero: anEnteroToMultiply

	^self class with: value * anEnteroToMultiply integerValue.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:28:39'!
multiplyWith: aMultiplier

	^aMultiplier multiplyEntero: self.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 15:50:01'!
negated
	^self * (self class with: -1)! !

!Entero methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:18:08'!
printOn: aStream

	aStream print: value.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:14:28'!
divide: anEntero 
	^self class with: anEntero integerValue // value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Pre-Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 12:22:23'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Pre-Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pre-Numero-Exercise'!

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:23:25'!
= anObject

	^(numerator * anObject denominator) = (denominator * anObject numerator)! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 15:01:47'!
addTo: aNumeroToAddTo
	^aNumeroToAddTo addToFraccion: self.! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:35:40'!
denominator
	^denominator! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:24:09'!
hash
	^(numerator hash / denominator hash) hash ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 12:25:10'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 15:48:42'!
isOne
	^false.! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 13:13:57'!
isZero
	^false.! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:26:31'!
m: aMultiplier
	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 15:35:49'!
multiplyWith: aFraccion 
	^aFraccion multiplyFraccion: self.! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 15:50:57'!
negated
	^self class with: numerator * (Entero with: -1) over: denominator! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 14:35:48'!
numerator
	^numerator ! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:34:36'!
addToFraccion: aFraccion 
	 | newNumerator newDenominator |
		
		newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
		newDenominator := denominator * aFraccion denominator.
		
		^ self class with: newNumerator over: newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 15:31:45'!
multiplyFraccion: aFraccion 
	^self class with: (numerator * aFraccion numerator) over: (denominator * aFraccion denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AS 9/12/2022 14:54:50'!
printOn: aStream

	aStream
	print: numerator;
	nextPut: $/;
	print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Pre-Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'as yet unclassified' stamp: 'AS 9/12/2022 12:24:48'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
