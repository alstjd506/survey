<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Survey List</title>
</head>
<body>
    <h1>Survey List</h1>
    <c:forEach items="${list}" var="item">
        <div>
            <span>${item.employeeId}</span>

        </div>
    </c:forEach>
</body>
</html>