
/**
 * Klasa umożliwiająca dostęp do słowników
 */
DictionaryManager = function() {
	var self = this;

	this.toothActivities = null;
	this.toothStates = null;
	this.visitActivities = null;

	/** inicjalizuje słowniki wartościami z serwera */
	this.loadDictionaries = function(callback) {
		$.ajax({
			type : "GET",
			url : "/dentalsurgery/dict/getall",
			dataType : "json",
			success : function(dictionaries) {
				self.toothActivities = dictionaries.toothActivities;
				self.toothStates = dictionaries.toothStates;
				self.visitActivities = dictionaries.visitActivities;
				if (callback != null)
					callback();
			}
		});
	};
};
