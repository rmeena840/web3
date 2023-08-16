const ganache = require('ganache-cli');
const { Web3 } = require('web3');
const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile.ts');
const { assert } = require('console');

let accounts = []

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
})

describe('Inbox contract tests', () => {
    it('should deploy contract', async () => {
        const deployedContract = await new web3.eth.Contract(interface).deploy({ data: bytecode, arguments: ['Ravindra'] }).send({ from: accounts[0], gas: '1000000' })
        assert.ok(deployedContract.options.address)
    })

    it('should get accounts list', () => {
        // assert(accounts).
    })
})
