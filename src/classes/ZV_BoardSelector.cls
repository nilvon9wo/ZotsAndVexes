public with sharing class ZV_BoardSelector extends fflib_SObjectSelector {
	ZV_CellSelector cellSelector;
	
	public ZV_BoardSelector(ZV_CellSelector cellSelector) {
		this.cellSelector = cellSelector;
	}

	public ZV_BoardSelector() {
		this(new ZV_CellSelector());
	}
	
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			ZV_Board__c.Id,
			ZV_Board__c.Height__c,
			ZV_Board__c.Width__c 
		};
	}

	public Schema.SObjectType getSObjectType() {
		return ZV_Board__c.sObjectType;
	} 

	public List<ZV_Board__c> selectById(Set<Id> idSet) {
		return (List<ZV_Board__c>) selectSObjectsById(idSet);
	}

	public List<ZV_Board__c> selectWithCells(Set<Id> idSet) {
		fflib_QueryFactory boardQueryFactory = newQueryFactory();
		fflib_QueryFactory cellQueryFactory = this.cellSelector.addQueryFactorySubselect(boardQueryFactory, 'Cells__r');
		return (List<ZV_Board__c>) Database.query(
			boardQueryFactory
				.setCondition('id in :idSet')
				.toSOQL()
		);
	}
}