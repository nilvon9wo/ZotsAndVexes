public with sharing class ZV_BoardService {
	private static Integer DEFAULT_BOARD_HEIGHT = 3;
	private static Integer DEFAULT_BOARD_WIDTH = 3;
		
    public List<ZV_Board__c> createBoards(List<ZV_Game__c> gameList) {
    	List<ZV_Board__c> boardList = new List<ZV_Board__c>();
    	for (ZV_Game__c game : gameList) {
    		boardList.add(new ZV_Board__c(
    			Game__c = game.id,
    			Height__c = DEFAULT_BOARD_HEIGHT,
    			Width__c = DEFAULT_BOARD_WIDTH
    		));
    	}
    	return boardList; 
    }
}