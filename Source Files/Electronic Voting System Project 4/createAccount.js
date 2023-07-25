const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545'); // connect to the local RPC node

// Generate a new account
const account = web3.eth.accounts.create();

console.log('New account created!');
console.log('Address:', account.address);
console.log('Private key:', account.privateKey);
