public class ZV_SObjectTypeHelper {
    public Set<String> convertToStringSet(Set<SObjectType> sObjectTypeSet) {
    	Set<String> sObjectTypeStringSet = new Set<String>();
    	for (SObjectType sObjectType :sObjectTypeSet) {
    		sObjectTypeStringSet.add(sObjectType.getDescribe().getName());
    	}
    	return sObjectTypeStringSet;
    }
}