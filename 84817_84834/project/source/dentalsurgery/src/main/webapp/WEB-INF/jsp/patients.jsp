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
	
	/**
	 * Usuwa pacjenta; przed usunięciem wyświetla okno dialogowe z pytaniem
	 */
	function deletePatient(deleteUrl) {
		 $("#dialog-confirm-question").html(
				 "Czy na pewno chcesz usunąć wskazanego pacjenta? Usuniesz całą historię wizyt i inne powiązane dane."
		 );
		 $("#dialog-confirm").dialog({
			 	title: "Usunąć pacjenta?",
				resizable: false,
				width:500,
				modal: true,
				buttons: {
					"Usuń mimo to": function() {
						$( this ).dialog( "close" );
						
						$.post(deleteUrl)
						    .success(function() { 
						    	successMessage(
						    			"Pacjent usunięty", 
						    			"Udało się z powodzeniem usunąć pacjenta wraz ze wszystkimi danymi.", 
						    			function(){
						    				window.location.reload();						    			
						    			}); 
						    	})
							.error(function() { 
								errorMessage(
										"Błąd podczas usuwania", 
										"<strong>Pacjent nie został usunięty!</strong> Proszę spróbować później.");
							});
					},
					"Anuluj": function() {
						$( this ).dialog( "close" );
					}
				}
		});
	}
	 
	 /**
	  * Wyświetla szczegółowe informacje na temat wybranego pacjenta
	  */
	function loadPatientInfo(url) {
		 
	}	 
	
</script>

<style type="text/css">
	
	#patient-list {
		text-align: right;
		width: 300px;
	}
	
	.icon-operation {
	float: right; margin: 0px;
	}
	
</style>

</head>
<body>

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



	<div id="body-top" class="ui-corner-top">
		<h1>Dental Surgery</h1>
	</div>

	<div id="body-container">
		<div id="body-nav">
			<a href="<c:url value="/patients/new" />">Nowy pacjent</a> <br /> 
			<a href="<c:url value="/patients" />">Kartoteka</a> <br />
		</div>

		<div id="body-content">
			<h1>Lista pacjentów</h1>

						
				<table id="patient-list" border="0">
					
					<thead>
						<tr> <th>Imię i nazwisko</th><th>Operacje</th></tr>
					</thead>
				
					<c:forEach items="${patientList}" var="patient">
						<s:url value="/patients/${patient.patientId}/delete" var="deleteUrl"/>
						<s:url value="/patients/${patient.patientId}" var="patientInfoUrl"/>
						<s:url value="/patients/${patient.patientId}/edit" var="editUrl"/>
						<s:url value="/patients/${patient.patientId}/visits/add" var="editUrl"/>
						<tr> 
							<td> 
								<a href="#" title="Pokaż informacje o pacjencie" onclick="loadPatientInfo('${patientInfoUrl}')">
									<c:out value="${patient.name}" /> <c:out value="${patient.surname}" /> 
								</a>
							</td>
							<td> 
								
								
								<a href="#" title="Pokaż informacje o pacjencie" onclick="loadPatientInfo('${patientInfoUrl}')">
									<span class="ui-icon ui-icon-info icon-operation" ></span>
								</a>
								<a href="#" title="Przeglądaj wizyty pacjenta" onclick="addVisit('${addVisitUrl}')" >
									<span class="ui-icon ui-icon-folder-collapsed icon-operation" ></span>
								</a>
								<a href="#" title="Dodaj nową wizytę" onclick="addVisit('${addVisitUrl}')" >
									<span class="ui-icon ui-icon-circle-plus icon-operation" ></span>
								</a>
								<a href="#" title="Usuń pacjenta" onclick="deletePatient('${deleteUrl}')" >
									<span class="ui-icon ui-icon-trash icon-operation" ></span>
								</a>
								<a href="${editUrl}" title="Edytuj pacjenta"  >
									<span class="ui-icon ui-icon-pencil icon-operation" ></span>
								</a>
								
							</td>
						</tr>
					</c:forEach>
				</table>
		</div>
	</div>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by Kamiński &amp; Kuć</div>

</body>
</html>

