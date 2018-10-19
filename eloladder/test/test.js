var Eloladder = artifacts.require("./Eloladder.sol");

contract('Eloladder',function() {
    it("call create player", function() {
        Eloladder.deployed().then(function(instance){
            return instance.call('addPlayer');
        }).then(function(result) {
            assert.equal("player added", result[0], "error addPlayer failed!!")
        });
    });
});