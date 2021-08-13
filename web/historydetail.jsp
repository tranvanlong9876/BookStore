<%-- 
    Document   : historydetail
    Created on : Jul 5, 2021, 11:05:47 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/cart.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông tin đơn hàng</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
                <div class="dropdown text-end" style="display: flex; margin-right: 15px; padding-top: 2px">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <span style="margin: 5px">
                            <p>Xin chào, ${sessionScope.ACCOUNTDETAIL.fullname} (${sessionScope.ACCOUNTDETAIL.rolename})</p>
                        </span>
                    </c:if>
                </div>
                <ul class="nav justify-content-center">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <li style="margin-right: 10px">
                            <a href="DispatchServlet?action=Logout" class="btn btn-danger">Đăng Xuất</a>
                        </li>
                        <li style="margin-right: 10px">
                            <a class="btn btn-warning" href="DispatchServlet">Trở Về Trang Chủ</a>
                        </li>
                        <li style="margin-right: 10px">
                            <a class="btn btn-info" href="DispatchServlet?action=HistoryPage">Lịch Sử Đơn Hàng</a>
                        </li>
                    </c:if>
                </ul>
            </header>
            <h1 class="text-center">Thông Tin Đơn Hàng</h1>

            <table class="table">
                <thead class="cart__row cart__header">
                    <tr class="cart">
                        <th colspan="2">Sản Phẩm</th>
                        <th class="text-center">Giá Cả</th>
                        <th class="text-center">Số Lượng</th>
                        <th class="text-end">Tổng Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.BOOK_LIST_ORDERDETAIL}" var="bookList">
                        <tr>
                            <td class="cart__image-wrapper">
                                <a href="/collections/all/products/whistler-black?variant=39283413123138">
                                    <img class="cart__image" src="${bookList.bookImage}" alt="Whistler - Black">
                                </a>
                            </td>
                            <td class="cart__title">
                                <div class="list-view-item__title">
                                    <a href="/products/whistler-black?variant=39283413123138">
                                        ${bookList.bookName}
                                    </a>
                                    <p style="font-size: 14px; color: #666666">Tác giả: ${bookList.bookAuthor}</p>
                                </div>
                            </td>
                            <td class="text-center">
                                ${bookList.priceCastToVietnameseCurrency}
                            </td>
                            <td class="text-center">
                                ${bookList.bookQuantity} cuốn
                                <!--<input type="submit" name="update" class="btn btn--small cart__update medium-up--hide" value="Update">-->
                            </td>
                            <td class="text-end">
                                <div>
                                    ${bookList.totalPriceCastToVietNameseCurrency}
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <footer class="cart__footer">
                <div class="row">

                    <div style="width: 400px;" class="col-4">
                        <h5>Thông tin của đơn hàng: </h5>
                        <p>Mã đơn hàng: ${requestScope.ORDER_HEADER_DETAIL.orderID}</p>
                        <p>Phương thức thanh toán: ${requestScope.ORDER_HEADER_DETAIL.paymentName}</p>
                        <p>Trạng thái đơn hàng: ${requestScope.ORDER_HEADER_DETAIL.statusName}</p>
                        <p>Thời gian đặt hàng: ${requestScope.ORDER_HEADER_DETAIL.orderTime}</p>
                        <p>Khách hàng: ${requestScope.ORDER_HEADER_DETAIL.fullName} (${requestScope.ORDER_HEADER_DETAIL.username})</p>
                    </div>
                    <div class="col-4">
                        <h5 style="margin-bottom: 20px;">Địa chỉ giao hàng: </h5>
                        <p>${requestScope.ORDER_HEADER_DETAIL.deliveryAddress}</p>
                        <h5>Sử dụng Voucher: </h5>
                        <p><c:if test="${empty requestScope.ORDER_HEADER_DETAIL.discountCode}">Không sử dụng Voucher</c:if>${requestScope.ORDER_HEADER_DETAIL.discountCode}</p>
                        <c:if test="${fn:contains(requestScope.ORDER_HEADER_DETAIL.paymentName, 'Paypal')}">
                            <h5>Thông tin thanh toán (Paypal):</h5>
                            <p>Email thanh toán: <br/>${requestScope.ORDER_HEADER_DETAIL.paypalAccount}</p>
                            <p>Mã thanh toán: ${requestScope.ORDER_HEADER_DETAIL.paymentPaypalID}</p>
                            <p>Số tiền thanh toán: ${requestScope.ORDER_HEADER_DETAIL.payAmountDollar} $</p>
                        </c:if>

                    </div>
                    <div class="col-4">
                        <h5 style="margin-bottom: 20px;" class="text-end">Chi tiết giá: </h5>
                        <div class="total-price text-end">
                            <span class="cart__subtotal-title">Tổng Phụ: </span>
                            <span class="cart__subtotal">${requestScope.SUB_TOTAL}</span>
                        </div>
                        <div class="total-price text-end">
                            <span style="color: red;" class="cart__subtotal-title">Giảm Giá Voucher: </span>
                            <span style="color: red;" class="cart__subtotal">- ${requestScope.DISCOUNT_PRICE}</span>
                        </div>
                        <div class="total-price text-end">
                            <span class="cart__subtotal-title">Thành tiền: </span>
                            <span class="cart__subtotal">${requestScope.ORDER_HEADER_DETAIL.totalPrice}</span>
                        </div>
                    </div>
                </div>
            </footer>
            <div style="margin-left: 35%; margin-bottom: 10%;">
                <a href="DispatchServlet" class="btn btn-outline-secondary">TRỞ VỀ TRANG CHỦ</a>
                <a href="DispatchServlet?action=HistoryPage" class="btn btn-success">XEM DANH SÁCH ĐƠN HÀNG</a>
                <input type="hidden" name="paymentType" value="COD" />
            </div>
        </div>
    </body>
</html>
