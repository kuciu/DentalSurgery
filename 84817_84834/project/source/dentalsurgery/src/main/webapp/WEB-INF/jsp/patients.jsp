<%@ include file="/WEB-INF/jsp/include.jsp"%>

<html>
<head>
<title><fmt:message key="title" /></title>
</head>
<body>
	<h1>
		Pacjenci
		<fmt:message key="title" />
		!
	</h1>
	<p>Lista pacjentów
	<ul>
		<c:forEach items="${patientList}" var="entity">
			<li>Obiekt <c:out value="${entity.patientId}" />: <c:out
					value="${entity.name}" /> <c:out value="${entity.name}" /> <c:out
					value="${entity.street}" />
				<c:forEach items="${entity.phoneNumbers}" var="phoneNumber">
					<c:out value="${phoneNumber.number }" />
				</c:forEach>
			</li>
		</c:forEach>
	</ul>

	</p>
</body>
</html>
