public with sharing class ZV_UserSelector extends fflib_SObjectSelector {
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			User.Id,
			User.Username
		};
	}

	public Schema.SObjectType getSObjectType() {
		return User.sObjectType;
	} 

	public List<User> selectById(Set<Id> idSet) {
		return (List<User>) selectSObjectsById(idSet);
	}
}