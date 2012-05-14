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
		$('#addAttachmentForm').get(0).setAttribute('action', url);
		$('#visit-add-attachment').show();
	}

	function afterLoad() {
		$('#visit-add-attachment').hide();
	}
</script>

<style type="text/css">
#body-content { /*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

.icon-operation {
	float: right;
	margin: 0px;
}

#visit-list-border {
	float: left;
	width: 250px;
	/*border: solid;*/
	min-height: 80px;
	border-width: 1px;
	border-color: #80C2FF;
	border-width: 1px;
}

#visit-add-attachments {
	float: right;
	width: 430px;
	/*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

#visit-list {
	text-align: right;
	width: 250px;
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
					<c:forEach items="${visits}" var="visit">
						<s:url
							value="/patients/${patient.patientId}/visits/${visit.visitId}/addAttachment"
							var="addAttachmentUrl" />
						<tr>
							<td><c:out value="${visit.date}" /></td>
							<td><a href="#" title="Dodaj załącznik"
								onclick="showAddAttachment('${addAttachmentUrl}')"><span
									class="ui-icon ui-icon-disk icon-operation"></span></a> <a href="#"
								title="Pokaż załączniki"><span
									class="ui-icon ui-icon-disk icon-operation"></span></a> <a href="#"
								title="Pokaż wizytę"><span
									class="ui-icon ui-icon-disk icon-operation"></span></a></td>
						</tr>
					</c:forEach>
					<tr>
						<td>to remove</td>
						<td><a href="#" onclick="showAddAttachment('1')"><span
								class="ui-icon ui-icon-disk icon-operation"></span></a> <a href="#"
							title="Pokaż załączniki"><span
								class="ui-icon ui-icon-disk icon-operation"></span></a> <a href="#"
							title="Pokaż wizytę"><span
								class="ui-icon ui-icon-disk icon-operation"></span></td>
					</tr>
				</table>
			</div>
			<div id="visit-add-attachment">
				<form:form modelAttribute="uploadItem" method="post"
					enctype="multipart/form-data"
					action="/patients/9/visits/13/addAttachment" id="addAttachmentForm">
					<form:label for="description" path="description"
						cssStyle="width: 50px; display: block; float: left;">Opis</form:label>
					<form:input path="description" />
					<br />
					<form:label for="fileData" path="fileData"
						cssStyle="width: 50px; display: block; float: left;">Plik</form:label>
					<form:input path="fileData" type="file" />
					<br />
					<input type="submit" value="Dodaj" />
				</form:form>
				<input type="button" value="Ukryj" onclick="hideAddAttachment()" />
			</div>

		</div>
	</div>

	<script>
		window.onload = afterLoad;
	</script>

	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

