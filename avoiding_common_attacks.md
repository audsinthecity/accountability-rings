# Avoiding Common Attacks

## Re-entrancy Attacks
Use the withdrawal design pattern through the use of OpenZeppelin's [PullPayment.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/payment/PullPayment.sol)
contract. OpenZeppelin's contracts have been battle tested and generally internal contract state changes are handles before
calling external contracts.

## Timestamp Dependence
This dapp does have a timestamp dependence in that time needs to be tracked. However, the 30 second miner manipulation window
of ```now``` should not really matter since submissions are sent only once a week and then there is 2 days of time for members
to submit their votes. However, using the autoexpiry design pattern to protect against this. **update**

## Denial of Service
This problem is avoidable by using the withdrawal pattern, which is implemented using OpenZeppelin's
[PullPayment.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/payment/PullPayment.sol)
contract.

## Denial of Service by Block Gas Limit (startGas)
If a smart contract reaches a state where a transaction requires more than 10,000,000 gas to execute, the transaction
will never fully execute since it reaches the block gas limit before finishing. This becomes possible if a contract
loops over an array of undetermined size. Since the number of members per ring is limited to 6 and the number of weeks is
limited to 8, there is no array of undetermined size. This may change in the future if the dapp is extended to accommodate
more users, more weeks, or if the time period is shortened.
