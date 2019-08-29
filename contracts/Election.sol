pragma solidity ^0.5.0;

contract Election {

// Model a Candiadte
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

// Read/write Candidates
    mapping(uint => Candidate) public candidates;

// Store accounts that have voted
    mapping(address => bool) public voters;



     // Store Candidates Count
    uint public candidatesCount;

 function addCandidate (string memory _name)  private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Constructor
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");    }

    event votedEvent (
          uint indexed _candidateId
        );
    function vote (uint _candidateId) public {
    // require that they haven't voted before
        require(!voters[msg.sender],
            "Voted Before."
            );

    // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount,
        "Candidate Id not valid "
        );

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

         // trigger voted event
        emit votedEvent(_candidateId);
    }
}