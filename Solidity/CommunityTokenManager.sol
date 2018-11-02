pragma solidity ^0.4.23;

//import 'openzeppelin-solidity/contracts/drafts/Counter.sol';
//import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';

import 'github.com/OpenZeppelin/zeppelin-solidity/contracts/drafts/Counter.sol';
import 'github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';

contract CommunityToken is ERC721Full {
    //using Counter for Counter.Index;

    //Counter.Index private tokenId;

    constructor(
        string name,
        string symbol
    )
        ERC721Full(name, symbol)
        public
    {}
    
    function createToken(
        string tokenURI,
        uint256 x
    )
        public
        returns (address)
    {
        _mint(msg.sender, x);
        _setTokenURI(x, tokenURI);

        return address(this);
    }
}




contract CommunityTokenManager {
    address private _owner;
    address [] tokenList;
    uint256 totalTokens;

    constructor() public {
        _owner = msg.sender;
    }

    function createToken(
      string name,
      string symbol,
      uint256 amount
    )
        public
        returns (bool)
    {
        require (msg.sender== _owner);
        
        address token = new CommunityToken(name, symbol);

        CommunityToken t = CommunityToken(token);

         for (uint256 x = 0; x < amount; x++) {
            totalTokens += 1;
        
            address a = t.createToken(toString(address(this)), totalTokens);
            tokenList.push(a);
         }
         
        return true; 
    }
    
    function getTokenList() public view returns (address[]) {
        return tokenList;
    }

    function toString(address x) returns (string) {
      bytes memory b = new bytes(20);
      for (uint i = 0; i < 20; i++)
          b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
      return string(b);
  }
}
