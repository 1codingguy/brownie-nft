from brownie import AdvancedCollectible, accounts, config, interface, network

def fund_advanced_collectible(nft_contract):
  # fund from this address
  dev = accounts.add(config['wallets']['from_key'])
  # the 1st `interface` is imported from Brownie
  # LinkTokenInterface refers to the file of the same name under the interface folder
  # link_token is the address, wrapped inside the LinkTokenInterface() to get the ABI
  link_token = interface.LinkTokenInterface(config['networks'][network.show_active()]['link_token'])
  # transfer 0.1 Link (10**17) from "dev" to "nft_contract"
  link_token.transfer(nft_contract, 10**16, {"from": dev})