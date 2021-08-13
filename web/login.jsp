<%-- 
    Document   : login
    Created on : Jun 4, 2021, 9:46:08 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Đăng Nhập</title>
        <link rel="stylesheet" href="./css/login.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    </head>
    <body>
        <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
            <c:redirect url="DispatchServlet" />
        </c:if>
        <h1 style="text-align: center;">Đăng Nhập Vào Nhà Sách</h1>
        <div class="table-login">
            <form action="DispatchServlet" method="POST">
                <table class="table" border="0">
                    <tbody>
                        <tr>
                            <td>Tài Khoản: </td>
                            <td>
                                <input class="form-control" type="text" name="txtUsername" value="${param.txtUsername}" />
                            </td>
                        </tr>
                        <tr>
                            <td>Mật Khẩu: </td>
                            <td>
                                <input class="form-control" type="password" name="txtPassword" value="" />
                            </td>
                        </tr>
                        <c:if test="${requestScope.LOGINSTATUS != null}">
                            <tr>
                                <td colspan="2">
                                    <font color="red">
                                    ${requestScope.LOGINSTATUS}
                                    </font>
                                </td>
                            </tr> 
                        </c:if>
                        <tr>
                            <td class="text-center" colspan="2">
                                <button class="btn btn-primary" type="submit" name="action" value="Login">Đăng Nhập</button>
                                <button class="btn btn-info" type="submit" name="action" value="SearchBook">Trở Về Trang Chủ</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
