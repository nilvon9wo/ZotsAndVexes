public with sharing class ZV_BoardTriggerHandler extends fflib_SObjectDomain {
	ZV_CellService cellService;
	F45_DML_GenericDml genericDml;
	
    public ZV_BoardTriggerHandler(List<ZV_Board__c> sObjectList, ZV_CellService cellService, F45_DML_GenericDml genericDml) {
    	super(sObjectList);
    	this.cellService = cellService;
    	this.genericDml = genericDml;
    }
	
	
    public ZV_BoardTriggerHandler(List<ZV_Board__c> sObjectList) {
    	this(sObjectList, new ZV_CellService(), new F45_DML_GenericDml());
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
    	public fflib_SObjectDomain construct(List<SObject> sObjectList) {
    		return new ZV_BoardTriggerHandler(sObjectList);
    	} 
    }
    
    public override void onAfterInsert() {
    	this.genericDml.doInsert(this.cellService.createCells((List<ZV_Board__c>) records));
    }
}