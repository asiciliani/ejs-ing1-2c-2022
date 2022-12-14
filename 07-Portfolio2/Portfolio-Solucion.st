!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit with: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AS 10/24/2022 15:42:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit with: 100.
	withdraw := Withdraw with: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test01EmptyAccountOnlyHasZeroBalanceInSummaryReport

	| account |
	account := ReceptiveAccount new.
	
	self assert: 'Balance = 0' equals: (SummaryReportGenerator for: account ) make first.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test02AccountSummaryReportHasDeposits

	| account summaryReport |
	account := ReceptiveAccount new.
	Deposit register: 20 on: account.
	
	summaryReport := (SummaryReportGenerator for: account ) make.
	self assert: 'Dep?sito por 20.' equals: summaryReport first.
	self assert: 'Balance = 20' equals: summaryReport second.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test03AccountSummaryReportHasWithdraws

	| account summaryReport |
	account := ReceptiveAccount new.
	Deposit register: 20 on: account.
	Withdraw register: 5 on: account.
	
	summaryReport := (SummaryReportGenerator for: account ) make.
	self assert: 'Dep?sito por 20.' equals: summaryReport first.
	self assert: 'Extracci?n por 5.' equals: summaryReport second.
	self assert: 'Balance = 15' equals: summaryReport third.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test04AccountSummaryReportHasTransferExit

	| account summaryReport |
	account := ReceptiveAccount new.
	Deposit register: 20 on: account.
	Withdraw register: 5 on: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	
	summaryReport := (SummaryReportGenerator for: account ) make.
	self assert: 'Dep?sito por 20.' equals: summaryReport first.
	self assert: 'Extracci?n por 5.' equals: summaryReport second.
	self assert: 'Salida por transferencia de 10.' equals: summaryReport third.
	self assert: 'Balance = 5' equals: summaryReport fourth.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test05AccountSummaryReportHasTransferEntrance

	| account summaryReport |
	account := ReceptiveAccount new.
	Deposit register: 20 on: account.
	Withdraw register: 5 on: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	Transfer for: 27 from: ReceptiveAccount new to: account.
	
	summaryReport := (SummaryReportGenerator for: account ) make.
	self assert: 'Dep?sito por 20.' equals: summaryReport first.
	self assert: 'Extracci?n por 5.' equals: summaryReport second.
	self assert: 'Salida por transferencia de 10.' equals: summaryReport third.
	self assert: 'Entrada por transferencia de 27.' equals: summaryReport fourth.
	self assert: 'Balance = 32' equals: summaryReport fifth.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:42'!
test06TransferNetReportConsidersTransferExit

	| account |
	
	account := ReceptiveAccount new.
	
	Withdraw register: 5 on: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	Transfer for: 7 from: account to: ReceptiveAccount new.
	Deposit register: 20 on: account.
	
	self assert: 'Transfer net = -17.' equals: (TransferNetReportGenerator for: account) make .! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:42'!
test07TransferNetReportConsidersTransferEntrance

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 20 on: account.
	Withdraw register: 5 on: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	Transfer for: 7 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	self assert: 'Transfer net = 13.' equals: (TransferNetReportGenerator for: account) make.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:42'!
test08CanAlsoAskPortfolioForTransferNetReport

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	Deposit register: 20 on: account.
	Withdraw register: 5 on: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	Transfer for: 7 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	self assert: 'Transfer net = 13.' equals: (TransferNetReportGenerator for: portfolio) make.! !

!ReportsTest methodsFor: 'tests' stamp: 'AS 10/24/2022 17:09:30'!
test09CanAskPortfolioWithManyAccountsForSummaryReport

	| account1 account2 portfolio summaryReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	Deposit register: 20 on: account1.
	Deposit register: 5 on: account2.
	
	summaryReport := (SummaryReportGenerator for: portfolio) make.
	
	self assert: 'Dep?sito por 20.' equals: summaryReport first.
	self assert: 'Dep?sito por 5.' equals: summaryReport second.
	self assert: 'Balance = 25' equals: summaryReport third.! !


!classDefinition: #TransfersTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransfersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/20/2022 19:36:06'!
test01BalanceIsAffectedAfterTransfer

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 20 from: account1 to: account2.
	
	self assert: -20 equals: account1 balance.
	self assert: 20 equals: account2 balance.! !

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/20/2022 19:36:15'!
test02CanNotTransferFromAndToSameAccount

	| account1 |
	account1 := ReceptiveAccount new.
	
	self should: [Transfer for: 20 from: account1 to: account1.]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | self assert: 0 equals: account1 balance.
							    self assert: Transfer canNotTransferFromAndToSameAccountErrorMessage equals: anError messageText].! !

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/23/2022 14:11:30'!
test03CanNavigateToAndFromBothTransferLegs

	| account1 account2 transfer |
	account1:= ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 20 from: account1 to: account2.
	
	self assert: transfer equals: (transfer originLeg) associatedTransfer.
	self assert: transfer equals: (transfer destinyLeg) associatedTransfer! !

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/23/2022 14:41:29'!
test04OriginAndDestinyHaveRegisteredWithdrawAndDepositRespectively

	| account1 account2 transfer |
	account1:= ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 20 from: account1 to: account2.
	
	self assert: (account1 hasRegistered: transfer originLeg).
	self assert: (account2 hasRegistered: transfer destinyLeg).! !

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/20/2022 21:54:49'!
test05TransferAmountShouldNotBeZero

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer for: 0 from: account1 to: account2.]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | self assert: 0 equals: account1 balance.
							     self assert: account1 transactions isEmpty.
							     self assert: 0 equals: account2 balance.
							     self assert: account2 transactions isEmpty.
							    self assert: Transfer transferAmountShouldBeStrictlyPositiveErrorMessage equals: anError messageText].! !

!TransfersTest methodsFor: 'tests' stamp: 'AS 10/20/2022 21:55:32'!
test06TransferAmountShouldNotBeNegative

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer for: -1 from: account1 to: account2.]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | self assert: 0 equals: account1 balance.
							     self assert: account1 transactions isEmpty.
							     self assert: 0 equals: account2 balance.
							     self assert: account2 transactions isEmpty.
							    self assert: Transfer transferAmountShouldBeStrictlyPositiveErrorMessage equals: anError messageText].! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'AS 10/24/2022 17:02:13'!
makeReport: aReport 
	accounts do: [:anAccount | anAccount addTransactionsToReport: aReport ].
	aReport addBalance: self balance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AS 10/24/2022 15:42:53'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !



!ReceptiveAccount methodsFor: 'report' stamp: 'AS 10/24/2022 17:02:03'!
addTransactionsToReport: aReportToAddMyTransactionsTo
	transactions do: [ :aTransaction | aTransaction addToReport: aReportToAddMyTransactionsTo] .
! !

!ReceptiveAccount methodsFor: 'report' stamp: 'AS 10/24/2022 17:07:00'!
makeReport: aReport 
	self addTransactionsToReport: aReport .
	aReport addBalance: self balance.
! !


!classDefinition: #AccountReportGenerator category: 'Portfolio-Solucion'!
Object subclass: #AccountReportGenerator
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 17:08:36'!
addBalance: anAccountsBalance 	
	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:16:48'!
addDeposit: aDepositToAddToReport
	
	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:17:10'!
addTransferDeposit: aTransferDepositToAddToReport
	
	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:17:21'!
addTransferWithdraw: aTransferWithdrawToAddToReport
	
	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:17:02'!
addWithdraw: aWithdrawToAddToReport
	
	self subclassResponsibility ! !


!AccountReportGenerator methodsFor: 'initialization' stamp: 'AS 10/24/2022 16:18:57'!
initializeFor: anAccount 
	account := anAccount.! !


!AccountReportGenerator methodsFor: 'evaluating' stamp: 'AS 10/24/2022 16:20:04'!
make
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReportGenerator class' category: 'Portfolio-Solucion'!
AccountReportGenerator class
	instanceVariableNames: ''!

!AccountReportGenerator class methodsFor: 'instance creation' stamp: 'AS 10/24/2022 16:26:25'!
for: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #SummaryReportGenerator category: 'Portfolio-Solucion'!
AccountReportGenerator subclass: #SummaryReportGenerator
	instanceVariableNames: 'summaryReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportGenerator methodsFor: 'initialization' stamp: 'AS 10/24/2022 16:18:28'!
initialize
	summaryReport := OrderedCollection new.! !


!SummaryReportGenerator methodsFor: 'evaluating' stamp: 'AS 10/24/2022 16:54:41'!
make

	account makeReport: self.
	^summaryReport! !


!SummaryReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:57:43'!
addBalance: anAccountsBalance 

	summaryReport addLast: 'Balance = ', anAccountsBalance asString.! !

!SummaryReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:18:02'!
addDeposit: aDepositToAddToReport 
	^summaryReport add: 'Dep?sito por ', aDepositToAddToReport value asString  ,'.'! !

!SummaryReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:18:02'!
addTransferDeposit: aTransferDepositToAddToReport

	summaryReport add: 'Entrada por transferencia de ', aTransferDepositToAddToReport value asString ,'.'! !

!SummaryReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:18:02'!
addTransferWithdraw: aTransferWithdrawToAddToReport
	
	summaryReport add: 'Salida por transferencia de ', aTransferWithdrawToAddToReport value asString ,'.'! !

!SummaryReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:18:02'!
addWithdraw: aWithdrawToAddToReport
	summaryReport add: 'Extracci?n por ', aWithdrawToAddToReport value asString ,'.'! !


!classDefinition: #TransferNetReportGenerator category: 'Portfolio-Solucion'!
AccountReportGenerator subclass: #TransferNetReportGenerator
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReportGenerator methodsFor: 'initialization' stamp: 'AS 10/24/2022 16:18:35'!
initialize
	transferNet := 0.! !


!TransferNetReportGenerator methodsFor: 'evaluating' stamp: 'AS 10/24/2022 16:06:48'!
make
	account makeReport: self.
	
	^'Transfer net = ', transferNet asString, '.'! !


!TransferNetReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:58:03'!
addBalance: anAccountsBalance 
	! !

!TransferNetReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:15:46'!
addDeposit: aDepositToAddToReport
	transferNet := transferNet + (aDepositToAddToReport valueForTransferNet).! !

!TransferNetReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:15:46'!
addTransferDeposit: aTransferDepositToAddToReport
	transferNet := transferNet + (aTransferDepositToAddToReport valueForTransferNet)! !

!TransferNetReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:15:46'!
addTransferWithdraw: aTransferWithdrawToAddToReport
	transferNet := transferNet + (aTransferWithdrawToAddToReport valueForTransferNet).! !

!TransferNetReportGenerator methodsFor: 'add' stamp: 'AS 10/24/2022 16:15:46'!
addWithdraw: aWithdrawToAddToReport
	transferNet := transferNet + (aWithdrawToAddToReport valueForTransferNet).! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'AS 10/23/2022 17:34:54'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 15:31:56'!
addToReport: aReportToAddMeTo 
	self subclassResponsibility .! !

!AccountTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 16:15:46'!
valueForTransferNet

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !



!AccountTransaction methodsFor: 'initialization' stamp: 'AS 10/21/2022 21:49:18'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AS 10/24/2022 15:42:53'!
register: aValueOrATransfer on: account

	| transaction |
	
	transaction := self with: aValueOrATransfer.
	account register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AS 10/24/2022 15:42:53'!
with: aValueOrATransfer

	^ self new initializeFor: aValueOrATransfer ! !


!classDefinition: #RegularTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #RegularTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!RegularTransaction methodsFor: 'balance' stamp: 'AS 10/23/2022 17:35:56'!
affectBalance: aBalance

	self subclassResponsibility ! !

!RegularTransaction methodsFor: 'balance' stamp: 'AS 10/23/2022 17:35:10'!
value

	^value ! !


!RegularTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 15:31:45'!
addToReport: aReportToAddMeTo 
	self subclassResponsibility! !

!RegularTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 16:15:46'!
valueForTransferNet

	^0! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
RegularTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!



!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'AS 10/24/2022 15:30:43'!
addToReport: aReportToAddMeTo 
	aReportToAddMeTo addDeposit: self! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
RegularTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!



!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'AS 10/24/2022 15:19:58'!
addToReport: aReportToAddMeTo 
	aReportToAddMeTo addWithdraw: self.! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'transfer' stamp: 'AS 10/23/2022 14:59:31'!
associatedTransfer
	^transfer! !


!TransferTransaction methodsFor: 'balance' stamp: 'AS 10/23/2022 15:03:52'!
affectBalance: aBalance
	
	self subclassResponsibility ! !


!TransferTransaction methodsFor: 'initialization' stamp: 'AS 10/23/2022 14:59:23'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferTransaction methodsFor: 'value' stamp: 'AS 10/23/2022 14:59:28'!
value

	^transfer value! !


!TransferTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 15:31:33'!
addToReport: aReportToAddMeTo 
	self subclassResponsibility .! !

!TransferTransaction methodsFor: 'report' stamp: 'AS 10/24/2022 16:15:46'!
valueForTransferNet
	
	self subclassResponsibility ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'report' stamp: 'AS 10/24/2022 15:29:08'!
addToReport: aReportToAddMeTo

	aReportToAddMeTo addTransferDeposit: self! !

!TransferDeposit methodsFor: 'report' stamp: 'AS 10/24/2022 16:15:46'!
valueForTransferNet

	^self value! !


!TransferDeposit methodsFor: 'balance' stamp: 'AS 10/23/2022 14:39:37'!
affectBalance: aBalance
	^aBalance + self value ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'AS 10/23/2022 14:40:33'!
affectBalance: aBalance
	
	^aBalance - self value! !


!TransferWithdraw methodsFor: 'report' stamp: 'AS 10/24/2022 15:27:38'!
addToReport: aReportToAddMeTo

	aReportToAddMeTo addTransferWithdraw: self.! !

!TransferWithdraw methodsFor: 'report' stamp: 'AS 10/24/2022 16:15:46'!
valueForTransferNet

	^self value negated ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'transferAmount originLeg destinyLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'instance creation' stamp: 'AS 10/23/2022 14:24:16'!
initializeFor: anAmountToTransfer from: anOriginReceptiveAccount to: aDestinyReceptiveAccount 
	transferAmount := anAmountToTransfer.
	originLeg := TransferWithdraw register: self on: anOriginReceptiveAccount.
	destinyLeg := TransferDeposit register: self on: aDestinyReceptiveAccount.! !

!Transfer methodsFor: 'instance creation' stamp: 'AS 10/23/2022 14:40:22'!
value

	^transferAmount ! !


!Transfer methodsFor: 'legs' stamp: 'AS 10/20/2022 15:45:18'!
destinyLeg
	^destinyLeg! !

!Transfer methodsFor: 'legs' stamp: 'AS 10/20/2022 16:04:29'!
originLeg
	^originLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AS 10/20/2022 21:57:12'!
for: anAmountToTransfer from: anOriginReceptiveAccount to: aDestinyReceptiveAccount

	self assertIsStrictlyPositive: anAmountToTransfer.
	self assertIsNotSameAccount: anOriginReceptiveAccount as: aDestinyReceptiveAccount.
	^self new initializeFor: anAmountToTransfer from: anOriginReceptiveAccount to: aDestinyReceptiveAccount. ! !


!Transfer class methodsFor: 'error message' stamp: 'AS 10/20/2022 16:15:22'!
canNotTransferFromAndToSameAccountErrorMessage
	^'Can not transfer from and to same account!!'! !

!Transfer class methodsFor: 'error message' stamp: 'AS 10/20/2022 21:54:48'!
transferAmountShouldBeStrictlyPositiveErrorMessage
	^'Transfer amount should be strictly positive!!'.! !


!Transfer class methodsFor: 'assertions' stamp: 'AS 10/20/2022 21:56:50'!
assertIsNotNegative: anAmountToTransfer

	^ anAmountToTransfer < 0 ifTrue: [self error: self transferAmountShouldBeStrictlyPositiveErrorMessage]! !

!Transfer class methodsFor: 'assertions' stamp: 'AS 10/20/2022 19:44:10'!
assertIsNotSameAccount: anOriginReceptiveAccount as: aDestinyReceptiveAccount

	^ anOriginReceptiveAccount = aDestinyReceptiveAccount ifTrue: [self error: self canNotTransferFromAndToSameAccountErrorMessage]! !

!Transfer class methodsFor: 'assertions' stamp: 'AS 10/20/2022 21:56:39'!
assertIsNotZero: anAmountToTransfer

	^ anAmountToTransfer = 0 ifTrue: [self error: self transferAmountShouldBeStrictlyPositiveErrorMessage]! !

!Transfer class methodsFor: 'assertions' stamp: 'AS 10/20/2022 21:57:07'!
assertIsStrictlyPositive: anAmountToTransfer

	self assertIsNotZero: anAmountToTransfer.
	self assertIsNotNegative: anAmountToTransfer! !
