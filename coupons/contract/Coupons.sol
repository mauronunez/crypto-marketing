pragma solidity ^0.5.10;

contract Coupons {
    
    event AddCoupon(address indexed beneficiary, uint coupons);
    event ConsumeCoupon(address indexed beneficiary);
    
    modifier OnlyOwner{
        require(msg.sender==contractOwner);
        _;
    }
    

    
    address private contractOwner;
    uint private size;
  
    mapping ( address => uint) public counter;

    constructor(uint _size) public {
        contractOwner = msg.sender;
        size=_size;
    }

    function consumeCoupons() public{
       
        uint current=counter[msg.sender];
        if(current>size){
            counter[msg.sender]=current-size;
            emit ConsumeCoupon(msg.sender);
        }else
        {
            revert();
        }
    }
    
    function addCoupon(address _beneficiary) public OnlyOwner {
        counter[_beneficiary]++;
        emit AddCoupon(_beneficiary, 1);
    }
    
        
    function addCoupons(address _beneficiary, uint coupons) public OnlyOwner {
        counter[_beneficiary]=counter[_beneficiary]+coupons;
        emit AddCoupon(_beneficiary, counter[_beneficiary]);
    }
}
