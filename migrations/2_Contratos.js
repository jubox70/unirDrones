const eternalDronesStorage = artifacts.require("EternalDronesStorage");
const dronesERC721 = artifacts.require("DronesERC721");
const proxyDrones = artifacts.require("ProxyDrones");

const eternalParcelasStorage = artifacts.require("EternalParcelasStorage");
const parcelasERC721 = artifacts.require("ParcelasERC721");
const proxyParcelas = artifacts.require("ProxyParcelas");

const myTokenERC20 = artifacts.require("MyTokenERC20");

const operacionesDronesParcelas = artifacts.require("OperacionesDronesParcelas");



module.exports = function (deployer) {

  deployer.then(async () => {
    await deployer.deploy(eternalDronesStorage);
    await deployer.deploy(dronesERC721, eternalDronesStorage.address);
    await deployer.deploy(proxyDrones, dronesERC721.address);

    await deployer.deploy(eternalParcelasStorage);
    await deployer.deploy(parcelasERC721, eternalParcelasStorage.address);
    await deployer.deploy(proxyParcelas, parcelasERC721.address);

    await deployer.deploy(myTokenERC20);

    await deployer.deploy(operacionesDronesParcelas, dronesERC721.address, parcelasERC721.address, myTokenERC20.address);


});
  
  /*deployer.deploy(eternalDronesStorage).then(function(){
    console.log("Address eternalDronesStorage: " + eternalDronesStorage.address);
    deployer.deploy(dronesERC721, eternalDronesStorage.address).then(function(){
      console.log("Address dronesERC721: " + dronesERC721.address);
      deployer.deploy(proxyDrones, dronesERC721.address).then(function(){
        console.log("Address proxyDrones: " + proxyDrones.address);
      });
    });

  });*/
};
