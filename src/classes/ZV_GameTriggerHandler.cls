public class ZV_GameTriggerHandler extends fflib_SObjectDomain {
	ZV_BoardService boardService;
	ZV_GamePlayerService gamePlayerService;
	ZV_PlayerService playerService;  
	F45_DML_GenericDml genericDml;
	
    public ZV_GameTriggerHandler(
    		List<ZV_Game__c> sObjectList, 
    		ZV_BoardService boardService, 
    		ZV_GamePlayerService gamePlayerService,
    		ZV_PlayerService playerService,
    		F45_DML_GenericDml genericDml
    	) {
    	super(sObjectList);
    	this.boardService = boardService;
    	this.gamePlayerService = gamePlayerService;
    	this.playerService = playerService;
    	this.genericDml = genericDml;
    }
	
    public ZV_GameTriggerHandler(List<ZV_Game__c> sObjectList) {
    	this(sObjectList, new ZV_BoardService(), new ZV_GamePlayerService(), new ZV_PlayerService(), new F45_DML_GenericDml());
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
    	public fflib_SObjectDomain construct(List<SObject> sObjectList) {  
    		return new ZV_GameTriggerHandler(sObjectList);
    	} 
    }
     
    public override void onAfterInsert() { 
    	List<ZV_Game__c> gameList = (List<ZV_Game__c>) records;
    	this.genericDml.doInsert(this.boardService.createBoards(gameList));
    	this.genericDml.doInsert(this.playerService.loadPlayers(gameList).newPlayerList);
    	this.genericDml.doInsert(this.gamePlayerService.attachPlayers(gameList));
    }
}