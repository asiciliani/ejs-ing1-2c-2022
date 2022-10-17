!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/6/2022 21:44:14'!
test01EmptyPortfolioHasZeroBalance

	self assert: 0 equals: Portfolio new balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:16'!
test02PortfolioHasAddedAccountsBalance

	| account portfolio |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:23'!
test03PortfolioHasAddedPortfoliosBalance

	| account portfolio1 portfolio2|
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	self assert: portfolio2 balance equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:08:12'!
test04EmptyPortfolioHasNoRegisteredTransactions

	| account portfolio deposit |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:29'!
test05PortfolioHasAddedAccountsTransactionRegistered

	| account portfolio deposit |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	deposit := Deposit register: 100 on: account.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:36'!
test06PortfolioHasAddedPortfoliosTransactionRegistered

	| account portfolio1 portfolio2 deposit |
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:40'!
test07CanAskPortfolioForAddedAccountsTransactions

	| account portfolio deposit withdraw|
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 30 on: account.
	portfolio add: account.
	
	self assert: (Set with: deposit with: withdraw) equals: portfolio transactions asSet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 17:00:46'!
test08CanAskPortfolioForAddedPortfoliosTransactions

	| account portfolio1 portfolio2 deposit withdraw |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 30 on: account.
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	self assert: (Set with: deposit with: withdraw) equals: portfolio1 transactions asSet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/13/2022 21:29:45'!
test09CanNotAddToPortfolioSameReceptiveAccountMoreThanOnce

	| account portfolio  |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should:  [portfolio add: account]
		raise:  Error - MessageNotUnderstood
		withMessageText: Portfolio accountAlreadyInPortfolioErrorMessage.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/16/2022 18:17:27'!
test10CanNotAddToPortfolioAReceptiveAccountThatIsAlreadyAddedToPortfolioPortfolioIsAddedTo

	| account portfolio1 portfolio2  |
	
	account := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portfolio1 add: account.
	portfolio2 := Portfolio new.
	portfolio1 add: portfolio2.
	
	self should:  [portfolio2 add: account]
		raise:  Error - MessageNotUnderstood
		withMessageText: Portfolio accountAlreadyInPortfolioErrorMessage.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AS 10/6/2022 21:02:35'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'AS 10/6/2022 21:05:11'!
affectBalance: aBalance 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !



!Deposit methodsFor: 'balance' stamp: 'AS 10/6/2022 21:06:09'!
affectBalance: aBalance 
	 ^aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !



!Withdraw methodsFor: 'balance' stamp: 'AS 10/6/2022 21:07:33'!
affectBalance: aBalance 
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAccount category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAccount methodsFor: 'transactions' stamp: 'AS 10/11/2022 16:57:44'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!FinancialAccount methodsFor: 'transactions' stamp: 'AS 10/11/2022 16:56:31'!
transactions

	self subclassResponsibility.! !


!FinancialAccount methodsFor: 'balance' stamp: 'AS 10/11/2022 16:56:26'!
balance

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #Portfolio
	instanceVariableNames: 'financialAccounts portfoliosIAmAddedTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'AS 10/11/2022 17:01:49'!
balance
	^financialAccounts sum: [:financialAccount | financialAccount balance] ifEmpty: [^0]! !


!Portfolio methodsFor: 'adding' stamp: 'AS 10/16/2022 18:18:28'!
add: aFinancialAccountToBeAdded
	self assertNotDirectlyInPortfolio: aFinancialAccountToBeAdded.
	self assertNotDirectlyInPortfoliosIAmAddedTo: aFinancialAccountToBeAdded.
	financialAccounts add: aFinancialAccountToBeAdded.
	aFinancialAccountToBeAdded isNowAddedTo: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'AS 10/11/2022 17:02:34'!
hasRegistered: aTransaction
	^financialAccounts anySatisfy: 	[:financialAccount | financialAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'AS 10/11/2022 17:03:37'!
transactions
	^financialAccounts inject: OrderedCollection new into: [:transactions :financialAccount | transactions addAll: financialAccount transactions]! !


!Portfolio methodsFor: 'initialization' stamp: 'AS 10/13/2022 21:37:47'!
initialize
	financialAccounts := OrderedCollection new.
	portfoliosIAmAddedTo := OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'AS 10/13/2022 21:09:04'!
assertNotDirectlyInPortfolio: aFinancialAccount

	^ (financialAccounts includes: aFinancialAccount) ifTrue: [self accountAlreadyInPortfolioErrorSignal]! !

!Portfolio methodsFor: 'assertions' stamp: 'AS 10/13/2022 21:58:45'!
assertNotDirectlyInPortfoliosIAmAddedTo: aFinancialAccountToBeAdded

	^ portfoliosIAmAddedTo do: [:portfolio | portfolio assertNotDirectlyInPortfolio: aFinancialAccountToBeAdded]! !

!Portfolio methodsFor: 'assertions' stamp: 'AS 10/13/2022 21:59:56'!
assertNotInPortfoliosIAmAddedTo: aFinancialAccountToBeAdded

	^ portfoliosIAmAddedTo do: [:portfolio | portfolio assertNotDirectlyInPortfoliosIAmAddedTo: aFinancialAccountToBeAdded]! !


!Portfolio methodsFor: 'error signal' stamp: 'AS 10/13/2022 20:49:12'!
accountAlreadyInPortfolioErrorSignal

	^ self error: self class accountAlreadyInPortfolioErrorMessage! !


!Portfolio methodsFor: 'testing' stamp: 'AS 10/13/2022 21:43:50'!
isNowAddedTo: aPortfolio 
	portfoliosIAmAddedTo add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'AS 10/13/2022 20:46:05'!
accountAlreadyInPortfolioErrorMessage
	^'Account already in portfolio!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions portfoliosIAmAddedTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AS 10/13/2022 21:40:37'!
initialize

	transactions := OrderedCollection new.
	portfoliosIAmAddedTo := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AS 10/6/2022 21:16:37'!
balance
	
	^transactions inject: 0 into: [:balance :aTransaction |  (aTransaction affectBalance: balance)].
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'AS 10/13/2022 21:44:07'!
isNowAddedTo: aPortfolio 
	portfoliosIAmAddedTo add: aPortfolio.! !
