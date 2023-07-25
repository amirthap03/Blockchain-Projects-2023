// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FarmInsurance {
    
    struct InsuranceDetails {
        string farmerName;
        string farmLocation;
        uint insuranceAmount;
        bool isClaimed;
    }
    
    mapping(uint => InsuranceDetails) public insuranceData;
    uint public insuranceCount;
    
    function addInsuranceDetails(string memory _farmerName, string memory _farmLocation, uint _insuranceAmount) public {
        insuranceCount++;
        insuranceData[insuranceCount] = InsuranceDetails(_farmerName, _farmLocation, _insuranceAmount, false);
    }
    
    function getInsuranceDetails(uint _insuranceId) public view returns (string memory, string memory, uint, bool) {
        InsuranceDetails memory insurance = insuranceData[_insuranceId];
        return (insurance.farmerName, insurance.farmLocation, insurance.insuranceAmount, insurance.isClaimed);
    }
    
    function updateClaimStatus(uint _insuranceId, bool _isClaimed) public {
        InsuranceDetails storage insurance = insuranceData[_insuranceId];
        insurance.isClaimed = _isClaimed;
    }
    
}
