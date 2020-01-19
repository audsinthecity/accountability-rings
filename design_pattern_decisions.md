# Design Pattern Decisions

## Circuit Breaker Pattern
An emergency stop is implemented through the OpenZeppelin
[Pausable.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/lifecycle/Pausable.sol)
contract. This is desirable in situations wher there is a live contract where a bug has been detected. Freezing could reduce harm
before a fix is implemented.

## Fail Early and Fail Loud
Use ```require``` to check condition required for execution as early as possible to throw an exception if the condition
is not met. Good practice in order to reduce unecessary code execution in the event that an exception is thrown.

## Restricting Access
State variables private so that other contracts cannot access (however people and computer programs cannot
be prevented from reading the contracts' state). Restrict function access to owners. **update**

## Auto Deprecation
Since this dapp relies on time and the now keyword is subject to manipulation by block miners in a 30-second window, it can
be helpful to use the auto deprecation design pattern. 30 seconds should not matter since submissions and votes are only
broadcast once a week. However this pattern is a useful strategy for closing contracts that should expire after a certain
amount of time. **update**

## Withdrawal Pattern
Seperation of logic between accounting and withdrawal to protect against the re-entrancy and denial of service attacks.
Use the OpenZeppelin [PullPayment.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/payment/PullPayment.sol)
to implement the withdrawal pattern and [PaymentSplitter.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/payment/PaymentSplitter.sol)
to split the payments amongst remaining active members and the admin at the expiry of a Ring.
