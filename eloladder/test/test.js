var Eloladder = artifacts.require("./Eloladder.sol");

contract('Eloladder',function(accounts) {
    it("call create player", async function() {
        var ladder = await Eloladder.deployed();
        await ladder.addPlayer.call(accounts[0],'John', 1000);
        //console.log(index);
        //assert.isAbove(index, 0, "error addPlayer failed!!")
        var count = await ladder.getPlayerCount();
        console.log("count: " + count)
    });

    it("call get player", async function() {
        var ladder = await Eloladder.deployed();
        var result = (await ladder.getPlayer.call(accounts[0]));
        console.log(result);
        assert.equal(result[0], 1000, "error addPlayer failed!!")
        assert.equal(result[1], 'John', "error addPlayer failed!!")
        assert.equal(result[2], 0, "error addPlayer failed!!")
    });

});