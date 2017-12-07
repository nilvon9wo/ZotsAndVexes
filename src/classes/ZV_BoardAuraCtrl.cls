public class ZV_BoardAuraCtrl {
	ZV_BoardSelector boardSelector;
	
	public ZV_BoardAuraCtrl(ZV_BoardSelector boardSelector) {
		this.boardSelector = boardSelector;
	}

	public ZV_BoardAuraCtrl() {
		this(new ZV_BoardSelector());
	}
	
    @AuraEnabled
    public static ZV_Board__c getBoard (Id boardId) {
    	return (new ZV_BoardAuraCtrl()).selectWithCells(boardId);
    }
    
    public ZV_Board__c selectWithCells (Id boardId) {
    	return this.boardSelector.selectWithCells(new Set<Id>{boardId})[0];
    } 
}