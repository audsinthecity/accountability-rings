var AccountabilityRing = artifacts.require("./AccountabilityRing.sol");

module.exports = function(deployer) {
    deployer.deploy(AccountabilityRing);
};