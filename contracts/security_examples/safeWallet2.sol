pragma solidity ^0.4.8;


contract SafeWallet2 {

    mapping(address => uint) balances;
    // one mutex per address
    mapping(address => bool) mutex;

    function UnsafeWallet() payable {
        // when creating the contract, the creator can send money along with it, this will initialize his balance
        balances[msg.sender] = msg.value;
    }
    // Withdraw your balance.
    // we implement a Mutex to stop recursive calls
    function withdraw() returns(bool){
        if(mutex[address] == true) {
            throw;
        }
        mutex[address] = true;
        uint toWithdraw = balances[msg.sender];
        // .call returns true if completed, false otherwise
        // using .send is preferred
        // using .transfer is the best solution (throws on exceptions)
        if (msg.sender.call.value(toWithdraw)()){
            balances[msg.sender] = 0;
            mutex[address] = false;
            return true;
        }
        return false;
    }

    function deposit() payable returns(bool) {
        balances[msg.sender] += msg.value;
        return true;
    }

   function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }
}


// msg.send is equivalent to msg.sender.call.gas(0).value(number)(); Where you send no gas along with it.
// send sends 0 gas, but there's an EVM rule that the receiver always gets a stipend of 2,300 gas 
// (so that it always has enough gas to log that it received something)