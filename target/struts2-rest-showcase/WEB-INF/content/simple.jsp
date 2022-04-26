<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>Hello World</title>
</head>
<body>
    <%
        //Prints out to HTML page
        out.println("<h1>Hello World!</h1>");
    %>
    <a href="${pageContext.request.contextPath}/page2">
        Next page
    </a>
</body>
</html>