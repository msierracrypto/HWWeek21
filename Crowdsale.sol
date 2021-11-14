pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
 constructor(uint rate, address payable wallet, PupperCoin token, uint goal, uint open, uint close)
 
        Crowdsale(rate, wallet, token)
        
        CappedCrowdsale(goal)
        
        TimedCrowdsale(open, close)
        
        RefundableCrowdsale(goal)
        
        public
    {
        
    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;

    constructor(string memory name, string memory symbol, address payable wallet, uint goal)
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        PupperCoin puppercoin_token = new PupperCoin(name, symbol, 0);
        
        token_address = address(puppercoin_token);

        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        uint rate = 1;
        
        PupperCoinSale puppertoken_sale = new PupperCoinSale(rate, wallet, puppercoin_token, goal, now, now + 24 weeks);
            
        token_sale_address = address(puppertoken_sale);
            
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        puppercoin_token.addMinter(token_sale_address);
        puppercoin_token.renounceMinter();
    }
}

