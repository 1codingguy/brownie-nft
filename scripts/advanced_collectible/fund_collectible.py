from brownie import AdvancedCollectible
from scripts.helpful_scripts import fund_advanced_collectible


def main():
    # the following line is to get the latest AdvancedCollectible
    advanced_collectible = AdvancedCollectible[len(AdvancedCollectible) - 1]
    # to fund the most recent instance of advanced_collectible
    fund_advanced_collectible(advanced_collectible)
