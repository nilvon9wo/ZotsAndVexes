public virtual class F45_DML_GenericDml {
	public static Boolean IS_ALL_OR_NONE = true; 
	public static Boolean NOT_ALL_OR_NONE = false; 
	
    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> sObjectList, Boolean isAllOrNone) {
    	List<SObject> nullFreeSObjectList = this.removeNulls(sObjectList);
    	return new F45_DML_SaveResultListWrapper(Database.insert(nullFreeSObjectList, isAllOrNone));
    }
    
    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> sObjectList) {
    	return this.doInsert(sObjectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> sObjectList, Boolean isAllOrNone) {
    	List<SObject> nullFreeSObjectList = this.removeNulls(sObjectList);
    	return new F45_DML_SaveResultListWrapper(Database.update(nullFreeSObjectList, isAllOrNone));
    }
    
    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> sObjectList) {
    	return this.doUpdate(sObjectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> sObjectList, Boolean isAllOrNone) {
    	List<SObject> nullFreeSObjectList = this.removeNulls(sObjectList);
    	return new F45_DML_UpsertResultListWrapper(Database.upsert(nullFreeSObjectList, isAllOrNone));
    }
    
    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> sObjectList) {
    	return this.doUpsert(sObjectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> sObjectList, Boolean isAllOrNone) {
    	List<SObject> nullFreeSObjectList = this.removeNulls(sObjectList);
    	return new F45_DML_DeleteResultListWrapper(Database.delete(nullFreeSObjectList, isAllOrNone));
    }
    
    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> sObjectList) {
    	return this.doDelete(sObjectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> sObjectList, Boolean isAllOrNone) {
    	List<SObject> nullFreeSObjectList = this.removeNulls(sObjectList);
    	return new F45_DML_UndeleteResultListWrapper(Database.undelete(nullFreeSObjectList, isAllOrNone));
    }
    
    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> sObjectList) {
    	return this.doUndelete(sObjectList, IS_ALL_OR_NONE);
    }
    
    private List<SObject> removeNulls (List<SObject> sObjectList) {
    	List<SObject> nullFreeSObjectList = new List<SObject>();
    	if (sObjectList != null) {
    		for (SObject sObj : sObjectList) {
    			if (sObj != null) {
    				nullFreeSObjectList.add(sObj);
    			}
    		}
    	}
    	return nullFreeSObjectList; 
    }
}