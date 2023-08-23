const { interface, bytecode } = require('./compile.ts');
const fs = require("fs-extra")
const ethers = require('ethers');

const RPC_URL = 'http://127.0.0.1:8545'

const main = async () => {
    const provider = new ethers.JsonRpcProvider(RPC_URL);
    const wallet = new ethers.Wallet("0x0047f9d986496a7c7b9391d708994e25eb492c28ecf6a6ca93dd536b8c7fd6d9", provider);

    const contractFactory = new ethers.ContractFactory(interface, bytecode, wallet);
    console.log("Deploying...")
    const contract = await contractFactory.deploy("Ravindra");
    const txnReceipt = await contract.waitForDeployment();
    console.log("Deployment txn: ", contract.deploymentTransaction());
    console.log("txn receipt: ", txnReceipt)
    console.log("Contract Deployed:", await contract.getAddress());

    // interact with contract

    // sendting raw txn
    const txn = {
        nonce: await wallet.getNonce(),
        gasPrice: 20000000000,
        gasLimit: 1000000,
        to: null,
        value: 0,
        data: "0x" + bytecode,
        chainId: 1337,
    }
    const sentTxn = await wallet.sendTransaction(txn);
    console.log("signed txn response: ", sentTxn);
}

main()