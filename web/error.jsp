<%-- 
    Document   : error
    Created on : Jun 22, 2021, 11:27:38 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Lỗi</title>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />

    </head>
    <body>
        <div style="margin-top: 20px; margin-left: 10%;">
            <font color="red">
            <h1>Rất tiếc, có lỗi đã xảy ra</h1>
            <h2>${requestScope.ERROR.errorServlet}</h2>
            <p>${requestScope.ERROR_PAGE.errorDetail}</p>
            </font> <br/>
            <a href="DispatchServlet" class="btn btn-danger">Trở Về Trang Chủ</a>
        </div>
    </body>
</html>
