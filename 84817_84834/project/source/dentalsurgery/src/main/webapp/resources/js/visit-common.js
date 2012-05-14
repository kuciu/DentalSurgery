
/** numery zębów */
var TeethNumbers  = {
	/////// zęby stałe
	PERMANENT: {	
		// prawa górna strona							// lewa górna strona
		TOP: 	[ 18, 17, 16, 15, 14, 13, 12, 11,		21, 22, 23, 24, 25, 26, 27, 28 ], 
		// prawa dolna strona							// lewa dolna strona
		BOTTOM: [ 48, 47, 46, 45, 44, 43, 42, 41,		31, 32, 33, 34, 35, 36, 37, 38 ],
	},
	/////// zęby mleczne
	DECIDUOUS: {
					//prawa górna strona				// lewa górna strona
					TOP: 	[ 55, 54, 53, 52, 51, 		61, 62, 63, 64, 65 ], 
					// prawa dolna strona				// lewa dolna strona
					BOTTOM: [ 85, 84, 83, 82, 81,		71, 72, 73, 74, 75 ]
	}
};

/** dostępne kolory zębów */
var Colors = {
		WHITE : 	{ value: 0, cssClass: "white" },
		RED : 		{ value: 1, cssClass: "red"  },
		GREEN : 	{ value: 2, cssClass: "green" },
		BLUE : 		{ value: 3, cssClass: "blue"  },
};

/** powierzchnie zęba */
var ToothParts = {
		AREA_0 : { value: 0, stateField: "allToothState", description: "Cały ząb" },
		AREA_1 : { value: 1, stateField: "area1State", description: "Pow. zewnętrzna" },
		AREA_2 : { value: 2, stateField: "area2State", description: "Pow. wewnętrzna" },
		AREA_3 : { value: 3, stateField: "area3State", description: "Pow. bliższa" },
		AREA_4 : { value: 4, stateField: "area4State", description: "Pow. dalsza" },
		AREA_5 : { value: 5, stateField: "area5State", description: "Pow. żująca" },
		AREA_6 : { value: 6, stateField: "area6State", description: "Korzeń środkowy" },
		AREA_7 : { value: 7, stateField: "area7State", description: "Korzeń bliższy" },
		AREA_8 : { value: 8, stateField: "area8State", description: "Korzeń dalszy" }
};


/**
 * Powiadomienie o sukcesie i wykonanie akcji
 */
function successMessage(title, text, callback) {
	$("#success-message-text").html(text);
	$("#success-message").dialog({
		title : title,
		resizable : false,
		width : 500,
		modal : true,
		buttons : {
			Ok : function() {
				$(this).dialog("close");
				if (callback != null) {
					callback();
				}
			}
		}
	});
}

/**
 * Powiadomienie o błędzie
 */
function errorMessage(title, text) {
	$("#error-message-text").html(text);
	$("#error-message").dialog({
		title : title,
		resizable : false,
		width : 500,
		modal : true,
		buttons : {
			Ok : function() {
				$(this).dialog("close");
			}
		}
	});
}
