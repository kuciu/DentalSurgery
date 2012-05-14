<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Dental Surgery | Nowa wizyta - <c:out
				value="${patient.surname}" /> <c:out value="${patient.name}" /></title>

<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet"
	type="text/css" />
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery-ui-1.8.20.custom.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
	
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
	
<script type="text/javascript">
			
	/**
	 * Powiadomienie o sukcesie i wykonanie akcji
	 */
	function successMessage(title, text, callback) {
		$("#success-message-text").html(text);
		$("#success-message").dialog({
			title: title,
			resizable: false,
			width:500,
			modal: true,
			buttons: {
				Ok: function() { 
					$( this ).dialog( "close" );
					if (callback != null) {callback();}
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
			title: title,
			resizable: false,
			width:500,
			modal: true,
			buttons: {
				Ok: function() { 
					$( this ).dialog( "close" );
				}
			}
		});
	}
		
</script>

<style type="text/css">
	
	#body-content{
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#ui-teeth-map {
		float: left;
		padding: 10px;
		width: 350px;
		height: 300px;
	
	
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#ui-teeth-map-permanent {
		width: 355px;
		height: 105px;
	}
	
	#ui-teeth-map-deciduous {
		margin-left: 63px;
		width: 225px;
		height: 105px;
	}
	
	#selected-tooth-div {
		float: right;
		padding: 10px;
		width: 400px;
		height: 300px;
	
	
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#selected-tooth-map {
		width: 140px;
		height: 100px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		margin:auto;
	}
	
	#modify-form-div {
		
		float: left;
		padding: 10px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		width: 350px;
	}
	
	#list-activities {
		float: right;
		padding: 10px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		width: 400px;
	}
	
	/* ************************** mapa zębów ********************************************* */
	
	/* obrazki zębów górnych */
	.top .ui-tooth.white {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-white.png');
	}
	
	.top .ui-tooth.white.selected, .top .ui-tooth.white:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-light.png');
	}
	
	.top .ui-tooth.red {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-lightred.png');
	}
	
	.top .ui-tooth.red.selected, .top .ui-tooth.red:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-darkred.png');
	}
	
	.top .ui-tooth.green {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-lightgreen.png');
	}
	
	.top .ui-tooth.green.selected, .top .ui-tooth.green:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-darkgreen.png');
	}
	
	.top .ui-tooth.blue {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-lightblue.png');
	}
	
	.top .ui-tooth.blue.selected, .top .ui-tooth.blue:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-darkblue.png');
	}	
	
	/* obrazki zębów dolnych (odwrócone) */
	
	.bottom .ui-tooth.white {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-white.png');
	}
	
	.bottom .ui-tooth.white.selected, .bottom .ui-tooth.white:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-light.png');
	}
	
	.bottom .ui-tooth.red {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-lightred.png');
	}
	
	.bottom .ui-tooth.red.selected, .bottom .ui-tooth.red:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-darkred.png');
	}
	
	.bottom .ui-tooth.green {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-lightgreen.png');
	}
	
	.bottom .ui-tooth.green.selected, .bottom .ui-tooth.green:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-darkgreen.png');
	}
	
	.bottom .ui-tooth.blue {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-lightblue.png');
	}
	
	.bottom .ui-tooth.blue.selected, .bottom .ui-tooth.blue:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-darkblue.png');
	}	
	
	
	
	/* ząb górny */
	.top .ui-tooth {
		margin-left: 1px;		/* lekkie rozsunięcie zębów */
		width: 20px;
		height: 50px;
		float: left;
		cursor: pointer;
		background-repeat: no-repeat;
		background-position: top;
	}
	
	/* pozycjonowanie numeru w zębie górnym*/
	.top .ui-tooth .number {
		position: relative;
		top: 33px;
		left: 4px;
	}
	
	/* ząb dolny */
	.bottom .ui-tooth {
		margin-left: 1px;		/* lekkie rozsunięcie zębów */
		width: 20px;
		height: 50px;
		float: left;
		cursor: pointer;
		background-repeat: no-repeat;
		background-position: bottom;
	}
	
	/* pozycjonowanie numeru w zębie dolnym */
	.bottom .ui-tooth .number {
		position: relative;
		top: 3px;
		left: 4px;
	}
	
	/* odsunięcie lewej od prawej części szczęki */
	.permanent * .ui-tooth:nth-child(9),
	.deciduous * .ui-tooth:nth-child(6)
	  {
		margin-left: 10px;
	}
	
	
</style> 

<script type="text/javascript">

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
			RED : 		{ value: 1, cssClass: "red" },
			GREEN : 	{ value: 2, cssClass: "green" },
			BLUE : 		{ value: 3, cssClass: "blue" },
	};
	
	/** powierzchnie zęba */
	var ToothPart = {
			WHOLE_TOOTH : { value: 0, stateField: "allToothState", description: "Cały ząb" },
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
					type: "GET", url: "/dentalsurgery/dict/getall", 
					dataType: "json",
					success: function(dictionaries) {
						self.toothActivities = dictionaries.toothActivities;
						self.toothStates =  dictionaries.toothStates;
						self.visitActivities = dictionaries.visitActivities;
						if (callback != null)
							callback();
					}
				});	
		 }; 
	 };
	
	
	/**
	 * Widget z mapą uzębienia
	 */
	ToothMapWidget = function(componentManager) {
		var self = this;
		
		/** rejestracja menedżera komponentów */
		this.componentManager = componentManager;
		
		/** prefiks identyfikatorów zębów na mapie */
		this.prefix = "tooth";
		
		/**
		 * Tworzy mapę uzębienia w postaci graficznej
		 */ 
		this.createTeethMapUi = function() {
			$.each(TeethNumbers.PERMANENT.TOP, function(_, num){
				var $toothUi = $('<div class="ui-tooth white" id="'+self.prefix+num+'"><span class="number">'+num+'</span></div>');
				$(".ui-teeth-map .permanent .top").append($toothUi);
			});
			$.each(TeethNumbers.PERMANENT.BOTTOM, function(_, num){
				var $toothUi = $('<div class="ui-tooth white" id="'+self.prefix+num+'"><span class="number">'+num+'</span></div>');
				$(".ui-teeth-map .permanent .bottom").append($toothUi);
			});
			$.each(TeethNumbers.DECIDUOUS.TOP, function(_, num){
				var $toothUi = $('<div class="ui-tooth white" id="'+self.prefix+num+'"><span class="number">'+num+'</span></div>');
				$(".ui-teeth-map .deciduous .top").append($toothUi);
			});
			$.each(TeethNumbers.DECIDUOUS.BOTTOM, function(_, num){
				var $toothUi = $('<div class="ui-tooth white" id="'+self.prefix+num+'"><span class="number">'+num+'</span></div>');
				$(".ui-teeth-map .deciduous .bottom").append($toothUi);
			});
		};
		
		/**
		 * Zmienia kolor zęba
		 * Przykład: .changeColor(28, Colors.WHITE)
		 */
		this.changeColor = function(toothNumber, newColor) {
			$.each(Colors, function(_,color){
				$('#tooth'+toothNumber).removeClass(color.cssClass);	
			});
			$('#tooth'+toothNumber).addClass(newColor.cssClass)
		};
		
		/**
		 * Zaznacza/odznacza ząb (graficzne podświetlenie) 
		 * Przykład: .toggleSelected(28)
		 */
		this.toggleSelected = function(toothNumber) {
			$('#tooth'+toothNumber).toggleClass('selected');
		};
		
		/**
		 * Obsługa zdarzeń związanych z interfejsem użytkownika
		 */
		this.registerEventHandlers = function() {
			// kliknięcie na ząb
			$('.ui-tooth').click(function(){
				var toothNumber = this.id.substring(self.prefix.length,
						self.prefix.length+2);
				self.componentManager.selectTooth(toothNumber);
			});
		};
		
	};
	
	
	/**
	 * Wrapper na obiekt wizyty, przysłany JSONem
	 */
	VisitWrapper = function(patientId) {
		var self = this;
		
		this.patientId = patientId;
		
		this.teeth = null;
		this.visitObj = null;
		
		/** ściąga JSONa z nową wizytą */
		this.prepareNewVisit = function(callback) {
			$.ajax({
				type: "GET", url: "/dentalsurgery/patients/"+self.patientId+"/visits/prepareNew", 
				dataType: "json",
				success: function(data) {
					self.visitObj = data;
					// przygotowanie tablicy obiektów zębów indeksowanej ich numerami
					self.teeth = new Array();
					for (var toothKey in self.visitObj.teeth) {
						var tooth = self.visitObj.teeth[toothKey];
						self.teeth[tooth.number] = tooth;
					}		
					callback(self.visitObj);
				}
			});	
		};
		
		/** wysyla POSTem JSONa z utworzoną w interfejsie wizytą */
		this.sendVisit = function(callback) {
			$.ajax({
				type: "POST", url: "/dentalsurgery/patients/"+self.patientId+"/visits/save", 
				data: JSON.stringify(self.visitObj), contentType: "application/json", dataType: "text",
				success: function(text) {
					if (callback != null) {
						callback(text);
					}
				}
			});
		};
		
		/** zwraca obiekt zęba o konkretnym numerze FDI */
		this.getToothByNumber = function(number) {
			for (var toothKey in self.visitObj.teeth) {
				var tooth = self.visitObj.teeth[toothKey];
				if (tooth.number == number) {
					return tooth; 
				}
			}
		};
		
		/** ustawia wartość komentarza do wizyty */
		this.setComments = function(comments){
			self.visitObj.comments = new String(comments);
		};
		
		/** dodaje czynność do tablicy czynności */
		this.addActivity = function(newActivity, activities) {
			for (var key in activities) {
				if (activities[key].activityId ==  newActivity.activityId) {
					return;
				}
			}
			activities.push(newActivity);
		};

		/** usuwa czynność z tablicy czynności */
		this.removeActivity = function(activity, activities) {
			for ( var i = 0; i < activities.length; i++) {
				if (activities[i].activityId == activity.activityId) {
					activities.splice(i,1);
				}
			}
		};

		/** dodaje czynność do wizyty */
		this.addVisitActivity = function(newActivity) {
			this.addActivity(newActivity, self.visitObj.activities);
		};
		
		/** usuwa czynność z wizyty */
		this.removeVisitActivity = function(activity) {
			this.removeActivity(activity, self.visitObj.activities);
		};
		
		/** dodaje czynność do zęba */
		this.addToothActivity = function(number, newActivity) {
			this.addActivity(newActivity, self.teeth[number].activities);
		};
		
		/** usuwa czynność z zęba */
		this.removeToothActivity = function(number, activity) {
			this.removeActivity(activity, self.teeth[number].activities);
		};
		
		/** zwraca stan zęba lub jego powierzchni */
		this.getToothState = function(number, areaEnumObject) {
			return self.teeth[number][areaEnumObject.stateField];
		};
		
		/** ustawia stan zęba lub jego powierzchni */
		this.setToothState = function(number, areaEnumObject, newState) {
			self.teeth[number][areaEnumObject.stateField] = newState;
		};
		
	};
	
	
	/**
	 * Menadżer komponentów aplikacji. Wszystkie operacje zbiera do kupy.
	 */
	ComponentManager = function(patientId) {
		var self = this;
		
		this.patientId = patientId;
		this.currentToothNumber = null;
		
		/** widżet z mapą uzębienia */
		this.toothMapWidget = new ToothMapWidget(this);
		
		/** wrapper na obiekt wizyty */
		this.visitWrapper = new VisitWrapper(patientId);
		
		/** wrapper na słowniki */
		this.dictManager = new DictionaryManager();
		
		/** Wybranie nowego zęba */
		this.selectTooth = function(toothNumber) {
			if (self.currentToothNumber != null)
				self.toothMapWidget.toggleSelected(self.currentToothNumber);
			self.currentToothNumber = toothNumber;
			self.toothMapWidget.toggleSelected(self.currentToothNumber);
		};
		
		/** inicjalizacja */
		this.initialize = function() {
			self.toothMapWidget.createTeethMapUi();
			self.toothMapWidget.registerEventHandlers();
			self.dictManager.loadDictionaries(function(){
				$('#destination').append(JSON.stringify(self.dictManager.visitActivities)).append("<br/><br/>");
				$('#destination').append(JSON.stringify(self.dictManager.toothActivities)).append("<br/><br/>");
				$('#destination').append(JSON.stringify(self.dictManager.toothStates)).append("<br/><br/>");
				
				self.visitWrapper.prepareNewVisit(function(){
					
					/* >>>>>>>>>>>>>>  TODO wywalić - PONIŻSZE INSTRUKCJE SŁUŻĄ DO TESTÓW */
	
					var someActivity = {"activityId": 1};
					var someActivity2 = {"activityId": 2};
					var someState = {"toothStateId": 1};
					var someState2 = {"toothStateId": 2};
					
					
					$('#destination').append(JSON.stringify(self.visitWrapper.teeth[11]));
					$('#addToothActivity').click(function(){
						self.visitWrapper.addToothActivity(11, someActivity);
						self.visitWrapper.addToothActivity(11, someActivity2);
						$('#destination').html(JSON.stringify(self.visitWrapper.teeth[11]));
					});
					$('#removeToothActivity').click(function(){
						self.visitWrapper.removeToothActivity(11, someActivity);
						$('#destination').html(JSON.stringify(self.visitWrapper.teeth[11]));
					});
					$('#addToothState').click(function(){
						self.visitWrapper.setToothState(11, ToothPart.AREA_5, someState);
						self.visitWrapper.setToothState(11, ToothPart.AREA_5, someState2);
						self.visitWrapper.setToothState(11, ToothPart.AREA_4, someState);
						self.visitWrapper.setToothState(11, ToothPart.WHOLE_TOOTH, someState2);
						$('#destination').html(JSON.stringify(self.visitWrapper.teeth[11]));
					});
					$('#clearToothState').click(function(){
						self.visitWrapper.setToothState(11, ToothPart.AREA_5, null);
						$('#destination').html(JSON.stringify(self.visitWrapper.teeth[11]));
					});
					
					$('#postTest').click(function(){
						self.visitWrapper.setComments("Komentarz do wizyty!");
						self.visitWrapper.addVisitActivity({"activityId": 1});
						$('#destination').html(JSON.stringify(self.visitWrapper.visitObj));
						$('#destination').append("<br/><br/>");
						self.visitWrapper.sendVisit(function(text){
							$('#destination').append(text);	
						});
					});
					
					/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
						
				});
			});
		};
	};
	
	
	manager = new ComponentManager(13);
	
	$(document).ready(function() {
		manager.initialize();
	});

</script>
	
</head>
<body>

	<!--  >>>>>>>>>>>>>>  TODO wywalić - PONIŻSZE INSTRUKCJE SŁUŻĄ DO TESTÓW
	 -->
	
	<div style="border: solid;">
		<button id="postTest">send</button>
		<button id="addToothActivity">add tooth activity</button>
		<button id="removeToothActivity">remove tooth activity</button>
		<button id="addToothState">add tooth state</button>
		<button id="clearToothState">clear tooth state</button>
		
		<br />
		
		<span id="destination"></span>
	</div>
	<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< -->

	<!-- Okno dialogowe z pytaniem o potwierdzenie wykonania operacji -->
	<div id="dialog-confirm" style="display: none">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="dialog-confirm-question"></span>
		</p>
	</div>
	
	<!-- Okno dialogowe w przypadku sukcesu -->
	<div id="success-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-check" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="success-message-text"></span>
		</p>
	</div>
	
	<!-- Okno dialogowe w przypadku błędu -->
	<div id="error-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-close" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="error-message-text"></span>
		</p>
	</div>

	<!-- Właściwa treść -->


	<%@ include file="/WEB-INF/include/body-top.jsp"%>
	<div id="body-container">
	
		<%@ include file="/WEB-INF/include/body-nav.jsp"%>
		<div id="body-content">
			
			<h1>Nowa wizyta: <c:out	value="${patient.surname}" /> <c:out value="${patient.name}" /></title></h1>		
			
			
			<div class="ui-teeth-map" id="ui-teeth-map">
				<h3>Zęby stałe</h3>
				<div class="permanent" id="ui-teeth-map-permanent">
					<div class="top"></div>
					<div class="bottom"></div>
				</div>
				<h3>Zęby mleczne</h3>
				<div class="deciduous" id="ui-teeth-map-deciduous">
					<div class="top"></div>
					<div class="bottom"></div>
				</div>
			</div>
						
			<div id="selected-tooth-div">
				
				<h3>Wybierz ząb lub jego powierzchnię</h3>
				
				Połącz powierzchnie:
					<input type="checkbox" id="is-whole-tooth-selected"/>
				<div id="selected-tooth-map">
					
				</div>
				
				<h3>Wybrany ząb:
					<span id="selected-tooth-number">12</span>,
					powierzchnia:
					<span id="selected-tooth-surface">wszystkie</span>
				</h3>
				
				Obecny stan:
				<select>
					<option>stan1</option>
					<option>stan2</option>
					<option>stan3</option>
					<option>stan4</option>
				</select>
				
			</div>
			
			<div id="modify-form-div">
				<h3>Dodaj czynność związaną z wybranym zębem</h3>
				<select>
					<option>Czynność 1, cena: 500 zł</option>
					<option>Czynność 2, cena: 500 zł</option>
					<option>Czynność 3, cena: 500 zł</option>
					<option>Czynność 4, cena: 500 zł</option>
					<option>Czynność 5, cena: 500 zł</option>
				</select>
				<button value="Dodaj" title="Dodaj">Dodaj czynność</button>
			</div>
			
			<div id="list-activities">
				<h3>Lista dodanych czynności</h3>
				<ul>
					<li> Ząb: 23, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 33, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 24, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 53, powierzchnia: żująca, czynność: plomba</li>
				</ul>
			</div>
			
		</div>
	</div>
	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

