//struct, struct
//address
//mapping
//proposal[]
//constructor
//for loop
//function
//function
//function
//function
//function
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

    struct Voter {
        uint weight;
        bool voted;
        address voted;
        uint vote;
    }

    struct Proposal {
        bytes32;
        uint voteCount;
    }

    address public chairperson;

    mapping (address => voter) voters;

    Proposal[] public proposals;

    constructor(bytes32[]memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for(uint i = 0; i < proposalNames; i++) {
            Proposals.push(proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightToVote(address voter)  external {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        )

        require(
            !voters[voter].voted,
            "The voter already voted."
        )

        require(voters[voter].weight == 0);
        voters[voter].weight =1;
    }

    function delegate(address to)  external {
        voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You have no right to vote.");
        require(!sender.voted, "You have already voted.");
        require(to != msg.sender, "self-delegation is disallowed");

        while (voter[to].delegate != address(0)) {
            to = voters[to].delegate;

            require != msg.sender, "Found loop in delegation.";
        }

        voter storage delegate_ = voters[to];

        require(delegate_.weight >= 1);
        sender.voted = true;
        sender.delegate = to;

        if(delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        }
        else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal)  external {
        voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote.")
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;

        Proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal()  public view
            returns(uint winningProposal_){
        uint winningVoteCount = 0;
        for(uint p = 0; p < proposals.length; p++) {
            if(Proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = Proposals[p].voteCount;
                winningProposal_=p;
            }
        }
    }

    function winnerName()  external view
    returns(bytes32 winnerName_) {
        winnerName_= proposals[winningProposal()].name;
    }
}