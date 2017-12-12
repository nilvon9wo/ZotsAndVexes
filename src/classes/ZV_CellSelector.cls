public with sharing class ZV_CellSelector extends fflib_SObjectSelector {
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			ZV_Cell__c.Board__c,
			ZV_Cell__c.Id,
			ZV_Cell__c.Occupant__c,
			ZV_Cell__c.X__c,
			ZV_Cell__c.Y__c 
		};
	}

	public Schema.SObjectType getSObjectType() {
		return ZV_Cell__c.sObjectType;
	} 

	public override String getOrderBy() {
		return 'Y__c ASC, X__c ASC';
	}

	public List<ZV_Cell__c> selectById(Set<Id> idSet) {
		return (List<ZV_Cell__c>) selectSObjectsById(idSet);
	}
}