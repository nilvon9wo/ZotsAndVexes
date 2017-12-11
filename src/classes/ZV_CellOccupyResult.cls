public class ZV_CellOccupyResult {
    public List<ZV_Cell__c> updatedCellList {get; private set;}

    public Id gameWinner;
    public String gameStatus = 'In Progress';
    public Boolean forceFullRefresh = false;
    
    public ZV_CellOccupyResult(List<ZV_Cell__c> updatedCellList) {
    	this.updatedCellList = updatedCellList;
    } 
}