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
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery.ui.selectmenu.css" />"
	rel="stylesheet" type="text/css" />	
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery.ui.selectmenu.js" />"></script>
	
	
	
<link href="<c:url value="/resources/css/visit.css" />" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/js/visit-common.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/DictionaryManager.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/VisitWrapper.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/ToothMapWidget.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/ToothPartWidget.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/ToothStateWidget.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/ToothActivityWidget.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/VisitActivityWidget.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/ActivityTableWidget.js" />"></script>
<script type="text/javascript">


	/**
	 * Menadżer komponentów aplikacji. Wszystkie operacje zbiera do kupy.
	 */
	ComponentManager = function(patientId) {
		var self = this;
		
		this.patientId = patientId;
		this.currentToothNumber = null;
		this.currentToothPart = null;
		
		/** widżet z mapą uzębienia */
		this.toothMapWidget = new ToothMapWidget(this);
		
		/** widżet z listą części zęba */
		this.toothPartWidget = new ToothPartWidget(this);
		
		/** lista opcji ze stanami zęba/powierzchni */
		this.toothStateWidget = new ToothStateWidget(this);
		
		/** lista opcji z czynnościami zęba/powierzchni */
		this.toothActivityWidget = new ToothActivityWidget(this);
		
		/** lista opcji z czynnościami wizyty */
		this.visitActivityWidget = new VisitActivityWidget(this);
		
		/** tabelka z dodanymi czynnościami */
		this.activityTableWidget = new ActivityTableWidget(this);
		
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
			$('#selected-tooth-number').text(self.currentToothNumber);
			// wybieramy pierwszą powierzchnię, na której coś jest
			var areaState = null
			for (var areaKey in ToothParts) {
				areaState = self.visitWrapper.getToothState(
						self.currentToothNumber, ToothParts[areaKey]);
				if (areaState != null) {
					self.selectToothPart(ToothParts[areaKey]);
					break;
				}
			}
			// jeśli nic nie jest ustawione, wybieramy cały ząb
			if (areaState == null) {
				self.selectToothPart(ToothParts.AREA_0);
			}
		};
		
		/** Wybranie nowej powierzchni */
		this.selectToothPart = function(toothPart) {
			if (self.currentToothNumber == null) {
				errorMessage("Wybierz ząb", "Musisz wybrać ząb przed wybraniem jego powierzchni!");
				return;
			}
			if (self.currentToothPart != null)
				self.toothPartWidget.toggleSelected(self.currentToothPart);
			self.currentToothPart = toothPart;
			self.toothPartWidget.toggleSelected(self.currentToothPart);
			
			var toothState = self.visitWrapper.
				getToothState(self.currentToothNumber, self.currentToothPart);
			// odczytanie stanu
			self.toothStateWidget.selectState(toothState);
			if (toothPart == ToothParts.AREA_0) {
				self.toothStateWidget.enableWholeToothStates();
			} else {
				self.toothStateWidget.disableWholeToothStates();
			}
			$('#selected-tooth-area').text(self.currentToothPart.description);
			self.updateToothPartsColors();
		};
		
		/** Wybranie nowego stanu przez użytkownika */
		this.changeState = function(toothState) {
			if (self.currentToothNumber != null && 
					self.currentToothPart != null) {
				// zapisanie stanu
				self.visitWrapper.setToothState(self.currentToothNumber,
						self.currentToothPart, toothState);
				// aktualizacja kolorów
				self.updateToothMapColors();
				self.updateToothPartsColors();
			} else {
				errorMessage("Wybierz ząb i powierzchnię", "Musisz wybrać ząb oraz jego powierzchnię, aby zmienić jego stan!");
				self.toothStateWidget.selectState(null);
				return;
			}
		};
		
		
		/** 
		 * usunięcie czynności (zęba lub wizyty) 
		 * @params params parametry dotyczące usuwanej czynności
		 * Np.:		
		 * 		param = {
		 * 			type: "tooth",
		 *			[toothNumber: 23],
		 * 			rowId: "tooth-12-23",
		 * 			activity: toothActivity,
		 * 			scope: "Ząb nr 23"
		 * 		}		
		 */
		this.removeActivity = function(params) {
			switch (params.type) {
						
				case "tooth":
							self.visitWrapper.removeToothActivity(params.toothNumber, params.activity);
							self.updateToothMapColors();
							break;
				case "visit": 
							self.visitWrapper.removeVisitActivity(params.activity);
							break;
			}
		};
		

		/** Dodanie wybranej czynności dla konkretnego zęba/powierzchni */
		this.addToothActivity = function(toothActivity) {
			if (self.currentToothNumber != null) {
				if (self.visitWrapper.hasToothActivity(self.currentToothNumber, toothActivity))  {
					errorMessage("Czynność już istnieje", "Nie możesz ponownie dodać tej samej czynności!");
					return;
				}
				// dodanie czynności związanej z zębem
				self.visitWrapper.addToothActivity(self.currentToothNumber, toothActivity);
				// aktualizacja kolorów
				self.updateToothMapColors();
				// aktualizacja tabelki
				self.activityTableWidget.addActivityRow({
					type: "tooth",
					toothNumber: self.currentToothNumber,
					scope: (toothActivity.allTooth?"cały ":"")+"ząb "+self.currentToothNumber,
					activity: toothActivity
				});
			} else {
				errorMessage("Wybierz ząb", "Musisz wybrać ząb, aby dodać związaną z nim czynność!");
				return;
			}
		};
		
		/** dodaje czynność związaną z wizytą */
		this.addVisitActivity = function(visitActivity) {
			if (self.visitWrapper.hasVisitActivity(visitActivity))  {
				errorMessage("Czynność już istnieje", "Nie możesz ponownie dodać tej samej czynności!");
				return;
			}
			// dodanie czynnosci do obiektu wizyty
			self.visitWrapper.addVisitActivity(visitActivity);
			// aktualizacja tabelki
			self.activityTableWidget.addActivityRow({
				type: "visit",
				toothNumber: null,
				scope: "nie dotyczy",
				activity: visitActivity
			});
		};
		
		
		
		/** aktualizuje kolory zębów na mapie */
		this.updateToothMapColors = function() {
			for ( var teethType in TeethNumbers) {
				for ( var teethSide in TeethNumbers[teethType]) {
					for ( var toothNumberKey in TeethNumbers[teethType][teethSide]) {
						var toothNumber = TeethNumbers[teethType][teethSide][toothNumberKey];
						var hasAnyToothState = self.visitWrapper
								.hasAnyToothState(toothNumber);
						var hasAnyToothActivity = self.visitWrapper
								.hasAnyToothActivity(toothNumber);
						if (hasAnyToothState) {
							if (hasAnyToothActivity) {
								self.toothMapWidget.changeColor(toothNumber,
										Colors.BLUE);
							} else {
								self.toothMapWidget.changeColor(toothNumber,
										Colors.RED);
							}
						} else {
							if (hasAnyToothActivity) {
								self.toothMapWidget.changeColor(toothNumber,
										Colors.GREEN);
							} else {
								self.toothMapWidget.changeColor(toothNumber,
										Colors.WHITE);
							}
						}
					}
				}
			}
		};

		/** aktualizuje kolory powierzchni zęba na liście */
		this.updateToothPartsColors = function() {
			if (self.currentToothNumber != null) {
				for ( var areaKey in ToothParts) {
					var areaState = self.visitWrapper.getToothState(
							self.currentToothNumber, ToothParts[areaKey]);
					if (areaState != null) {
						self.toothPartWidget.changeColor(ToothParts[areaKey],
								Colors.RED);
					} else {
						self.toothPartWidget.changeColor(ToothParts[areaKey],
								Colors.WHITE);
					}
				}
			}
		};

		/** inicjalizacja */
		this.initialize = function() {
			self.toothMapWidget.createTeethMapUi();
			self.toothMapWidget.registerEventHandlers();
			self.toothPartWidget.createListOfPartsUi();
			self.toothPartWidget.registerEventHandlers();

			self.dictManager
					.loadDictionaries(function() {
						self.toothStateWidget
								.createToothStateUi(self.dictManager.toothStates);
						self.toothActivityWidget
								.createToothActivityUi(self.dictManager.toothActivities);
						self.visitActivityWidget
								.createVisitActivityUi(self.dictManager.visitActivities);

						self.visitWrapper
								.prepareNewVisit(function() {

									self.updateToothMapColors();
									self.updateToothPartsColors();


								});
					});
		};
	};

	

	$(document).ready(function() {
		var patientId = $('#patientId').text();
		manager = new ComponentManager(patientId);
		manager.initialize();
	});
</script>
	
</head>
<body>
	<span id="patientId" style="display: none"><c:out value="${patientId}"/></span>

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
				
				<h3>Powierzchnia zęba</h3>
				
				<ul class="selected-part-list" id="selected-part-list"></ul> 
				
				
				<h3>Wybrany ząb: 
					<span id="selected-tooth-number">(brak)</span>,
					powierzchnia: 
					<span id="selected-tooth-area">(brak)</span>
				</h3>

				Obecny stan:
					
				<select name="selected-tooth-state" id="selected-tooth-state">
					<option value="null" selected="selected">Zdrowy</option>
				</select>
				

			</div>
			
			<div id="modify-form-div">
				
				<h3>Komentarz lekarza</h3>
				<textarea></textarea>
			</div>
			
			<div id="add-activities-form">
				<h3>Dodaj czynność związaną z wybranym zębem</h3>
				
				<select name="selected-tooth-activity" id="selected-tooth-activity">
				</select>
				<button id="add-tooth-activity-button">Dodaj</button>
				
				<h3>Dodaj czynność związaną z wizytą</h3>
				
				<select name="select-visit-activity" id="select-visit-activity">
				</select>
				<button id="add-visit-activity-button">Dodaj</button>
			</div>
			
			<div id="list-activities">
				<h3>Lista wykonanych czynności</h3>
				
				<table id="list-activities-table" >
					<thead>
						<th>Zasięg</th><th>Czynność</th><th>Cena</th><th>Operacje</th>
					</thead>
					<!-- 
					<tr >
						<td>Ząb nr 23</td>
						<td>Usunięcie zęba</td>
						<td>80 zł
						<td>
							<a href="#" title="Usuń czynność"
								onclick="alert('usunieto')"> <span
									class="ui-icon ui-icon-trash icon-operation"></span>
							Usuń
							</a> 
						</td> 
					</tr>
					 -->
				
				</table>
			</div>
			
			<div id="send-visit-form">
			
				<script >
					$(document).ready(function(){

						$('#save-visit-button').button();
					});
				</script>
				<h3>Ustaw datę wizyty</h3>
				<input type="text"/>
				<button id="save-visit-button" style="margin-left:300px;margin-bottom:50px">Zapisz wizytę</button>
				
			</div>
			
		</div>
	</div>
	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

