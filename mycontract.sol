// Contract to implement Splitwise on an Ethereum blockchain testnet.

pragma solidity 0.5.2;

contract BlockchainSplitwise {
    
    // Define a mapping with two addresses and a uint (to store balances owed)
    
    mapping(address => mapping(address => uint32)) users;
    
     // Function to find amounts owed by a debtor to a creditor
    
    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        return users[debtor][creditor];
    }
    
    // Function to add new balances and clear debt loops
    
    function add_IOU(address creditor, uint32 amount, address[] memory loop, uint32 minBalance) public {
        
        // Checks a few things including that sender is part of the loop
        require (amount >= 0, 'Negative amount');
        require (minBalance >= 0, 'Negative minBalance');
        // require (loop[loop.length-1] = msg.sender, 'Attempting to edit other entries');
        
        // Checks for valid loop then adjust balances 
        if(loop.length == 0 || loop = null) {
            users[msg.sender][creditor] += amount;
        } else {
            
            for(uint i = 0; i < (loop.length - 1); i++) {
                require(lookup(loop[i], loop[i+1]) >= minBalance, 'Invalid loop'); 
            }
            
            for(uint i = 0; i < (loop.length - 1); i++) {
                users[loop[i]][loop[i+1]] -= minBalance;
            }
            
            users[loop[loop.length-1]][loop[0]] += amount;
            users[loop[loop.length-1]][loop[0]] -= minBalance;
            
        }
        
    }

}