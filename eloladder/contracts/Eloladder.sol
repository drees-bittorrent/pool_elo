pragma solidity ^0.4.0;

contract Eloladder {

    // players...will be mapped to an address
    struct Player {
        uint score;
        bytes32 name;
    }

    address public director;
    uint K = 32;

    mapping(address => Player) public players;

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

    function addPlayer(address player, bytes32 name, uint initialScore) public returns (bytes32) {
        require(
            msg.sender == director,
            "Only director can add a person."
        );
        players[player].score = initialScore;
        players[player].name = name;
        return "player added";
    }

    function recordWin(address winner, address loser) public {

        uint expected = expectation(players[winner].score, players[loser].score);
        uint adj = adjustment(K, 1, expected);
        players[winner].score = players[winner].score + adj;
        players[loser].score = players[loser].score - adj;

    }
}
