// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AgricultureData {
    
    struct Product {
        string name;
        string origin;
        uint256 quantity;
        uint256 price;
    }
    
    mapping (uint256 => Product) public products;
    uint256 public totalProducts;
    
    function addProduct(string memory _name, string memory _origin, uint256 _quantity, uint256 _price) public returns (uint256) {
        totalProducts++;
        products[totalProducts] = Product(_name, _origin, _quantity, _price);
        return totalProducts;
    }
    
    function getProduct(uint256 _productId) public view returns (string memory, string memory, uint256, uint256) {
        require(_productId > 0 && _productId <= totalProducts, "Invalid product ID");
        Product storage product = products[_productId];
        return (product.name, product.origin, product.quantity, product.price);
    }
    
    function updateProduct(uint256 _productId, string memory _name, string memory _origin, uint256 _quantity, uint256 _price) public {
        require(_productId > 0 && _productId <= totalProducts, "Invalid product ID");
        products[_productId] = Product(_name, _origin, _quantity, _price);
    }
}
