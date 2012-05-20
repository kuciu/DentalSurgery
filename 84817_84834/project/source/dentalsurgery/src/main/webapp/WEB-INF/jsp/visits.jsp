<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Dental Surgery | Historia wizyt - <c:out
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

	function hideAddAttachment() {
		$('#visit-add-attachment').hide();
	}

	function showAddAttachment(url) {
		$('.attachmentsList').hide();
		$('#addAttachmentForm').get(0).setAttribute('action', url);
		$('#visit-add-attachment').show();
	}

	function afterLoad() {
		$('#visit-add-attachment').hide();
		$('.attachmentsList').hide();
	}

	function showAttachments(id) {
		$('.attachmentsList').hide();
		$('#visit-add-attachment').hide();
		$(id).show();
	}

</script>

<style type="text/css">

#visit-list-border {
	float: left;
	width: 250px;
	/*border: solid;*/
	min-height: 150px;
	border-width: 1px;
	border-color: #80C2FF;
	border-width: 1px;
}

#visit-add-attachment {
	float: right;
	width: 430px;
	margin-left: 30px;
	/*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

#visit-list {
	text-align: right;
	width: 250px;
}

.attachmentsList {
	float: right;
	width: 430px;
	border-width: 1px;
	border-color: #80C2FF;
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

	<!-- Właściwa treść -->

	<%@ include file="/WEB-INF/include/body-top.jsp"%>
	<div id="body-container">

		<%@ include file="/WEB-INF/include/body-nav.jsp"%>
		<div id="body-content">
			<c:if test="${message != null }">
				<div class="ui-widget">
					<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
						<p>
							<span class="ui-icon ui-icon-alert"
								style="float: left; margin-right: .3em;"></span>
							<c:out value="${message}" />
						</p>
					</div>
				</div>
			</c:if>
			<h1>
				Historia wizyt:
				<c:out value="${patient.surname}" />
				<c:out value="${patient.name}" />

			</h1>
			<div id="visit-list-border">
				<table id="visit-list" border="0">
					<thead>
						<tr>
							<th>Data</th>
							<th>Operacje</th>
						</tr>
					</thead>
					<c:forEach items="${patient.visits}" var="visit">
						<s:url
							value="/patients/${patient.patientId}/visits/${visit.visitId}/addAttachment"
							var="addAttachmentUrl" />
						<s:url
							value="/patients/${patient.patientId}/visits/${visit.visitId}/show"
							var="showVisitUrl" />

						<tr>
							<td><c:out value="${visit.visitDate}" /></td>
							<td><a href="#" title="Dodaj załącznik"
								onclick="showAddAttachment('${addAttachmentUrl}')"><span
									class="ui-icon ui-icon-disk icon-operation"></span></a> <a href="#"
								title="Pokaż załączniki"
								onclick="showAttachments('#visit-attachments-${visit.visitId }')"><span
									class="ui-icon ui-icon-folder-open icon-operation"></span></a> <a
								href="${showVisitUrl }" title="Pokaż wizytę"><span
									class="ui-icon ui-icon-info icon-operation"></span></a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div id="visit-add-attachment">
			<a href="#" title="Zamknij" onclick="hideAddAttachment()"> <span
									class="ui-icon ui-icon-close icon-operation"></span>
							</a>
							<h2>Dodaj załącznik</h2>
				
				<form:form modelAttribute="uploadItem" method="post"
					enctype="multipart/form-data"
					action="/patients/9/visits/13/addAttachment" id="addAttachmentForm">
					<form:label for="description" path="description"
						cssStyle="width: 50px; display: block; float: left;">Opis</form:label>
					<form:input path="description" />
					<br />
					<form:label for="fileData" path="fileData"
						cssStyle="width: 50px; display: block; float: left;">Plik</form:label>
					<form:input path="fileData" type="file" cssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>
					<br />
					<input type="submit" value="Dodaj" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>
				</form:form>
			</div>
			
		

			<c:forEach items="${patient.visits}" var="visit">
				<div id="visit-attachments-${visit.visitId }"
					class="attachmentsList">
								<a href="#" title="Zamknij" onclick="afterLoad()"> <span
									class="ui-icon ui-icon-close icon-operation"></span>
							</a>
					Załączniki
					<ul>
						<c:forEach items="${visit.attachments }" var="attachment">
							<s:url
								value="/patients/${patient.patientId}/visits/${visit.visitId}/attachments/${attachment.attachmentId }"
								var="getAttachmentUrl" />
							<li><c:out value="${attachment.fileName}" /><br /> Opis: <c:out
									value="${attachment.description }" /> <br /> <a
								href="${getAttachmentUrl }" rel="nofollow">Pobierz</a></li>
						</c:forEach>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>

	<script>
		window.onload = afterLoad;
	</script>

	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

