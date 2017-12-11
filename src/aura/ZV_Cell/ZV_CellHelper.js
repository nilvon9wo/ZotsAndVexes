({
	occupy : function(component) {
		return $LCH.ServerApexPromise(component, 'occupyCell', {
			cellId: component.get('v.cell.Id')
		});
	}
})