// Please paste your contract's solidity code here
// Note that writing a contract here WILL NOT deploy it and allow you to access it from your client
// You should write and develop your contract in Remix and then, before submitting, copy and paste it here

pragma solidity 0.5.2;

contract BlockchainSplitwise {
    
    // define a mapping with two addresses and a uint (to store the balances owed)
    
    mapping(address => mapping(address => uint32)) users;
    
     // lookup function to find balances owed
    
    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        return users[debtor][creditor];
    }
    
    // add IOU function to add new balances and clear debt cycles
    
    function add_IOU(address creditor, uint32 amount, address[] memory cycle, uint32 minDebt) public {
        require (amount >= 0, 'Negative amount');
        require (minDebt >= 0, 'Negative minDebt');
        
        if(cycle.length == 0){
            users[msg.sender][creditor] += amount;
        } else {
            // Check that sender is in the end of the cycle
            for(uint i = 0; i < (cycle.length - 1); i++){
                require(lookup(cycle[i], cycle[i+1]) >= minDebt);
                users[cycle[i]][cycle[i+1]] -= minDebt;
            }
            
            users[cycle[cycle.length-1]][cycle[0]] += amount;
            users[cycle[cycle.length-1]][cycle[0]] -= minDebt;
            
        
        }
        
    }

}