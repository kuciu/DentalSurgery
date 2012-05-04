<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dental Surgery | Dodaj pacjenta</title>
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

$(document).ready(function() {
	
	$('.datepicker').datepicker();
	$('button').button();
});

</script>	
	
</head>
<body>

	<div id="body-top" class="ui-corner-top">
		<h1>Dental Surgery</h1>
	</div>

	<div id="body-container">


		<div id="body-nav">
			<a href="#">Kartoteka</a> <br /> <a href="#">Nowy pacjent</a> <br />
			<a href="#">Ustawienia</a> <br /> <a href="#">O aplikacji</a> <br />
		</div>

		<div id="body-content">

			<h2>Dodawanie nowego pacjenta</h2>
			

				<form:form commandName="patient"  method="post">

					<table border="0px">
						<tr>
							<td>Imię:</td>
							<td><form:input path="name" /></td>
						</tr>
						<tr>
							<td>Nazwisko:</td>
							<td><form:input path="surname" /></td>
						</tr>
						
						<tr>
							<td>Ulica:</td>
							<td><form:input path="street" /></td>
						</tr>
						
						<tr>
							<td>Miasto:</td>
							<td><form:input path="city" /></td>
						</tr>
						
						
<!-- 						<tr> -->
<!-- 							<td>Data urodzenia:</td> -->
<%-- 							<td><form:input path="bornDate" cssClass="datepicker" /></td> --%>
<!-- 						</tr> -->
						
						<tr>
							<td colspan="2">
								<form:button>Utwórz</form:button>
							</td>

					</table>

				</form:form>

			<div class="ui-widget" style="display: none">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
					<p>
						<span class="ui-icon ui-icon-alert"
							style="float: left; margin-right: .3em;"></span> Sample
						ui-state-error style.

					</p>
				</div>
			</div>

		</div>

	</div>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by
		Kamiński &amp; Kuć</div>
</body>
</html>

