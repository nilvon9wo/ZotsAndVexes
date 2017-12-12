public class ZV_CellAuraCtrl {
	ZV_CellOccupyValidator cellOccupyValidator;
	ZV_RecordTypeCache recordTypeCache;   
	
	public ZV_CellAuraCtrl(ZV_CellOccupyValidator cellOccupyValidator, ZV_RecordTypeCache recordTypeCache) {
		this.cellOccupyValidator = cellOccupyValidator;
		this.recordTypeCache = recordTypeCache;
	}		

	public ZV_CellAuraCtrl() {
		this(new ZV_CellOccupyValidator(), new ZV_RecordTypeCache());
	}		

    @AuraEnabled
    public static ZV_CellOccupyResult occupyCell(Id cellId) {
    	return (new ZV_CellAuraCtrl()).occupy(cellId);
    }
    	   
    public ZV_CellOccupyResult occupy(Id cellId) {
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{ZV_Game__c.SObjectType});
    	 
    	ZV_GameCellContext gameCellContext = new ZV_GameCellContext(cellId);    
    	Boolean isValid = this.cellOccupyValidator.validate(gameCellContext); 
    	
    	// TODO: Verify user is in game
    	// TODO: Verify user is next player
    	// TODO: Verify player can occupy cell
    	// TODO: Update Cell
    	// TODO: Update next player
    	// TODO: While next player is robot do
    	// TODO: -- Calculate robot's move(s)
    	// TODO: -- Update cell(s)
    	// TODO: -- Update next player 
    	
    	List<ZV_Cell__c> updatedCellList = new List<ZV_Cell__c>();
    	// TODO
    	  
    	ZV_CellOccupyResult result = new ZV_CellOccupyResult(updatedCellList);
    	// TODO
    	
    	return result;
    }
}