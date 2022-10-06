!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:15:17'!
test01NoEnviarNingunComandoNoDeberiAfectarElPosicionamientoDelMarsRover

	|marsRover|
	
	marsRover := MarsRover posicionInicial: 1@1 mirandoHacia: Sur new.
	
	marsRover secuenciaDeComandosARealizar: ''.
	
	self assert: marsRover position equals: 1@1! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:15:11'!
test02EnviarUnComandoDeMoverHaciaAdelanteConElCabezalHaciaElSurDeberiaMoverElMarsRoverHaciaAdelanteMirandoAlSur

	|marsRover|
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Sur new.
	
	marsRover secuenciaDeComandosARealizar: 'F'.
	
	self assert: marsRover position equals: 2@1! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:15:24'!
test03EnviarUnComandoDeMoverHaciaAdelanteConElCabezalHaciaElNorteDeberiaMoverElMarsRoverHaciaAdelanteMirandoAlNorte

	|marsRover|
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Norte new.
	
	marsRover secuenciaDeComandosARealizar: 'F'.
	
	self assert: marsRover position equals: 2@3.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:15:38'!
test04EnviarUnComandoDeMoverHaciaAdelanteDeberiaMoverElMarsRoverCorrectamente

	|marsRover|
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Este new.
	marsRover secuenciaDeComandosARealizar:'F'.
	self assert: marsRover position equals: 3@2.
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Oeste new.
	marsRover secuenciaDeComandosARealizar: 'F'.
	self assert: marsRover position equals: 1@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:16:08'!
test05EnviarUnComandoDeMoverHaciaAtrasDeberiaMoverElMarsRoverCorrectamente

	|marsRover|

	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Norte new.
	marsRover secuenciaDeComandosARealizar: 'B'.
	self assert: marsRover position equals: 2@1.

	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Sur new.
	marsRover secuenciaDeComandosARealizar: 'B'.
	self assert: marsRover position equals: 2@3.
		
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Este new.
	marsRover secuenciaDeComandosARealizar: 'B'.
	self assert: marsRover position equals: 1@2.
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Oeste new.
	marsRover secuenciaDeComandosARealizar: 'B'.
	self assert: marsRover position equals: 3@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:16:36'!
test06EnviarMasDeUnComandoDeMovimientoDeberiaMoverAlMarsRoverCorrectamente

	|marsRover|

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Norte new.
	marsRover secuenciaDeComandosARealizar: 'BB'.
	self assert: marsRover position equals: 3@1.

	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Sur new.
	marsRover secuenciaDeComandosARealizar:  'BB'.
	self assert: marsRover position equals: 2@4.
		
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Este new.
	marsRover secuenciaDeComandosARealizar: 'BF'.
	self assert: marsRover position equals: 2@2.
	
	marsRover := MarsRover posicionInicial: 2@2 mirandoHacia: Oeste new.
	marsRover secuenciaDeComandosARealizar: 'FB'.
	self assert: marsRover position equals: 2@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:24:46'!
test07ElMarsRoverDeberiaMoverElCabezalEnSentidoHorarioCuandoLeLlegaUnComandoR

	|marsRover|

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Norte new.
	marsRover secuenciaDeComandosARealizar: 'R'.
	self assert: marsRover direccionDelCabezal equals: Este.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Este new.
	marsRover secuenciaDeComandosARealizar: 'R'.
	self assert: marsRover direccionDelCabezal equals: Sur.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Sur new.
	marsRover secuenciaDeComandosARealizar: 'R'.
	self assert: marsRover direccionDelCabezal equals: Oeste.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Oeste new.
	marsRover secuenciaDeComandosARealizar: 'R'.
	self assert: marsRover direccionDelCabezal equals: Norte.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:26:17'!
test08ElMarsRoverDeberiaMoverElCabezalEnSentidoAntihorarioCuandoLeLlegaUnComandoL

	|marsRover|

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Norte new.
	marsRover secuenciaDeComandosARealizar: 'L'.
	self assert: marsRover direccionDelCabezal equals: Oeste.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Este new.
	marsRover secuenciaDeComandosARealizar: 'L'.
	self assert: marsRover direccionDelCabezal equals: Norte.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Sur new.
	marsRover secuenciaDeComandosARealizar: 'L'.
	self assert: marsRover direccionDelCabezal equals: Este.

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Oeste new.
	marsRover secuenciaDeComandosARealizar: 'L'.
	self assert: marsRover direccionDelCabezal equals: Sur.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:34:36'!
test09ConCualquierComandoQueNoSeaBFRLNoDeberiaFuncionar

	|marsRover|

	marsRover := MarsRover posicionInicial: 3@3 mirandoHacia: Norte new.
	self should:[ 	marsRover secuenciaDeComandosARealizar: 'LRDDQ']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: MarsRover comandoInvalidoDescripcionDeError].

	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'puntoInicial cabezal position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FA 10/2/2022 12:23:39'!
initializePosicionInicial: unPuntoInicial mirandoHacia: unPuntoCardinal 
	position := unPuntoInicial.
	cabezal := unPuntoCardinal.
	! !


!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:22:15'!
apuntaHaciaElEste
	cabezal := Este new.
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:22:11'!
apuntaHaciaElNorte
	cabezal := Norte new.
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:22:22'!
apuntaHaciaElOeste
	cabezal := Oeste new.
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:22:03'!
apuntaHaciaElSur
	cabezal := Sur new.
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:13:51'!
moverRobotHaciaAbajo
	position := position x @ (position y - 1).
! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:14:13'!
moverRobotHaciaArriba
	position := position x @ (position y + 1).
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:14:32'!
moverRobotHaciaLaDerecha
	position := (position x + 1) @ position y.
			! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:14:57'!
moverRobotHaciaLaIzquierda
	position := (position x - 1) @ position y	.! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 17:44:55'!
realizarComando: unComando			
	(unComando  = $F) ifTrue: [cabezal manipulaMovimientoDelRoverCuandoAvanza: self].
	(unComando  = $B) ifTrue: [cabezal manipulaMovimientoDelRoverCuandoRetrocede: self].							
	(unComando  = $R) ifTrue: [cabezal manipuladorDePuntoCardinalCuandoGiraALaDerecha: self].
	(unComando  = $L) ifTrue: [cabezal manipuladorDePuntoCardinalCuandoGiraALaIzquierda: self].
	((unComando = $F) or: (unComando = $R) or: (unComando = $B) or: (unComando = $L)) ifFalse: 
					[^self error: self class comandoInvalidoDescripcionDeError]
	! !

!MarsRover methodsFor: 'commands' stamp: 'FA 10/2/2022 16:45:06'!
secuenciaDeComandosARealizar: comandosARealizar
	(comandosARealizar size = 0) ifTrue:[^self].
	comandosARealizar do: [:unComando | self realizarComando: unComando ].
! !


!MarsRover methodsFor: 'position' stamp: 'FA 10/2/2022 12:04:52'!
position
	^position! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:24:22'!
direccionDelCabezal
	^cabezal class.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FA 10/2/2022 17:35:13'!
comandoInvalidoDescripcionDeError
	^'Se a ingresado un comando invalido'.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'FA 10/2/2022 11:38:47'!
posicionInicial: unPuntoInicial mirandoHacia: unPuntoCardinal 
	^self new initializePosicionInicial: unPuntoInicial mirandoHacia: unPuntoCardinal! !


!classDefinition: #PuntosCardinales category: 'MarsRover'!
Object subclass: #PuntosCardinales
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #Este category: 'MarsRover'!
PuntosCardinales subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Este methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:06:04'!
manipulaMovimientoDelRoverCuandoAvanza: unMarsRover
	^unMarsRover moverRobotHaciaLaDerecha.
						! !

!Este methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:08:46'!
manipulaMovimientoDelRoverCuandoRetrocede: unMarsRover
	^unMarsRover  moverRobotHaciaLaIzquierda
! !

!Este methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:20:00'!
manipuladorDePuntoCardinalCuandoGiraALaDerecha: unMarsRover

	unMarsRover apuntaHaciaElSur.
! !

!Este methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:27:12'!
manipuladorDePuntoCardinalCuandoGiraALaIzquierda: unMarsRover

	unMarsRover apuntaHaciaElNorte.
! !


!classDefinition: #Norte category: 'MarsRover'!
PuntosCardinales subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Norte methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:05:44'!
manipulaMovimientoDelRoverCuandoAvanza: unMarsRover

	^ unMarsRover  moverRobotHaciaArriba
						! !

!Norte methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:09:59'!
manipulaMovimientoDelRoverCuandoRetrocede: unMarsRover

	^unMarsRover moverRobotHaciaAbajo.


! !

!Norte methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:21:06'!
manipuladorDePuntoCardinalCuandoGiraALaDerecha: unMarsRover

	unMarsRover apuntaHaciaElEste.
! !

!Norte methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:27:26'!
manipuladorDePuntoCardinalCuandoGiraALaIzquierda: unMarsRover

	unMarsRover apuntaHaciaElOeste.
! !


!classDefinition: #Oeste category: 'MarsRover'!
PuntosCardinales subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:06:59'!
manipulaMovimientoDelRoverCuandoAvanza: unMarsRover

	^ unMarsRover moverRobotHaciaLaIzquierda
! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:10:35'!
manipulaMovimientoDelRoverCuandoRetrocede: unMarsRover

	^unMarsRover moverRobotHaciaLaDerecha.
! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:21:25'!
manipuladorDePuntoCardinalCuandoGiraALaDerecha: unMarsRover

	unMarsRover apuntaHaciaElNorte.
	! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:27:38'!
manipuladorDePuntoCardinalCuandoGiraALaIzquierda: unMarsRover

	unMarsRover apuntaHaciaElSur.
	! !


!classDefinition: #Sur category: 'MarsRover'!
PuntosCardinales subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Sur methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:07:42'!
manipulaMovimientoDelRoverCuandoAvanza: unMarsRover

	^ unMarsRover moverRobotHaciaAbajo
						! !

!Sur methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:11:06'!
manipulaMovimientoDelRoverCuandoRetrocede: unMarsRover

	^unMarsRover moverRobotHaciaArriba.
! !

!Sur methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:21:41'!
manipuladorDePuntoCardinalCuandoGiraALaDerecha: unMarsRover

	unMarsRover apuntaHaciaElOeste.! !

!Sur methodsFor: 'as yet unclassified' stamp: 'FA 10/2/2022 17:27:53'!
manipuladorDePuntoCardinalCuandoGiraALaIzquierda: unMarsRover

	unMarsRover apuntaHaciaElEste.! !
