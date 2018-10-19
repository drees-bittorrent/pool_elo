var Migrations = artifacts.require("./Migrations.sol");
var Test = artifacts.require("./Eloladder.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Test);
};