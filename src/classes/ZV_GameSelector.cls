public with sharing class ZV_GameSelector extends fflib_SObjectSelector { 
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			ZV_Game__c.Id,
			ZV_Game__c.Status__c,
			ZV_Game__c.Winner__c
		};
	}

	public Schema.SObjectType getSObjectType() {
		return ZV_Game__c.sObjectType;
	} 

	public List<ZV_Game__c> selectById(Set<Id> idSet) {
		return (List<ZV_Game__c>) selectSObjectsById(idSet);
	}
}