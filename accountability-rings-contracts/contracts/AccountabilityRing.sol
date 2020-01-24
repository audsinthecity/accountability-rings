pragma solidity ^0.5.0;

/* 
The AccountabilityRing contract keeps track of the details and state of multiple accountability rings
*/

/*
Import OpenZeppelin Pausable contract, to have an emergency switch for freezing all token transfers in the event
of a large bug.
*/
import '@openzeppelin/contracts/lifecycle/Pausable.sol";

contract AccountabilityRing is Pausable {

  /*
      Define an public owner variable. Set it to the creator of the contract when it is initialized.
      masterPool is where revoked stakes are sent.
      State tracks the state of the ring - proposed when ring is initiated and accepting members, ready when member cap reached,
      failed if members number (6 in this case) not reached in time, active when ring is in operation, complete when finished.
  */
  address payable public owner;
  address payable masterPool;
  enum State { Proposed, Ready, Failed, Active, Complete }

  /*
      Create a variable to keep track of the ring ID numbers.
  */
  uint public ringId;

  /*
      Define a Ring struct.
      The struct has the following fields: name, description of the ring, details about the criteria for proof,
      total number of partipants (set to 6, but potentially extensible later on), stake needed to join in gwei,
      time tracking fields, the state of the ring, and list of users and whether they are currently active or not,
      the current balance of the ring pool.
  */
  struct Ring {
      string name;
      string description;
      string proofCriteria;
      uint totalParticipants;  // set to 6 in this implementation
      uint stake; // in gwei
      uint creationTime;
      uint startTime;
      uint endTime;
      uint currentWeek;
      State state;
      mapping (User => bool) members;
      uint ringPoolBalance;
  }

  /*
      Define a User struct.
      A user has its own wallet address, a mapping of own proofs by week, and a record of valid/not valid votes for other
      user proof submissions
  */
  struct User {
    address user;
    mapping (uint => string) proofs; // own proofs uploaded weekly
    mapping (uint => mapping(address => bool)) votes; // this user's votes on whether other submissions were valid, by week
  }

  /*
      Create a mapping to keep track of the rings.
      The mapping key is an integer ringId, the value is a Ring struct.
  */
    mapping (uint => Ring) rings;

  /* 
      Add event logs
  */
    event LogRingAdded(string name, string description, uint creationTime, uint ringId);
    event LogRingJoined(address member, uint ringId);
    event LogProofUploaded(address member, uint ringId, uint currentWeek);
    event LogVoteRecorded(address evaluator, address evaluated, bool vote);
    event LogRingEnded(address owner, uint balance, uint eventId);
  
  /*
      Create a modifier that throws an error if the msg.sender is not the owner.
  */
    modifier onlyOwner {require(msg.sender == owner); _;}

  constructor() public {
    owner = msg.sender;
    masterPool = msg.sender; // MasterPool initially set to msg.sender but different address can be selected
    ringId = 0;
  }

  /*
      Creates a new ring
    */
    function addRing(string memory _name, string memory _description, string memory _proofCriteria,
    uint _stake) 
        public onlyOwner
        returns (uint)
        {
            require(msg.value >= _stake);  // check to make sure at least the stake amount was sent
            masterPool.transfer(msg.value); // send the stake to the masterPool for safekeeping

            uint myId;
            myId = ringId;

            rings[myId].name = _name;
            rings[myId].description = _description;
            rings[myId].proofCriteria = _proofCriteria;
            rings[myId].totalParticipants = 6; // hard-coded 6 participants per Ring currently
            rings[myId].stake = _stake;
            rings[myId].creationTime = now;
            rings[myId].startTime = now+ 3 days; // if enough members, Ring launches in 3 days time
            rings[myId].endTime = now + 1 days + 8 weeks; // Ring ends 8 weeks after the start time
            rings[myId].currentWeek = 0;
            rings[myId].State = Proposed;
            rings[myId].ringPoolBalance = 0;

            ringId += 1;
            emit LogRingAdded(_name, _description, _url, now, myId);
            return myId;
    }

/*
    readRing() function takes one parameter, the ringId, and returns information about the ring.
*/
    function readRing(uint ringId)
        public view
        returns (string memory name, string memory description, string memory proofCriteria, uint stake, uint startTime,
        uint endTime, uint currentWeek, State state)
        {
            return(rings[ringId].name, rings[ringId].description, rings[ringId].proofCriteria, rings[ringId].stake, rings[ringId].startTime,
            rings[ringId].endTime, rings[ringId].currentWeek, rings[ringId].state);
        }
}

/*
    Joins an existing ring if not already full and within the time parameters
*/
function joinRing(uint ringId) {
  require(rings[ringId].state = State.Proposed); // check that ring has been proposed as is not full
  require(msg.value >= rings[ringId].stake); // check that the stake has been sent

  emit LogRingJoined(msg.sender, ringId);
}
