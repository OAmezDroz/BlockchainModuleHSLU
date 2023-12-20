//SPDX-License-Identifier: UNLICENSED
// Start of the contract
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol'

contract TravelTrustBase is Ownable {

    //Variable -Section
    // General variables
    string public name = "Travel Trust Tokens";
    string public symbol = "TTT";
    address public owner;

    // Struct for Hotel Room
    struct HotelRoom {
        uint256 roomId;
        bool isAvailable;
        uint256 price;
    }

    //Contract - Section
    // Mapping to store Hotel Rooms using their unique identifiers
    mapping(uint256 => HotelRoom) public hotelRooms; // --> muss ich noch begreifen.

    // Events for room availability changes and payments
    event RoomAvailabilityChanged(uint256 roomId, bool isAvailable);
    event PaymentReceived(address payer, uint256 roomId, uint256 amount);

    // IAM
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }


    // Function to add a Hotel-Room
    function addHotelRoom(uint256 roomId, uint256 price) external onlyOwner {
        require(!hotelRooms[roomId].isAvailable, "Room already exists");
        hotelRooms[roomId] = HotelRoom(roomId, true, price);
        emit RoomAvailabilityChanged(roomId, true);
    }

    // Function to check the availability of a Hotel-Room
    function checkAvailability(uint256 roomId) external view returns (bool) {
        return hotelRooms[roomId].isAvailable;
    }

    // Function to get the price of a Hotel-Room
    function getRoomPrice(uint256 roomId) external view returns (uint256) {
        require(hotelRooms[roomId].isAvailable, "Room not available");
        return hotelRooms[roomId].price;
    }

    // Function to book a Hotel Room and make a payment
    function bookHotelRoom(uint256 roomId) external payable {
        require(hotelRooms[roomId].isAvailable, "Room not available");
        require(msg.value == hotelRooms[roomId].price, "Incorrect payment amount");

        // Mark the room as unavailable
        hotelRooms[roomId].isAvailable = false;
        emit RoomAvailabilityChanged(roomId, false);

        // Emit an event for payment received
        emit PaymentReceived(msg.sender, roomId, msg.value);
    }

    // Function to withdraw funds from the contract (only owner)
    function withdrawFunds() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

}