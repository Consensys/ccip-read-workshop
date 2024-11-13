# ccip-read-workshop

Simple example to fetch data from the Verax Registry on Linea using ccip-read

## Links of interest

- Linea ccip-read doc: https://docs.linea.build/developers/tooling/cross-chain/ccip-read-gateway
- Linea ENS repo: https://github.com/Consensys/linea-ens
- NFT Resolver repo: https://github.com/Consensys/nft-resolver

## CCIP Read flow on Linea

![alt text](./media/LineaENSCCIPRead.png?raw=true)

## Quick start

Copy the `.env.example` file to `.env` and set the `DEPLOYER_PRIVATE_KEY`.  
Optionally, set the `ETHERSCAN_API_KEY` if you want to verify the contracts on etherscan.

```bash
npm install
npx hardhat compile
npx hardhat ignition deploy ignition/modules/VeraxFetcher.ts --network sepolia
```

You should see the following output:

```
Deployed Addresses

VeraxFetcherModule#VeraxFetcher - 0xd25Cc85a1c87CeB1553e823e46e2890d0a70a33C
```

If you want to verify the contract on etherscan, you can use the following command:

```bash
npx hardhat verify --network sepolia [DEPLOYED_ADDRESS] 0x17289b2e80DcaB38249adb5a2Bd1a0cAF12361A0 0xDaf3C3632327343f7df0Baad2dc9144fa4e1001F
```

Copy the contract address as this will be the contract that you'll call from the UI to start the ccip-read flow.

Open the `ui/demo.html` file in your browser and set the `Verax Fetcher Contract Address` to the address you copied in the previous step.  
You can also change the `Attestation ID` to the one you want to fetch.

When you click on the `Get attestation` button, the ccip-read flow will be triggered and if the attestation exists in the Verax Registry, its id will be displayed, otherwise an error will be shown.

## Get the storage slot index of the attestation

For this example, the storage slot queried is already known:  
`uint256 constant ATTESTATIONS_SLOT = 102;`

To write your own fetcher contract that answers to your needs, you can use the [hardhat-storage-layout](https://www.npmjs.com/package/hardhat-storage-layout) plugin to have a list of the storage slots for a given contract.  
Example for the Verax Registry contract:

```bash
cd contracts/L2
npx hardhat check
```
