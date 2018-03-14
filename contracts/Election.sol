pragma solidity ^0.4.2;

contract Election {
	
	// Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	// Store Candidates
	// Fetch a Candidate
	mapping( uint => Candidate ) public candidates;

	// Store a Candidates Count
	uint public candidatesCount;

	// Store acconut that have voted
	mapping( address => bool) public voters;

	event votedEvent (
		uint indexed _candidateId
	);

	// Constructor
	function Election () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string _name) private {
		candidatesCount++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote (uint _candidateId) public {

		// Require that they never voted before		
		require(!voters[msg.sender]);

		// Requre a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		// Record that the voter has voted
		voters[msg.sender] = true;

		// Update Canddates' vote count
		candidates[_candidateId].voteCount++;

		votedEvent(_candidateId);
	}
}