
/**
 * Menu czynności związanych z wizytą
 */
VisitActivityWidget = function(componentManager) {
	var self = this;
	
	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;
	
	/** pomocnicza tablica czynności */
	this.activityMap = new Array();
	
	/**
	 * Tworzy listę opcji czynności
	 * @param visitActivities lista obiektów czynności zęba
	 */
	this.createVisitActivityUi = function(visitActivities) {		
		$.each(visitActivities, function(_,activity) {
			self.activityMap[activity.activityId] = activity;
			var $newOption = $('<option value="'+activity.activityId+
					'">'+activity.description+'</option>');
			$('#select-visit-activity').append($newOption);
		}); 
		$('#select-visit-activity').selectmenu({
			style: 'popup',
			menuWidth: '350',
			width: '250' 
		});
		$('#add-visit-activity-button').button();
		$('#add-visit-activity-button').click(function(){
			var activityId = $('#select-visit-activity').selectmenu('value'); 
			var visitActivity = self.activityMap[activityId];
			self.componentManager.addVisitActivity(visitActivity);
		});
	};	
};
