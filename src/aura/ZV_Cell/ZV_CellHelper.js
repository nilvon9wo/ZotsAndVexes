({
	occupy : function(component) {
		return $LCH.ServerApexPromise(component, 'occupyCell', {
			boardId: component.get('v.cell.Id')
		});
	}
})