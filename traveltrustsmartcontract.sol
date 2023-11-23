// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TravelTrust {
    struct Offer {
        address payable seller;
        string description;
        uint price;
        bool isAvailable;
    }

    mapping(uint => Offer) public offers;
    uint public nextOfferId;

    event OfferCreated(uint id, address seller, string description, uint price);
    event OfferSold(uint id, address buyer, string description, uint price);

    modifier offerExists(uint _id) {
        require(_id < nextOfferId, "Offer does not exist");
        _;
    }

    function createOffer(string memory _description, uint _price) public {
        require(_price > 0, "Price must be greater than 0");
        require(bytes(_description).length <= 256, "Description too long"); // Limit the description length
        offers[nextOfferId] = Offer(payable(msg.sender), _description, _price, true);
        emit OfferCreated(nextOfferId, msg.sender, _description, _price);
        nextOfferId++;
    }

    function buyOffer(uint _id) public payable offerExists(_id) {
        Offer storage offer = offers[_id];
        require(offer.isAvailable, "Offer is not available");
        require(msg.value == offer.price, "Incorrect value sent");

        offer.isAvailable = false;
        offer.seller.transfer(msg.value);
        emit OfferSold(_id, msg.sender, offer.description, offer.price);
    }

    function getOffer(uint _id) public view offerExists(_id) returns (address, string memory, uint, bool) {
        Offer storage offer = offers[_id];
        return (offer.seller, offer.description, offer.price, offer.isAvailable);
    }
}
