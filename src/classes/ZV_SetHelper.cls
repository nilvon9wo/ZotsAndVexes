public class ZV_SetHelper {
    public Set<Id> createIdSet(List<SObject> sObjectList, SObjectField sObjectField) {
    	Set<Id> idSet = new Set<Id>();
    	for (SObject sObj : sObjectList) {
    		idSet.add((Id) sObj.get(sObjectField));
    	}
    	return idSet;
    }
}