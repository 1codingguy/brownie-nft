# Check if the current directory is a git repo

- not sure because there is .gitattributes and .gitignore file
- `git status`
- if the output is like :
  "fatal: Not a git repository (or any of the parent directories): .git"
  Then, the directory is not a git repository.

# .env why need to use `export` in front of the variables?

- https://unix.stackexchange.com/questions/368944/what-is-the-difference-between-env-setenv-export-and-when-to-use
  > "export VARIABLE_NAME='some value' is the way to set an environment variable in any POSIX-compliant shell (sh, dash, bash, ksh, etc.; also zsh). If the variable already has a value, you can use export VARIABLE_NAME to make it an environment variable without changing its value"

# import openzeppelin contract with @syntax with brownie-config.yaml

# parameters passing into the constructor:

- VRFCoordinator
- LinkToken
- keyhash - to check if the number generated is truly random
  Don't really know what they are now

# enum statement does not require a `;` at the end of line

# create something truly random = create real scarcity

# what is a token URI
https://eips.ethereum.org/EIPS/eip-721
- A distinct Uniform Resource Identifier (URI) for a given asset.
- The URI may point to a JSON file that conforms to the "ERC721 Metadata JSON Schema".
  - can be an API call
  - can be an IPFS link
    - that points to a specific json file that contains the metadata, like a link to IPFS asset
  - IPFS is basically a network in a decentralized manner

# ganache-cli is to run test locally before deploying the smart contract onto blockchain

add `dotenv: .env` to `brownie-config.yaml` otherwise python doesn't know where to get the variable of `from_key`

`fund_advanced_collectible()` in `helpful_scripts.py`
- To fund a contract, we need to specify an address to fund from this address
- also need to send a link token 
  - interface is helpful here 
  - whenever interact with smart contract on-chain, we need two things:
  1. the interface or the ABI
    - the interface is a secret way to get ABI
    - ABI defines a way to interact with those contracts
  2. address 


Those function-like-interfaces in `LinkTokenInterface` hows us what we can do with the link token.
e.g. can approve, transfer
need this to interace with chainlink token and transfer and fund our contract 

# Deploying the contract onto Rinkeby Testnet
on cli: `brownie run scripts/advanced_collectible/deploy_advanced.py --network rinkeby`
- note the `--` flag part says to run the script with such parameter instead of the default
- copy the address from "Transaction sent", paste it on Etherscan Rinkeby to see the transaction details
- even the transaction status is "success" Etherscan, cli gives me this: "ValueError: Gas estimation failed: 'invalid opcode: INVALID'. This transaction will likely revert. If you wish to broadcast, you must set the gas limit manually."
- not sure what it means at the moment, but it has something to do with the funding part
- because the transaction that was successful was the successful deployment part, but the funding part failed because of gas problem, and I can see on Etherscan that the contract is not funded
- Turned out because it is funding with "Link", and I didn't have any "Link" in my account. Followed the instruction from "update" part of the video, added a Link token account and request some test Link token from Chainlink.

# summary up to this point:
- A smart contract is deployed on the Rinkeby test net
- The smart contract is funded with Link Token 

# Next: interact with the deployed contract
call the functions defined: createCollectible, fulfil it and create the actual collectible with the new tokenId, and then we also need to set the tokenURI, we need to store the data in some places like IPFS.

The last successful deployment and funded contract:
Transaction sent: 0x802b4bf5b52b7e6e415aac6a9638ef86dd2beada0944c1db265522b1a51cf87a
  Gas price: 1.000000011 gwei   Gas limit: 2569673   Nonce: 14
  AdvancedCollectible.constructor confirmed   Block: 10091755   Gas used: 2336067 (90.91%)
  AdvancedCollectible deployed at: 0x8F4593C6E46AB1949BA4F771927aEE8eB1306ab5

Transaction sent: 0x032c06c53ccb7d3e419b30e642f99c0904f2391d7bafd165af0b627d4b833afe
  Gas price: 1.000000011 gwei   Gas limit: 56978   Nonce: 15
  LinkTokenInterface.transfer confirmed   Block: 10091756   Gas used: 51799 (90.91%)

- In `Build` --> `deployments`, there are four json files, the file names are the address of the deployment?
- In the example above: AdvancedCollectible deployed at: 0x8F4593C6E46AB1949BA4F771927aEE8eB1306ab5, and there's one json file with the same address.

