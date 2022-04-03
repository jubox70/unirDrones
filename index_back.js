
const crypto = require('crypto');
const fs = require('fs');
const Web3 = require('web3');
const EthereumTx = require('ethereumjs-tx').Transaction;

llamadaEjemplo();

function llamadaEjemplo() {

    var provider = 'http://127.0.0.1:7545';
    
    var web3Provider = new Web3.providers.HttpProvider(provider);
    var web3 = new Web3(web3Provider);

    //var contractProxy = new web3.eth.Contract(abiFacturasHash,"0xf5C9A19360c55742115156Fce48Ca931fda4FBeb" );
    

    var addressPeticion = "0x8d087f67c606EDE44834c3f3907d1A34f4f1688C"; 
    var privateAddressPeticion = new Buffer.from("4172bd0d04bb34f704c80c8daa2380731cb7db94f57ced8909e8f4665159e51a", "hex");

    //console.log(JSON.parse(fs.readFileSync("DronesERC721.json")))

    //var jsonFile = "DronesERC721.json";
    //var parsed = JSON.parse(fs.readFileSync(jsonFile));
    var parsed = JSON.parse(fs.readFileSync("DronesERC721.json"))
    var abiDronesERC721 = parsed.abi;

    var contractDronesERC721 = new web3.eth.Contract(abiDronesERC721,"0x5Fc5C2dF804bc384996a35FcD773e27593a418ea");



    /*contractDronesERC721.methods.balanceOf(addressPeticion).send({
        value: 0,
        gasLimit: web3.utils.toHex(200000),
        gasPrice: web3.utils.toHex(7499999739),
        from: '0x8d087f67c606EDE44834c3f3907d1A34f4f1688C'
    }).then((result) => {
        console.log("resultado balance CONTRATO VENTA ",result);
    });*/

    const dataSend = contractDronesERC721.methods.balanceOf(addressPeticion);

    web3.eth.getTransactionCount(addressPeticion, (err, txCount) => {
        console.log("Numero transaccion: " + txCount);            
        console.log("cadenaaaaaa:: " + web3.utils.toHex(2020));
        
        let rawTx = {
            nonce: web3.utils.toHex(txCount),
            /*gasPrice: web3.utils.toHex(web3.utils.toWei("2", "gwei")),
            gasLimit: web3.utils.toHex(81000),*/
            //gasLimit: web3.utils.toHex(42000),
            gasLimit: web3.utils.toHex(200000),                
            gasPrice: web3.utils.toHex(7499999739),
            // Para alastria
            gasPrice: web3.utils.toHex(0),
            /*gasPrice: web3.utils.toHex(300000000000),*/                
            from: addressPeticion,
            to: /*addressContract*/ "0x5Fc5C2dF804bc384996a35FcD773e27593a418ea", 
            //value: web3.utils.toHex(web3.utils.toWei('0', 'ether')),
            data: dataSend.encodeABI()                
        }

        // Para ropsten hace falta indicar la cadena, para besu o localhost, no
        //const tx = new EthereumTx(rawTx, {'chain':'ropsten'});
        // Para chains custom
        const tx = new EthereumTx(rawTx/*, { common: "5777" }*/);
        console.log("Chain id: " + tx.getChainId());
        
        tx.sign(privateAddressPeticion);

        console.log("firmado");
        
        const serializedTx = tx.serialize();
        const raw = '0x' + serializedTx.toString('hex');

        // Broadcast the transaction
        const transaction = web3.eth.sendSignedTransaction(raw, (err, tx) => {
            console.log("transaccion:: " + tx);
            console.log("error transac:: " + err);
        });

        /*const transaction = web3.eth.sendSignedTransaction(raw);
        console.log(JSON.stringify(transaction, null, 4));*/
    });
    
}