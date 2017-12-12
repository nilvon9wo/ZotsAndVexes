public class ZV_CellAuraCtrl {
	F45_DML_GenericDml genericDml;
	ZV_CellService cellService;
	ZV_GameService gameService;
	ZV_RecordTypeCache recordTypeCache;   
	
	public ZV_CellAuraCtrl(
			F45_DML_GenericDml genericDml, 
			ZV_CellService cellService, 
			ZV_GameService gameService, 
			ZV_RecordTypeCache recordTypeCache
		) {
		this.genericDml = genericDml;
		this.cellService = cellService;
		this.gameService = gameService;
		this.recordTypeCache = recordTypeCache;
	}		

	public ZV_CellAuraCtrl() {
		this(
			new F45_DML_GenericDml(), 
			new ZV_CellService(), 
			new ZV_GameService(), 
			new ZV_RecordTypeCache()
		);
	}		

    @AuraEnabled
    public static ZV_CellOccupyResult occupyCell(Id cellId) {
    	return (new ZV_CellAuraCtrl()).occupy(cellId);
    }
    	   
    public ZV_CellOccupyResult occupy(Id cellId) {
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{ZV_Game__c.SObjectType});
    	 
    	ZV_GameCellContext gameCellContext = new ZV_GameCellContext(cellId);
    	List<ZV_Cell__c> updatedCellList = this.cellService.occupyCells(gameCellContext); 
		    	

    	
    	// TODO: Update next player 
    	// TODO: While next player is robot do
    	// TODO: -- Calculate robot's move(s)
    	// TODO: -- Update cell(s)
    	// TODO: -- Update next player 
    	
    	// TODO

		this.genericDml.doUpsert(updatedCellList);    	  
    	return new ZV_CellOccupyResult(updatedCellList);
    }
}