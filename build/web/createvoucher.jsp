<%-- 
    Document   : register
    Created on : Jun 4, 2021, 11:00:53 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo Voucher Mới</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="./js/createnew.js" type="text/javascript"></script>
        <link rel="stylesheet" href="./css/newVoucher.css"/>
        <script src="./js/header_bar.js"></script>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    </head>
    <body>
        <c:if test="${sessionScope.ACCOUNTDETAIL == null || sessionScope.ACCOUNTDETAIL.rolename != 'Admin'}">
            <c:redirect url="DispatchServlet" />
        </c:if>
        <div class="container">
            <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
                <a style="margin-top: -12px" href="DispatchServlet" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                    <i style="padding-right: 10px;" class="fa fa-book"></i>
                    <span class="fs-4">Book Store</span>
                </a>
                <div class="dropdown text-end" id="account-info" style="display: flex; margin-right: 15px; padding-top: 2px">
                    <c:if test="${sessionScope.ACCOUNTDETAIL == null}">
                        <span style="margin: 5px">
                            <p>Kính Chào Quý Khách</p>
                        </span>
                    </c:if>
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <span style="margin: 5px">
                            <p>Xin chào, ${sessionScope.ACCOUNTDETAIL.fullname} <img style="object-fit: cover;" src="${sessionScope.ACCOUNTDETAIL.imageLink}" alt="mdo" width="32" height="32" class="rounded-circle"></p>
                        </span>
                    </c:if>
                </div>
                <ul class="nav justify-content-center">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                            <li style="margin-right: 10px">
                                <a class="btn btn-warning" href="DispatchServlet?action=CreateNewBook">Thêm Sách Mới</a>
                            </li>
                            <li style="margin-right: 10px">
                                <a href="DispatchServlet" class="btn btn-success">Quản Lý Sách</a>
                            </li>
                        </c:if>
                        <li style="margin-right: 10px">
                            <a href="DispatchServlet?action=Logout" class="btn btn-danger">Đăng Xuất</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.ACCOUNTDETAIL == null}">
                        <li>
                            <a class="btn btn-warning" href="DispatchServlet?action=LoginPage">Đăng Nhập</a>
                        </li>
                    </c:if>
                </ul>
            </header>
        </div>
        <h1 style="text-align: center;">Thêm Phiếu Giảm Giá Mới</h1>
        <form action="DispatchServlet" method="POST" id="check-valid">
            <table class="register-form" border="0" style="margin-left: 500px;">
                <tbody>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <h6>Nhập vào đầy đủ thông tin phiếu giảm giá</h6>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Mã Giảm Giá: </td>
                        <td>
                            <input class="form-control" type="text" name="txtVoucherCode" value="${param.txtVoucherCode}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_VOUCHER.invalidDiscountCode != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_VOUCHER.invalidDiscountCode}
                                </font>
                            </td>
                        <tr>
                        </c:if>
                    <tr>
                        <td class="title-profile">Mô Tả: </td>
                        <td>
                            <textarea style="height: 200px; margin: 5px 0 5px 0;" class="form-control" placeholder="Giảm giá 20% giá trị đơn hàng..." name="txtVoucherDesc" maxlength="4000">${param.txtVoucherDesc}</textarea>
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_VOUCHER.invalidDiscountDesc != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_VOUCHER.invalidDiscountDesc}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Phần Trăm Chiết Khấu (%): </td>
                        <td>
                            <input class="form-control" type="number" name="txtDiscountPercent" value="${param.txtDiscountPercent}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_VOUCHER.invalidDiscountPercent != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_VOUCHER.invalidDiscountPercent}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Thời Hạn Sử Dụng: </td>
                        <td>
                            <input class="form-control" type="datetime-local" name="txtExpireDate" value="${param.txtExpireDate}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_VOUCHER.invalidExpiredDate != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_VOUCHER.invalidExpiredDate}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <button class="btn btn-success" type="submit" name="action" value="CreateVoucher">Tạo Voucher Mới</button>
                            <a class="btn btn-outline-secondary" href="DispatchServlet">Hủy Bỏ</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script>
            getListener();
        </script>
    </body>
</html>
