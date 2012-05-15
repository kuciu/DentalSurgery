
/**
 * Menu czynności związanych z zębem
 */
ToothActivityWidget = function(componentManager) {
	var self = this;
	
	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;
	
	/** pomocnicza tablica czynności */
	this.activityMap = new Array();
	
	/**
	 * Tworzy listę opcji czynności
	 * @param toothActivities lista obiektów czynności zęba
	 */
	this.createToothActivityUi = function(toothActivities) {
		var $wholeOptGroup = 
			$('<optgroup id="whole-tooth-activities"'+
					'label="Zasięg: cały ząb"></optgroup>');
		$('#selected-tooth-activity').append($wholeOptGroup);
		$restOptGroup = 
			$('<optgroup id="rest-tooth-activities"'+
					'label="Zasięg: dowolna powierzchnia/cały ząb"></optgroup>');
		$('#selected-tooth-activity').append($restOptGroup);
		
		$.each(toothActivities, function(_,activity){
			
			self.activityMap[activity.activityId] = activity;
			var $newOption = $('<option value="'+activity.activityId+
					'">'+activity.description+'</option>');
			
			if (activity.allTooth == null 
					|| activity.allTooth == false || activity.allTooth == 0) {
				$("#rest-tooth-activities").append($newOption);	
			} else {
				$("#whole-tooth-activities").append($newOption);
			}
			
		});
		$('#selected-tooth-activity').selectmenu({
			style: 'popup',
			menuWidth: '350',
			width: '250' 
		});
		$('#add-tooth-activity-button').button();
	};
	
	
};