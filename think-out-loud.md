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

