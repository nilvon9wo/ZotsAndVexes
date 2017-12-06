public with sharing class ZV_CellService {
    public List<ZV_Cell__c> createCells(List<ZV_Board__c> boardList) {
    	List<ZV_Cell__c> cellList = new List<ZV_Cell__c>();
    	for (ZV_Board__c board : boardList) {
    		for (Integer i = 1; i <= board.Width__c; i++) {
	    		for (Integer j = 1; j <= board.Height__c; j++) {
	    			cellList.add(new ZV_Cell__c(
	    				Board__c = board.id,
	    				X__c = i,
	    				Y__c = j
	    			));
	    		}
    		}
    	}
    	return cellList; 
    } 
}