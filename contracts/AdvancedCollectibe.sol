pragma solidity 0.6.6;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@chainlink/contracts/src/v0.6/VRFConsumerBase.sol';

contract AdvancedCollectible is ERC721, VRFConsumerBase {
  bytes32 internal keyHash;
  uint256 public fee;
  uint256 public tokenCounter;

  enum Breed {
    PUG,
    SHIBU_INU,
    ST_BERNARD
  }

  mapping(bytes32 => address) public requestIdToSender;
  mapping(bytes32 => string) public requestIdToTokenURI;
  mapping(uint256 => Breed) public tokenIdToBreed;
  mapping(bytes32 => uint256) public requestIdToTokenId;
  event requestCollectible(bytes32 indexed requestId);

  constructor(
    address _VRFCoordinator, // prove it's a random number
    address _LinkToken,
    bytes32 _keyhash // along with VRFCoordinator, to prove a random number is actually random
  )
    public
    // lines below add the constructors of VRFConsumerBase and ERC721
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721('Doggies', 'DOG') //name, symbol
  {
    keyHash = _keyhash;
    fee = 0.1 * 10**18; // 0.1 LINK
    tokenCounter = 0;
  }

  // a function create collectibles for us,
  // that kicks off a request to the chainlink VRF
  // that returns a random number, to create us an NFT
  function createCollectible(uint256 userProvidedSeed, string memory tokenURI)
    public
    returns (bytes32)
  {
    // kick off randomness request to Chainlink VRF, request is async
    // get a random node from the offchain chainlink oracle,
    // that's going to respond in a 2nd transaction we are going to define below
    // that function is the one going to creata a token ID and everything that we need
    // keyhash verifies if the number is truly random, fee is how much token we are going to send to chainlink oracle
    // when working with chainlink oracle, we are paying a bit of link
    // we want to know the random number we requested is the same random number that associate with the request, when the chainlink node return, it's going to return and sign the random number to the correct call
    bytes32 requestId = requestRandomness(keyHash, fee);
    // when I created the request, the address is associated with me
    requestIdToSender[requestId] = msg.sender;
    // the requestId is associated with the metadata defined at the tokenURI
    // in this example we are setting it to be blank for now.
    requestIdToTokenURI[requestId] = tokenURI;
    // emit is purely for testing
    // emit is closest to Ethereum logging
    // we can't access event on-chain but we can read them from off-chain
    // smart contract can't interact with events, but we can interact with event for testing
    emit requestCollectible(requestId);
  }

  // once the chainlink node responses, we will want to fulfill randomness
  // we kicked off a randomness request, the chainlink nodes responses by calling this fulfillRandomness function
  // does the `randomNumber` here return from the request to Chainlink? Or what is it?
  function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
    internal
    override
  {
    address dogOwner = requestIdToSender[requestId];
    string memory tokenURI = requestIdToTokenURI[requestId];
    // every time we mint a new collectible on our NFT factory contract, we have to give it a token ID, which is the tokenCounter, which keeps track of the number of NFT minted
    uint256 newItemId = tokenCounter;
    // when minting a new token, needs to tell the function who init the minting - dogOwner, and the id of the newly minted token - tokenId
    _safeMint(dogOwner, newItemId);
    _setTokenURI(newItemId, tokenURI);
    Breed breed = Breed(randomNumber % 3);
    tokenIdToBreed[newItemId] = breed;
    requestIdToTokenId[requestId] = newItemId;
    tokenCounter = tokenCounter + 1;
  }

  // set the tokenID to the correct tokenURI
  // since we don't know the breed of the dog before it's created, have to add the breed and metadata in the tokenURL later - after we know what breed it is
  function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
    require(
      // _isApprovedOrOwner() is imported from openzeppelin
      _isApprovedOrOwner(_msgSender(), tokenId),
      'ERC721: transfer call is not owner nor approved'
    );
    _setTokenURI(tokenId, _tokenURI);
  }
}
