<%@ include file="/WEB-INF/jsp/include.jsp"%>

<html>
<head>
<title><fmt:message key="title" /></title>
</head>
<body>
	<h1>
		Witaj w systemie <fmt:message key="title" />!
	</h1>
	<p>
		Hello!! Oto napis zapisany w modelu:
		<c:out value="${someString}"></c:out>
		<br /> Oto lista obiektów z bazy danych:
	<ul>
		<c:forEach items="${entityList}" var="entity">
			<li>Obiekt <c:out value="${entity.id}" />: 
					<c:out value="${entity.someText}" />,
					<fmt:formatDate value="${entity.someDate}" pattern="dd-mm-yyyy"/>,
					<c:out value="${entity.someNumber}" />
			</li>
		</c:forEach>
	</ul>

	</p>
</body>
</html>
