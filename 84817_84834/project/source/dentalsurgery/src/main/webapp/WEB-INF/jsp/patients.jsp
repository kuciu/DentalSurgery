<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dental Surgery | Lista pacjentów</title>
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet"
	type="text/css" />
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery-ui-1.8.20.custom.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
<script type="text/javascript">
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

	/**
	 * Usuwa pacjenta; przed usunięciem wyświetla okno dialogowe z pytaniem
	 */
	function deletePatient(deleteUrl) {
		$("#dialog-confirm-question")
				.html(
						"Czy na pewno chcesz usunąć wskazanego pacjenta? Usuniesz całą historię wizyt i inne powiązane dane.");
		$("#dialog-confirm")
				.dialog(
						{
							title : "Usunąć pacjenta?",
							resizable : false,
							width : 500,
							modal : true,
							buttons : {
								"Usuń mimo to" : function() {
									$(this).dialog("close");

									$
											.post(deleteUrl)
											.success(
													function() {
														successMessage(
																"Pacjent usunięty",
																"Udało się z powodzeniem usunąć pacjenta wraz ze wszystkimi danymi.",
																function() {
																	window.location
																			.reload();
																});
													})
											.error(
													function() {
														errorMessage(
																"Błąd podczas usuwania",
																"<strong>Pacjent nie został usunięty!</strong> Proszę spróbować później.");
													});
								},
								"Anuluj" : function() {
									$(this).dialog("close");
								}
							}
						});
	}

	/**
	 * Wyświetla szczegółowe informacje na temat wybranego pacjenta
	 */
	function loadPatientInfo(url) {
		$.getJSON(url, function(data) {
			name = data['name'];
			surname = data['surname'];
			city = data['city'];
			bornDate = data['bornDate'];
			gender = data['gender'];
			pesel = data['pesel'];
			street = data['street'];
			phoneNumbers = data['phoneNumbers'];
			medications = data['medications'];
			illnesses = data['illnesses'];

			$('#name-label').text(name);
			$('#surname-label').text(surname);
			$('#city-label').text(city);
			$('#bornDate-label').text(bornDate);
			$('#pesel-label').text(pesel);
			$('#street-label').text(street);
			if (gender == 'M') {
				$('#gender-label').text("Mężczyzna");
			} else if (gender == 'K') {
				$('#gender-label').text("Kobieta");
			}

			$('#phonesList').empty();

			jQuery.each(phoneNumbers, function(i, val) {
				$('#phonesList').append("<li>" + val['number'] + "</li>");
			});

			$('#medicationsList').empty();

			jQuery.each(medications, function(i, val) {
				$('#medicationsList').append("<li>" + val['name'] + "</li>");
			});

			$('#illnessList').empty();

			jQuery.each(illnesses, function(i, val) {
				$('#illnessList').append("<li>" + val['name'] + "</li>");
			});

			$('#patient-info-border').show();
		}).error(
				function() {
					errorMessage("Błąd podczas pobierania danych",
							"Proszę spróbować później.");
				});
	}

	function hideDetails() {
		$('#patient-info-border').hide();
	}

	function afterLoad() {
		$('#patient-info-border').hide();
	}
</script>

<style type="text/css">
#patient-list {
	text-align: right;
	width: 300px;
}

.icon-operation {
	float: right;
	margin: 0px;
}

#patient-list {
	text-align: right;
	width: 300px;
}

.icon-operation {
	float: right;
	margin: 0px;
}

#body-content { /*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

#patient-list-border {
	float: left;
	width: 370px;
	/*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

#patient-info-border {
	float: right;
	width: 430px;
	/*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

#patient-info-border table {
	margin-top: 2px;
	text-align: left;
}

#patient-info-border table tr td:first-child {
	vertical-align: top;
	padding-right: 10px;
	color: #80C2FF;
}

#patient-info-border table tr td:nth-child(2) {
	font-style: italic;
	color: #D9B36C;
}
</style>

</head>
<body>

	<!-- Okno dialogowe z pytaniem o potwierdzenie wykonania operacji -->
	<div id="dialog-confirm" style="display: none">
		<p>
			<span class="ui-icon ui-icon-alert"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="dialog-confirm-question"></span>
		</p>
	</div>

	<!-- Okno dialogowe w przypadku sukcesu -->
	<div id="success-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-check"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="success-message-text"></span>
		</p>
	</div>

	<!-- Okno dialogowe w przypadku błędu -->
	<div id="error-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-close"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="error-message-text"></span>
		</p>
	</div>



	<div id="body-top" class="ui-corner-top">
		<h1>Dental Surgery</h1>
	</div>

	<div id="body-container">
		<div id="body-nav">
			<a href="<c:url value="/patients/new" />">Nowy pacjent</a> <br /> <a
				href="<c:url value="/patients" />">Kartoteka</a> <br />
		</div>

		<div id="body-content">
			<h1>Lista pacjentów</h1>
			<div id="patient-details"></div>
			<div id="patient-list-border">
				<table id="patient-list" border="0">

					<thead>
						<tr>
							<th>Imię i nazwisko</th>
							<th>Operacje</th>
						</tr>
					</thead>

					<c:forEach items="${patientList}" var="patient">
						<tr>
							<td><c:out value="${patient.name}" /> <c:out
									value="${patient.surname}" /></td>
							<td><s:url value="/patients/${patient.patientId}/delete"
									var="deleteUrl" /> <s:url
									value="/patients/${patient.patientId}" var="patientInfoUrl" />
								<s:url value="/patients/${patient.patientId}/edit" var="editUrl" />
								<a href="#" onclick="loadPatientInfo('${patientInfoUrl}')">
									<span class="ui-icon ui-icon-info icon-operation"></span>
							</a> <a href="#" onclick="deletePatient('${deleteUrl}')"> <span
									class="ui-icon ui-icon-trash icon-operation"></span>
							</a> <a href="${editUrl}"> <span
									class="ui-icon ui-icon-pencil icon-operation"></span>
							</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div id="patient-info-border">

				<table>
					<thead>
						<tr>
							<th colspan="2">Szczegółowe informacje</th>
						</tr>
					</thead>
					<tr>
						<td>Imię i nazwisko:</td>
						<td><label id="name-label"></label> <label id="surname-label"></label></td>
					</tr>
					<tr>
						<td>PESEL:</td>
						<td><label id="pesel-label"></label></td>
					</tr>
					<tr>
						<td>Płeć:</td>
						<td><label id="gender-label"></label></td>
					</tr>
					<tr>
						<td>Data urodzenia:</td>
						<td><label id="bornDate-label"></label></td>
					</tr>
					<tr>
						<td>Adres zamieszkania:</td>
						<td><label id="street-label"></label> <br /> <label
							id="city-label"></label><br /></td>
					</tr>
					<tr>
						<td>Nr telefonu:</td>
						<td>
							<ul id="phonesList"></ul>
						</td>
					</tr>
					<tr>
						<td>Choroby pacjenta:</td>
						<td>
							<ul id="illnessList"></ul>
						</td>
					</tr>
					<tr>
						<td>Przyjmowane leki</td>
						<td>
							<ul id="medicationsList"></ul>
						</td>
					</tr>
				</table>
				<input type="button" value="Ukryj" onclick="hideDetails()" />
			</div>
		</div>
	</div>

	</div>
	<script>
		window.onload = afterLoad;
	</script>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by
		Kamiński &amp; Kuć</div>

</body>
</html>

