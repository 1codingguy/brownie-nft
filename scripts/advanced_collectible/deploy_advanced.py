# to deploy the smart contract to the Rineby testnet
# how does brownie know where is `AdvancedCollectible` contract located?
from brownie import AdvancedCollectible, accounts, network, config
from scripts.helpful_scripts import fund_advanced_collectible


def main():
    # deploying to a real chain, need a wallet or an address or a private key
    # and we need to add that to our account
    dev = accounts.add(config["wallets"]["from_key"])  # config() pulls from config file
    print(network.show_active())
    # publish_source means publishing to etherscan or not
    publish_source = False
    # Deploy `AdvancedCollectible` contract to a network of choice - development by default
    # And it's feeding the 3 parameters the contract requires by looking up in config file
    advanced_collectible = AdvancedCollectible.deploy(
        config["networks"][network.show_active()]["vrf_coordinator"],
        config["networks"][network.show_active()]["link_token"],
        config["networks"][network.show_active()]["keyhash"],
        # every time we deploy a smart contract on chain or make a transaction we always need a 'from' object
        # the following line means "we are deploying from this dev account"
        {"from": dev},
        # publish_source verify our etherscan if the etherscan env variable is set
        publish_source=publish_source,
    )
    # to pay for the fee (in Link) when deploy the contract on the blockchain
    fund_advanced_collectible(advanced_collectible)
    return advanced_collectible
