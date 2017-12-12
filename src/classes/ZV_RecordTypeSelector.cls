public with sharing class ZV_RecordTypeSelector extends fflib_SObjectSelector {
	ZV_SObjectTypeHelper sObjectTypeHelper;
	
	public ZV_RecordTypeSelector(ZV_SObjectTypeHelper sObjectTypeHelper) {
		this.sObjectTypeHelper = sObjectTypeHelper;
	}
	
	public ZV_RecordTypeSelector() {
		this(new ZV_SObjectTypeHelper());
	}
	
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			RecordType.Id,
			RecordType.DeveloperName
		};
	} 

	public Schema.SObjectType getSObjectType() {
		return RecordType.getSObjectType();
	} 

	public List<RecordType> selectById(Set<Id> idSet) { 
		return (List<RecordType>) selectSObjectsById(idSet);
	}
	
	public List<RecordType> selectFor(Set<SObjectType> sObjectTypeSet) {
		Set<String> sObjectTypeStringSet = this.sObjectTypeHelper.convertToStringSet(sObjectTypeSet);
		return (List<RecordType>) Database.query(
			newQueryFactory()
				.setCondition('SObjectType IN :sObjectTypeStringSet')
				.toSOQL()		
		);
    }
}