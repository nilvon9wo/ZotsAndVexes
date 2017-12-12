public class ZV_GameTriggerHandler extends fflib_SObjectDomain {
	ZV_BoardService boardService;
	ZV_GamePlayerService gamePlayerService;
	ZV_PlayerService playerService;
	ZV_RecordTypeCache recordTypeCache;  
	F45_DML_GenericDml genericDml;
	
    public ZV_GameTriggerHandler(
    		List<ZV_Game__c> sObjectList, 
    		ZV_BoardService boardService, 
    		ZV_GamePlayerService gamePlayerService,
    		ZV_PlayerService playerService,
    		ZV_RecordTypeCache recordTypeCache,
    		F45_DML_GenericDml genericDml
    	) {
    	super(sObjectList);
    	this.boardService = boardService; 
    	this.gamePlayerService = gamePlayerService;
    	this.playerService = playerService;
    	this.recordTypeCache = recordTypeCache;
    	this.genericDml = genericDml;
    }
	
    public ZV_GameTriggerHandler(List<ZV_Game__c> sObjectList) {
    	this(
    		sObjectList, 
    		new ZV_BoardService(), 
    		new ZV_GamePlayerService(), 
    		new ZV_PlayerService(), 
    		new ZV_RecordTypeCache(),
    		new F45_DML_GenericDml()
    	);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable { 
    	public fflib_SObjectDomain construct(List<SObject> sObjectList) {  
    		return new ZV_GameTriggerHandler(sObjectList);
    	} 
    }
     
    public override void onAfterInsert() { 
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{ZV_Game__c.SObjectType});
    	
    	List<ZV_Game__c> gameList = (List<ZV_Game__c>) records;
    	this.genericDml.doInsert(this.boardService.createBoards(gameList));
    	this.genericDml.doInsert(this.playerService.loadPlayers(gameList).newPlayerList);
    	this.genericDml.doInsert(this.gamePlayerService.attachPlayers(gameList));
    }
}