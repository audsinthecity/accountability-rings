pragma solidity ^0.5.0;

/* 
The AccountabilityRing contract keeps track of the details and state of multiple accountability rings
*/

/*
Import OpenZeppelin Pausable contract, to have an emergency switch for freezing all token transfers in the event
of a large bug.
*/
//import '@openzeppelin/contracts/lifecycle/Pausable.sol";

contract AccountabilityRing {//is Pausable {

  /*
      Define an public owner variable. Set it to the creator of the contract when it is initialized.
      masterPool is where revoked stakes are sent.
      State tracks the state of the ring - proposed when ring is initiated and accepting members, ready when member cap reached,
      failed if members number (6 in this case) not reached in time, active when ring is in operation, complete when finished.
  */
  address payable public owner;
  address payable masterPool;
  enum State { Proposed, Failed, Active, Complete }

  /*
      Create a variable to keep track of the ring ID numbers.
  */
  uint public ringId;

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
      mapping (address => bool) members; // keep track of which users are active in a ring
      uint ringPoolBalance;
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
        public payable onlyOwner
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
            rings[myId].startTime = now + 3 days; // if enough members, Ring launches in 3 days time
            rings[myId].endTime = now + 8 weeks; // Ring ends 8 weeks after the creation time
            rings[myId].currentWeek = 0;
            rings[myId].state = State.Proposed;
            rings[myId].ringPoolBalance = 0;

            ringId += 1;
            emit LogRingAdded(_name, _description, now, myId);
            return myId;
    }

/*
    readRing() function takes one parameter, the ringNum, and returns information about the ring.

    function readRing(uint ringNum)
        public view
        returns (string memory name, string memory description, string memory proofCriteria, uint stake, uint startTime,
        uint endTime, uint currentWeek, State state)
        {
            return(rings[ringNum].name, rings[ringNum].description, rings[ringNum].proofCriteria, rings[ringNum].stake, rings[ringNum].startTime,
            rings[ringNum].endTime, rings[ringNum].currentWeek, rings[ringNum].state);
        }
*/

/*
    Joins an existing ring if not already full and within the time parameters. Make sure proper stake is sent.
    If ring has now reached number of required participants, start ring and change state to Active.
    Update start and end times?
*/
    function joinRing(uint ringId) public payable {
        //require(rings[ringId].state = State.Proposed); // check that ring has been proposed as is not full
        require(msg.value >= rings[ringId].stake); // check that the stake has been sent

        emit LogRingJoined(msg.sender, ringId);
    }

/* 
    Allows user to upload weekly proof. Check for time to ensure doing it by the deadline.

    function uploadProof()

*/

/*
    Allows user to vote on other members' proof. Check for time to ensure doing it by the deadline.

    function vote()
*/

/*
    How to check every week if proof has been uploaded and votes made? Ethereum alarm clock needed?
    Anyone who hasn't submitted or voted on time becomes deactivated and their stake is sent to the master pool.
    In the event of a tie in voting, the default outcome is proof is valid.
*/

/* 8 weeks after the launch of a ring, the ring is completed. Stakes for any remaining active members are returned
    and the ring pool is divided amongst the remaining members less a 2% vig. If there are no remaining members,
    all stakes are sent and retained by the master pool.
    Can fix the alarm clock issue by requiring that the ring initiator must end the pool.
*/

}
