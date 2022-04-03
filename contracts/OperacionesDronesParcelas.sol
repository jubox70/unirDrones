// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DronesERC721.sol";
import "./ParcelasERC721.sol";
import "./MyTokenERC20.sol";
import "./DataLibrary.sol";



contract OperacionesDronesParcelas {

    MyTokenERC20 myTokenERC20;
    
    DronesERC721 dronesERC721;

    ParcelasERC721 parcelasERC721;

    // Mapping to save for each address (owner of dron) what plot jobs has to do a dron. First 
    // parameter is an address, second parameter is the plot id and third parameter is dron id
    //mapping(address => mapping(uint256 => uint256)) private jobsPending;
    mapping(uint256 => uint256) private jobsPending;
    

    constructor(address _addressDronesERC721, address _addressParcelasERC721, address _myTokenERC20) {

        dronesERC721 = DronesERC721(_addressDronesERC721);
        parcelasERC721 = ParcelasERC721(_addressParcelasERC721);
        myTokenERC20 = MyTokenERC20(_myTokenERC20);

    }


    function contratarDron(uint256 _dronId, uint256 _parcelaId) public payable {

        if (jobsPending[_dronId] != 0) {
            revert("The dron is asigned to another job");
        } 

        if (parcelasERC721.ownerOf(_parcelaId) != msg.sender) { 
            //string memory op = toString(abi.encodePacked(parcelasERC721.ownerOf(_parcelaId)));
            //string memory op2 = toString(abi.encodePacked(msg.sender));
            //string memory op = "Sender should be the owner of the plot. Plot owner: " + addressToString(parcelasERC721.ownerOf(_parcelaId)) + " Sender: " + addressToString(msg.sender);
            //string memory op2 = addressToString(msg.sender);
            
            revert(  string(    abi.encodePacked("Sender should be the owner of the plot. Plot owner: ", addressToString(parcelasERC721.ownerOf(_parcelaId)), " Sender: ", addressToString(msg.sender)    )                       )                     );
            
            //revert( string("Sender should be the owner of the plot. Plot owner: ", bytes(addressToString(parcelasERC721.ownerOf(_parcelaId)), "Sender: ", bytes(addressToString(msg.sender)))) );
        }         

        DataLibrary.Dron memory dronSpecs = dronesERC721.getDronSpecification(_dronId);

        DataLibrary.Parcela memory parcelaSpecs = parcelasERC721.getParcelaSpecification(_parcelaId);

        if (myTokenERC20.balanceOf(msg.sender) < dronSpecs.coste) {
            revert("Dron price is greater than total amount");
        }
        
        // Si la altura minima de la parcela es mayor que la altura maxima del dron, el dron no puede volar, revertimos la operacion. Lo mismo con 
        // el pesticida. Si el pesticida de la parcela no es el mismo que el del dron, revertimos
        if ((parcelaSpecs.alturaMinima > dronSpecs.alturaMaxima) || (parcelaSpecs.pesticidaAceptado != dronSpecs.pesticidaAceptado)) {
            revert("Plot not support dron specifications");
        }

        jobsPending[_dronId] = _parcelaId;
        
        myTokenERC20.transferFrom(msg.sender, dronesERC721.ownerOf(_dronId), dronSpecs.coste);
    }


    function getPendientesDeFumigar(uint256 _dronId) public view returns (uint256) {

        return jobsPending[_dronId];

        
    }
    
    function fumigar(uint256 _dronId, uint256 _parcelaId) public {

        if (dronesERC721.ownerOf(_dronId) != msg.sender) { 
            //string memory op = addressToString(dronesERC721.ownerOf(_dronId));
            //string memory op2 = addressToString(msg.sender);
            //revert("Sender should be the owner of the dron. Dron owner: " + op + " Sender: " + op2);

            revert(  string(    abi.encodePacked("Sender should be the owner of the dron. Dron owner: ", addressToString(dronesERC721.ownerOf(_dronId)), " Sender: ", addressToString(msg.sender)    )                       )                     );
            
        }  
       
        if (jobsPending[_dronId] != _parcelaId) {
            revert("The plot has assigned the job to another dron");
        }

        

        jobsPending[_dronId] = 0;        

        emit Fumigacion(_parcelaId);
    }


    event Fumigacion(uint256 _parcelaId);



    function toString(bytes memory data) public pure returns(string memory) {
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(2 + data.length * 2);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < data.length; i++) {
            str[2+i*2] = alphabet[uint(uint8(data[i] >> 4))];
            str[3+i*2] = alphabet[uint(uint8(data[i] & 0x0f))];
        }
        return string(str);
    }

    function addressToString(address _address) internal pure returns(string memory) {
        bytes32 _bytes = bytes32(uint256(uint160(_address)));
        bytes memory HEX = "0123456789abcdef";
        bytes memory _string = new bytes(42);
        _string[0] = '0';
        _string[1] = 'x';
            for(uint i = 0; i < 20; i++) {
                _string[2+i*2] = HEX[uint8(_bytes[i + 12] >> 4)];
                _string[3+i*2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
            }
        return string(_string);
    }

}