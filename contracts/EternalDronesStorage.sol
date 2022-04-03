// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./DataLibrary.sol";


contract EternalDronesStorage {

    using Counters for Counters.Counter; 

    Counters.Counter private _dronesIds;
   


    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    

    // Mapping with relations between dronId and specifications
    mapping(uint256 => DataLibrary.Dron) private dronSpecification;

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    mapping(address => uint256[]) private dronesIdByOwner;



    function getName() public view returns (string memory) {
        return _name;
    }

    function setName(string memory name) public {
        _name = name;
    }

    function getSymbol() public view returns (string memory) {
        return _symbol;
    }

    function setSymbol(string memory symbol) public {
        _symbol = symbol;
    }

    function getBalance(address addressReceived) public view returns (uint256) {
        return _balances[addressReceived];
    }

    function setBalance(address addressReceived, uint256 newBalance) public {
        _balances[addressReceived] = newBalance;
    }

    function getOwner(uint256 tokenId) public view returns (address) {
        return _owners[tokenId];
    }

    function setOwner(address addressReceived, uint256 tokenId) public {
        _owners[tokenId] = addressReceived;
    }

    function getTokenApproval(uint256 tokenId) public view returns (address) {
        return _tokenApprovals[tokenId];
    }

    function setTokenApproval(address to, uint256 tokenId) public {
        _tokenApprovals[tokenId] = to;        
    }

    function getOperatorApproval(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }
    function setOperatorApproval(address owner, address operator, bool approved) public {
         _operatorApprovals[owner][operator] = approved;

    }

    function incrementTokenId() public {
        _dronesIds.increment();
        
    }

    function getCurrentTokenId() public view returns (uint256) {
        return _dronesIds.current();
    }

    function getDronSpecification(uint256 _dronId) public view returns (DataLibrary.Dron memory) {
        return dronSpecification[_dronId];
    }

    function setDronSpecification(uint256 _dronId, DataLibrary.Dron memory _dronSpecification) public {
        dronSpecification[_dronId] = _dronSpecification;
    }

    function getDronesIdByOwner(address _owner) public view returns (uint256[] memory) {
        return dronesIdByOwner[_owner];
    }

    function addDronIdByOwnew(address _owner, uint256 dronId) public {
        dronesIdByOwner[_owner].push(dronId);
    }

   
    

}