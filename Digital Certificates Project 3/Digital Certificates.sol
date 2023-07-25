// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateRegistry {
    
    struct Certificate {
        string name;
        string issuer;
        uint256 issueDate;
        uint256 expirationDate;
        address owner;
    }
    
    mapping(uint256 => Certificate) certificates;
    uint256 public numCertificates;
    
    event CertificateAdded(uint256 indexed id, string name, string issuer, uint256 issueDate, uint256 expirationDate, address owner);
    event CertificateTransferred(uint256 indexed id, address indexed from, address indexed to);
    
    function addCertificate(string memory _name, string memory _issuer, uint256 _issueDate, uint256 _expirationDate, address _owner) public returns (uint256) {
        require(_owner != address(0), "Invalid owner address");
        require(_expirationDate > _issueDate, "Expiration date must be greater than issue date");
        uint256 id = numCertificates++;
        certificates[id] = Certificate(_name, _issuer, _issueDate, _expirationDate, _owner);
        emit CertificateAdded(id, _name, _issuer, _issueDate, _expirationDate, _owner);
        return id;
    }
    
    function transferCertificate(uint256 _id, address _to) public {
        require(_to != address(0), "Invalid recipient address");
        Certificate storage cert = certificates[_id];
        require(msg.sender == cert.owner, "Only certificate owner can transfer");
        cert.owner = _to;
        emit CertificateTransferred(_id, msg.sender, _to);
    }
    
    function getCertificate(uint256 _id) public view returns (string memory, string memory, uint256, uint256, address) {
        Certificate storage cert = certificates[_id];
        return (cert.name, cert.issuer, cert.issueDate, cert.expirationDate, cert.owner);
    }
}
