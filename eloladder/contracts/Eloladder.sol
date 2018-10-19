pragma solidity ^0.4.0;

contract Eloladder {

    // players...will be mapped to an address
    struct Player {
        uint score;
        string name;
        uint index;
    }

    address public director;
    uint K = 32;

    mapping(address => Player) public playerStructs;
    address[] private playerIndex;

    /// Create a new ladder.
    constructor() public {
        director = msg.sender;
    }

    function expectation(uint winner, uint loser) internal pure returns (uint) {
        return 1/(1 + 10**(-(winner-loser)/400));
    }

    function adjustment(uint k, uint outcome, uint expected) internal pure returns (uint) {
        return k*(outcome - expected);
    }

    function addPlayer(address playerAddress, string name, uint initialScore) public returns (uint index) {
        require(isPlayer(playerAddress),"player exists");
        
        playerStructs[playerAddress].score = initialScore;
        playerStructs[playerAddress].name = name;
        playerStructs[playerAddress].index = playerIndex.push(playerAddress)-1;
        return playerIndex.length-1;
    }

    function isPlayer(address playerAddress)
        public 
        view
        returns(bool isIndeed) 
    {
        if(playerIndex.length == 0) return false;
        return (playerIndex[playerStructs[playerAddress].index] == playerAddress);
    }

    function getPlayer(address playerAddress) public view returns(uint score, string name, uint index) {
        require(isPlayer(playerAddress),"player exists");
        return (
            playerStructs[playerAddress].score,
            playerStructs[playerAddress].name,
            playerStructs[playerAddress].index);
    }
    
    function getPlayerCount() 
        public
        view
        returns(uint count)
    {
        return playerIndex.length;
    }

    function getUserAtIndex(uint index)
        public
        view
        returns(address playerAddress)
    {
        return playerIndex[index];
    }
    
    function recordWin(address winner, address loser) public {

        uint expected = expectation(playerStructs[winner].score, playerStructs[loser].score);
        uint adj = adjustment(K, 1, expected);
        playerStructs[winner].score = playerStructs[winner].score + adj;
        playerStructs[loser].score = playerStructs[loser].score - adj;

    }
}
