// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lotery{
    address payable[] public participants;
    address public manager;

    constructor(){
        manager=msg.sender;
    }
    receive() external payable{
        require(msg.value==1 ether);
        participants.push(payable(msg.sender));
    }
    function getbalance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }
    function random() public view returns(uint){
        require (msg.sender==manager);
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }
    function selectWinner() public{
        require (msg.sender==manager);
        require(participants.length>=3);
        uint r=random();
        address payable Winner;
        uint index=r % participants.length;
        Winner=participants[index];
        Winner.transfer(getbalance());
        participants = new address payable[](0);
    }
}
