var Eloladder = artifacts.require("./Eloladder.sol");

contract('Eloladder',function(accounts) {
    it("call create player", async function() {
        var ladder = await Eloladder.deployed();
        var index = (await ladder.addPlayer.call(accounts[0],'John', 1000));
        console.log(index);
        assert.isAbove(index, 0, "error addPlayer failed!!")
    });

    it("call get player", async function() {
        var ladder = await Eloladder.deployed();
        var result = (await ladder.getPlayer.call(accounts[0]));
        console.log(result);
        assert.isAbove(result, 0, "error addPlayer failed!!")
    });

});