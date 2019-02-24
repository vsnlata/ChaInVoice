pragma solidity >=0.4.22 <0.6.0;
import "./InvoiceGovernance.sol";
import "./SupplierRegistry.sol";
 
contract  PurchaseOrderRegistry{
    
    struct PurchaseOrder {
        uint256 piNumber;
        address manufacturerAddress;
        address supplierAddress;
    }
    
    mapping(uint256 => PurchaseOrder) purchaseOrderMap;
    PurchaseOrder []  purchaseOrders;
    uint256 piNum = 1;
    
    function createPurchaseOrder(address _manufacturer_address, address _supplierAddress)
    public returns (uint256) {
        
        require(_manufacturer_address != address(0));
        require(_supplierAddress != address(0));
        
        uint256 currPiNumber = piNum;
        purchaseOrderMap[piNum] = PurchaseOrder(piNum, _manufacturer_address, _supplierAddress);
        purchaseOrders.push(purchaseOrderMap[piNum]);
        piNum++;
        return currPiNumber;
    }
    

    function getAllPOS(address _manufacturer_address) public view returns (uint256[]) {
        uint256[] memory poNumbers = new uint256[](purchaseOrders.length);
        
        for (uint i = 0; i < purchaseOrders.length; i++) {
            PurchaseOrder memory aPurchase = purchaseOrders[i];
            if(aPurchase.manufacturerAddress == _manufacturer_address) {
                poNumbers[i] = aPurchase.piNumber;
            }
        }
        
        return (poNumbers);
    }
}
