public class ZV_CellAuraCtrl {
	ZV_BoardSelector boardSelector;
	ZV_CellSelector cellSelector;
	ZV_CellOccupyValidator cellOccupyValidator;
	ZV_GameSelector gameSelector;
	ZV_GamePlayerSelector gamePlayerSelector;
	ZV_PlayerSelector playerSelector;
	
	public ZV_CellAuraCtrl(
			ZV_BoardSelector boardSelector,
			ZV_CellSelector cellSelector,
			ZV_CellOccupyValidator cellOccupyValidator,
			ZV_GameSelector gameSelector,
			ZV_GamePlayerSelector gamePlayerSelector,
			ZV_PlayerSelector playerSelector
		) {
		this.boardSelector = boardSelector;
		this.cellSelector = cellSelector;
		this.cellOccupyValidator = cellOccupyValidator;
		this.gameSelector = gameSelector;
		this.gamePlayerSelector = gamePlayerSelector;
		this.playerSelector = playerSelector;
	}		

	public ZV_CellAuraCtrl() {
		this(
			new ZV_BoardSelector(), 
			new ZV_CellSelector(), 
			new ZV_CellOccupyValidator(), 
			new ZV_GameSelector(), 
			new ZV_GamePlayerSelector(), 
			new ZV_PlayerSelector()
		);
	}		

    @AuraEnabled
    public static ZV_CellOccupyResult occupyCell(Id cellId) {
    	return (new ZV_CellAuraCtrl()).occupy(cellId);
    }
    	  
    public ZV_CellOccupyResult occupy(Id cellId) {
    	 
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