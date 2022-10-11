!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/6/2022 21:44:14'!
test01EmptyPortfolioHasZeroBalance

	self assert: 0 equals: Portfolio new balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/6/2022 21:45:01'!
test02PortfolioHasAddedAccountsBalance

	| account portfolio |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/6/2022 21:46:50'!
test03PortfolioHasAddedPortfoliosBalance

	| account portfolio1 portfolio2|
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio2 addAccount: account.
	portfolio1 addPortfolio: portfolio2.
	
	self assert: portfolio2 balance equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:08:12'!
test04EmptyPortfolioHasNoRegisteredTransactions

	| account portfolio deposit |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:13:30'!
test05PortfolioHasAddedAccountsTransactionRegistered

	| account portfolio deposit |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	deposit := Deposit register: 100 on: account.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:15:47'!
test06PortfolioHasAddedPortfoliosTransactionRegistered

	| account portfolio1 portfolio2 deposit |
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 addAccount: account.
	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:37:12'!
test07CanAskPortfolioForAddedAccountsTransactions

	| account portfolio deposit withdraw|
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 30 on: account.
	portfolio addAccount: account.
	
	self assert: (Set with: deposit with: withdraw) equals: portfolio transactions asSet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AS 10/11/2022 16:41:26'!
test08CanAskPortfolioForAddedPortfoliosTransactions

	| account portfolio1 portfolio2 deposit withdraw |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 30 on: account.
	portfolio2 addAccount: account.
	portfolio1 addPortfolio: portfolio2.
	
	self assert: (Set with: deposit with: withdraw) equals: portfolio1 transactions asSet.! !


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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance - private' stamp: 'AS 10/6/2022 21:50:25'!
accountsBalance
	^accounts sum: [:account | account balance] ifEmpty: [^0]! !

!Portfolio methodsFor: 'balance - private' stamp: 'AS 10/6/2022 21:50:45'!
portfoliosBalance
	^portfolios sum: [:portfolio | portfolio balance] ifEmpty: [^0]! !


!Portfolio methodsFor: 'balance' stamp: 'AS 10/6/2022 21:50:57'!
balance
	^self accountsBalance + self portfoliosBalance ! !


!Portfolio methodsFor: 'adding' stamp: 'AS 10/6/2022 21:33:25'!
addAccount: anAccount 
	accounts add: anAccount.! !

!Portfolio methodsFor: 'adding' stamp: 'AS 10/6/2022 21:47:09'!
addPortfolio: aPortfolio 
	portfolios add: aPortfolio .! !

!Portfolio methodsFor: 'adding' stamp: 'AS 10/6/2022 21:47:27'!
initialize
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'AS 10/11/2022 16:16:23'!
hasRegistered: anAccountTransaction
	^(accounts anySatisfy: 	[:account | account hasRegistered: anAccountTransaction]) or: [portfolios anySatisfy: 	[:account | account hasRegistered: anAccountTransaction]].! !

!Portfolio methodsFor: 'transactions' stamp: 'AS 10/11/2022 16:41:02'!
transactions
	^portfolios inject: (accounts inject: OrderedCollection new into: [:portfolioTransactions :account | portfolioTransactions addAll: account transactions])
			into: [:portfolioTransactions :portfolio | portfolioTransactions addAll: portfolio transactions].! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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
