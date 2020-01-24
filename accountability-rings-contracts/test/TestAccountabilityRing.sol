pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/AccountabilityRing.sol";

contract TestAccountabilityRing {
 // The address of the accountability ring contract to be tested
 AccountabilityRing accountabilityring = AccountabilityRing(DeployedAddresses.AccountabilityRing());

 // The information for a sample ring that will be used for testing
 string expectedName = "DailyExercise";
 string expectedDescription = "Excercise at least 30 minutes a day";
 string expectedProofCriteria = "Upload FitBit or Apple Health screenshots";
 uint expectedStake = 100000000; // at time of writing .1 ETH = $16.40 USD
 uint expectedRingId = 0; // first ring created

 //The expected owner of a ring is this contract
 address expectedAddress = address(this);

 //Testing the addRing() function
 function testUserCanAddRing() public {
     uint returnedId = accountabilityring.addRing(expectedName, expectedDescription, expectedProofCriteria, expectedStake);

     Assert.equal(returnedId, expectedRingId, "Adding a ring should match what is returned.");

 }

 //Testing the new ring should have a state of Proposed
 /*
 function testNewRingState() public {
     Assert.equal(rings[returnedId].state, Proposed, "A new ring should be in a Proposed state.");
 }
 */

 //Testing the readRing() function
 function testUserCanReadRing() public {
     Assert.equal(expectedName, "DailyExercise", "Placeholder for now.");
 }



}