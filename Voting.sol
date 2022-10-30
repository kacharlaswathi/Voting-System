pragma solidity ^0.8.3;
contract BallotVoting{
    address public chairPerson;
    struct Voter{
        address add;
        uint weight;
        bool voted;
        address partyVoted;
    }
    struct Party{
        string name;
        address add;
        uint partyVotes;   
    }
    constructor() public{
        chairPerson=msg.sender;
    }
    Voter[] voter;
    Party[] party;
    mapping(address=>Voter) public vote;
    mapping(address=>Party) public member;
    function partyRegistration(string memory name,address add) external{
        Party memory party1=Party(name,msg.sender,0);
        party.push(party1);
        member[msg.sender]=party1;
    }
    
function voterRegistration() external{
    Voter memory voter1=Voter(msg.sender,0,false,address(0));
    voter.push(voter1);
    vote[msg.sender]=voter1;
}


function giveRightToVote(address[] memory voters) public {
for(uint i=0;i<voters.length;i++){
    require(msg.sender==chairPerson,"only chairperson has access to permit voter");
    require(!vote[voters[i]].voted,"voter already voted");
    require(vote[voters[i]].weight==0);
    vote[voters[i]].weight=1;
}
}
function removeRightToVote(address[] memory voters) public{
    for(uint i=0;i<voters.length;i++){
    require(msg.sender==chairPerson,"only chairperson has access to permit voter");
    require(!vote[voters[i]].voted,"voter already voted");
    require(vote[voters[i]].weight==1);
    vote[voters[i]].weight=0;
}
}
function voteForTheParty(address voter,address party) public{
    require(msg.sender==voter,"address should be matched");
    require(vote[voter].weight==1);
    require(!vote[voter].voted,"voter already voted");
    require(member[party].add!=address(0),"party not registered");
    vote[voter].voted=true;
    vote[voter].partyVoted=party;
    member[party].partyVotes+=1;

}
function winningParty() public view returns(address winner){
    uint max=party[0].partyVotes;
    for(uint j=1;j<party.length;j++){
        if(party[j].partyVotes>max){
            max=party[j].partyVotes;
            winner=party[j].add;
        }

    }
}



}
