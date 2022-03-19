<%-- 
    Document   : historyheader
    Created on : Jul 5, 2021, 11:05:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông tin đặt hàng</title>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/historyheader.css" />
        <script src="./js/header_bar.js"></script>
    </head>
    <body>
        <c:if test="${sessionScope.ACCOUNTDETAIL == null}">
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
                                <a href="DispatchServlet" class="btn btn-warning">Quản Lý Sách</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'User'}">
                            <li style="margin-right: 10px">
                                <a class="btn btn-warning" href="DispatchServlet?action=ViewCart">Giỏ Hàng
                                    <span id="sizeofcart" style="background-color: #20effc; top: 3px; padding: 0 7px 0 7px; border-radius: 50%; position: absolute;">
                                        ${sessionScope.BOOKCARTDETAIL.bookLists.size()}
                                    </span>
                                </a>
                            </li>
                            <li style="margin-right: 10px">
                                <a class="btn btn-info" href="DispatchServlet">Trở Về Trang Chủ</a>
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
            <h1 class="text-center">Lịch Sử Đặt Hàng</h1>
            <div style="margin-left: 15%; margin-bottom: 15px; margin-top: 15px;">
                <form action="DispatchServlet" method="GET">
                    <table style="margin-right: 20px;" border="0">
                        <tbody>
                            <tr>
                                <td style="padding-right: 10px;">Thời gian đặt hàng: </td>
                                <td style="padding-right: 10px;">
                                    <input style="width: auto;" id="date-search-order" class="form-control" type="date" name="txtDateOrder" placeholder="Thời gian đặt" value="${param.txtDateOrder}" />
                                </td>
                                <td style="padding-right: 10px;">Trạng thái: </td>
                                <td style="padding-right: 10px;">
                                    <select class="form-select" name="cboOrderStatus">
                                        <option <c:if test="${param.cboOrderStatus eq '0'}">selected="true"</c:if> value="0">Toàn bộ</option>
                                        <option <c:if test="${param.cboOrderStatus eq '1'}">selected="true"</c:if> value="1">Chờ lấy hàng</option>
                                        <option <c:if test="${param.cboOrderStatus eq '2'}">selected="true"</c:if> value="2">Đang giao hàng</option>
                                        <option <c:if test="${param.cboOrderStatus eq '3'}">selected="true"</c:if> value="3">Đã giao</option>
                                        <option <c:if test="${param.cboOrderStatus eq '5'}">selected="true"</c:if> value="5">Đã hủy đơn</option>
                                        <option <c:if test="${param.cboOrderStatus eq '6'}">selected="true"</c:if> value="6">Đang xem xét hủy</option>
                                        </select>
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <button class="btn btn-outline-success" type="submit" name="action" value="HistoryPage">
                                            <div style="display: flex;">
                                                Tìm Kiếm
                                            </div>
                                        </button>
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <button onclick="resetDate();" class="btn btn-outline-success" name="action" value="HistoryPage">Tìm Tất Cả Đơn</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            <c:if test="${not empty requestScope.HISTORY_DETAIL}">
                <table class="table">
                    <thead class="cart__row cart__header">
                        <tr class="">
                            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}"><th class="text-center">Khách Đặt</th></c:if>
                                <th class="text-center">Trạng Thái</th>
                                <th class="text-center">Phương Thức Thanh Toán</th>
                                <th class="text-center">Tổng Giá</th>
                                <th class="text-center">Voucher Sử Dụng</th>
                                <th class="text-center">Thời Gian Đặt</th>
                                <th class="text-center">Chi Tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.HISTORY_DETAIL}" var="list">
                            <tr>
                                <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                                    <td class="text-center">
                                        ${list.fullName} 
                                    </td>
                                </c:if>
                                <td class="text-center">
                                    ${list.statusName}
                                </td>
                                <td class="text-center">
                                    ${list.paymentName}
                                </td>
                                <td class="text-center">
                                    ${list.totalPrice}
                                </td>
                                <td class="text-center">
                                    <c:if test="${empty list.discountCode}">Không</c:if>
                                    ${list.discountCode}
                                </td>
                                <td class="text-center">
                                    ${list.orderTime}
                                </td>
                                <td class="text-end">
                                    <a href="DispatchServlet?action=ViewOrderDetail&orderID=${list.orderID}" class="btn btn-danger">Xem Chi Tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty requestScope.HISTORY_DETAIL}">
                <p style="font-weight: bold; color: red; text-align: center;">Không tìm thấy đơn hàng dựa vào yêu cầu của bạn</p>
            </c:if>
        </div>
        <script>
            
            getListener();
            
            function resetDate() {
                var date = document.getElementById("date-search-order").value;

                if (date.length >= 1) {
                    document.getElementById("date-search-order").value = "";
                }
            }
        </script>
    </body>
</html>
