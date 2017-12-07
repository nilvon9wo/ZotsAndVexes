({
	loadBoardWithCells : function(component) {
		var params = {
			serverMethod: 'getBoard',
			serverParams: {
				boardId: component.get('v.recordId')
			}
		};
		return this.apexResolve(component, params);
	},
	
	apexResolve: function(component, params) {
			console.log('####### apexResolve component', component);
			console.log('####### apexResolve params', params);
			var action = component.get('c.' + params.serverMethod);
			action.setParams(params.serverParams);
			console.log('####### apexResolve action', action);
			return new Promise(function(resolve, reject) {
			console.log('####### apexResolve Promise resolve', resolve);
			console.log('####### apexResolve Promise reject', reject);
				action.setCallback(this, function(response) {
			console.log('####### apexResolve Promise setCallback response', response);
					if (response.getState() === 'SUCCESS') {
						resolve(response.getReturnValue())
					}
					else {
						var errors = response.getError();
						var errorMessage = (errors && errors[0] && errors[0].message)
							? 'Error message: ' + errors[0].message
							: 'Unknown error';
						reject (errorMessage);
					}
				}); 
				$A.enqueueAction(action);
			}); 
	},
	
	displayCells : function(component) {
		return function(returnValue) {
			console.log('######### displayCells returnValue', returnValue);
		}
	}
})