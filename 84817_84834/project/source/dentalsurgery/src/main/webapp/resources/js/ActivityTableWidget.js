
/**
 * Tabela z czynnościami, dodanymi podczas wizyty
 * @param componentManager
 */
ActivityTableWidget = function(componentManager) {
	var self = this;
	
	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;
	
	/**
	 * Dodaje jeden wiersz z czynnością
	 * @param params obiekt z parametrami dodawanej czynności
	 * Np.:		
	 * 		param = {
	 * 			type: "tooth",
	 * 			toothNumber: 12,
	 * 			activity: toothActivity,
	 * 			scope: "Ząb nr 23"
	 * 		}
	 */
	this.addActivityRow = function (params){
		
		var rowClass = params.type + "-row-activity";
		var rowId = rowClass + "-" + params.activity.activityId;
		if (params.toothNumber != null)
			rowId = rowId + "-" + params.toothNumber;
		
		var price = params.activity.price;
		if (price == null) { 
			price = "zabieg bezpłatny";
		} else {
			price = price + " zł";
		}
		
		var rowRemoveButtonId = rowId+"-remove";
		var $newRow = $("<tr class=\""+rowClass+"\" id=\""+rowId+"\"><td>"+
					params.scope+"</td>"+
				"<td>"+params.activity.description+"</td>"+
				"<td>"+price+"</td>"+
				"<td><button id=\""+rowRemoveButtonId+"\"> "+
					"Usuń czynność</button></td></tr>");
		
		$('#list-activities-table').append($newRow);
		
		$('#'+rowRemoveButtonId).button({
			icons: {
                primary: "ui-icon-trash"
            },
            text: false
		});
		
		$('#'+rowRemoveButtonId).click(function(){
			$('#'+rowId).remove();
			self.componentManager.removeActivity(params);
		});
	};
	
};
