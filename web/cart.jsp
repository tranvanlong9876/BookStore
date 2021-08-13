<%-- 
    Document   : cart
    Created on : Jul 1, 2021, 5:45:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ Hàng</title>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/cart.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://www.paypal.com/sdk/js?client-id=ARPRg05MtOzL4WedFzLSmyMjbbAu9tXJsxi6Mgxxqlc6ZDadnvYmdA6Fao4IyUluCnHl45ZfUPB0Mxm7"></script>
    </head>
    <body>
        <c:if test="${sessionScope.ACCOUNTDETAIL == null || sessionScope.ACCOUNTDETAIL.rolename != 'User'}">
            <c:redirect url="DispatchServlet" />
        </c:if>
        <div class="container">
            <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
                <a style="margin-top: -12px" href="DispatchServlet" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                    <i style="padding-right: 10px;" class="fa fa-book"></i>
                    <span class="fs-4">Book Store</span>
                </a>
                <div class="dropdown text-end" style="display: flex; margin-right: 15px; padding-top: 2px">
                    <c:if test="${sessionScope.ACCOUNTDETAIL == null}">
                        <span style="margin: 5px">
                            <p>Kính Chào Quý Khách</p>
                        </span>
                    </c:if>
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
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                            <li style="margin-right: 10px">
                                <a href="DispatchServlet" class="btn btn-warning">Quản Lý Sách</a>
                            </li>
                            <li style="margin-right: 10px">
                                <a class="btn btn-success" href="">Thêm Voucher Mới</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'User'}">
                            <li style="margin-right: 10px">
                                <a class="btn btn-warning" href="DispatchServlet">Trở Về Trang Chủ</a>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.ACCOUNTDETAIL == null}">
                        <li>
                            <a class="btn btn-warning" href="DispatchServlet?action=LoginPage">Đăng Nhập</a>
                        </li>
                    </c:if>
                </ul>
            </header>
            <h1 class="text-center">Giỏ hàng của bạn</h1>
            <p class="text-center" style="color: red;">${requestScope.CARTSTATUS}</p>
            <c:if test="${sessionScope.BOOKCARTDETAIL.bookLists.size() > 0}">
                <form action="DispatchServlet" id="frmCreateOrder" method="POST">
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
                            <c:forEach items="${sessionScope.BOOKCARTDETAIL.bookLists}" var="cartList">
                                <tr>
                                    <td class="cart__image-wrapper">
                                        <img class="cart__image" src="${cartList.value.bookImage}">
                                    </td>
                                    <td class="cart__title">
                                        <div class="list-view-item__title">
                                            ${cartList.value.bookName}
                                            <p style="font-size: 14px; color: #666666">Tác giả: ${cartList.value.bookAuthor}</p>
                                        </div>
                                        <p class="small-input">
                                            <button onclick="popupDeleteBox('${cartList.value.bookName}', '${cartList.key}', '${cartList.value.bookImage}')" type="button" class="btn btn-outline-secondary">XÓA KHỎI GIỎ HÀNG</button>
                                        </p>
                                    </td>
                                    <td class="text-center">
                                        ${cartList.value.priceCastToVietnameseCurrency}
                                    </td>
                                    <td class="cart__update-wrapper cart-flex-item text-right">
                                        <div class="cart__qty">
                                            <input type="hidden" name="txtBookUpdateID" value="${cartList.key}" />
                                            <input class="form-control quantity" type="number" id="quantity-book-cart" name="txtQuantity" oninput="changeQuantity()" value="${cartList.value.bookQuantity}" min="1" pattern="[0-9]*">
                                        </div>
                                        <c:if test="${cartList.value.enoughQuantity == false}">
                                            <div style="padding-top: 10px;" class="cart__qty">
                                                <span style="color: red;">Số lượng bạn nhập vượt quá hàng tồn kho, tối đa ${cartList.value.maxQuantity} cuốn.</span>
                                            </div>
                                        </c:if>
                                        <!--<input type="submit" name="update" class="btn btn--small cart__update medium-up--hide" value="Update">-->
                                    </td>
                                    <td class="text-end">
                                        <div>
                                            ${cartList.value.totalPriceCastToVietNameseCurrency}
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <footer style="padding-bottom: 5%;" class="cart__footer">
                        <div class="row">

                            <div style="width: 400px;" class="col-4">
                                <div>
                                    <p style="margin-bottom: 20px;">Mã giảm giá: </p>
                                </div>
                                <div style="display: flex; height: 40px;">
                                    <input style="width: 200px;" class="form-control" type="text" name="txtVoucherCode" placeholder="Mã giảm giá của bạn..." value="${sessionScope.BOOKCARTDETAIL.voucher.discountCode}" />
                                    <button style="margin-left: 20px;" class="btn btn-warning" name="action" value="ApplyVoucherCode">ÁP DỤNG</button>
                                </div>
                                <div>
                                    <c:if test="${sessionScope.BOOKCARTDETAIL.voucher != null}">
                                        <p style="margin-top: 20px; color: #33ccff;">
                                            <i class="fas fa-exclamation-circle"></i>
                                            Bạn được ưu đãi: ${sessionScope.BOOKCARTDETAIL.voucher.discountDesc}
                                        </p>
                                    </c:if>
                                    <c:if test="${sessionScope.BOOKCARTDETAIL.voucher == null && requestScope.STATUS_VOUCHER == null}">
                                        <p style="margin-top: 20px;">Bạn có phiếu quà tặng? Nhập ngay!</p>
                                    </c:if>
                                    <c:if test="${requestScope.STATUS_VOUCHER != null}">
                                        <p style="margin-top: 20px; color: red;">
                                            <i class="fas fa-exclamation-triangle"></i>
                                            ${requestScope.STATUS_VOUCHER}
                                        </p>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-4"> 
                                <div>
                                    <p style="margin-bottom: 20px;">Địa chỉ giao hàng: </p>
                                </div>
                                <div style="height: 40px; display: flex;">
                                    <input style="width: 200px; margin-right: 10px;" class="form-control" oninput="changeQuantity()" id="home-delivery" type="text" name="txtHomeNumber" placeholder="Số nhà, tên đường..." value="${sessionScope.BOOKCARTDETAIL.homeNumber}" />
                                    <input style="width: 200px;" class="form-control" oninput="changeQuantity()" id="address-delivery" type="text" name="txtAddress" placeholder="Quận huyện, thành phố..." value="${sessionScope.BOOKCARTDETAIL.deliveryAddress}" />
                                </div>
                                <div>
                                    <p style="margin-top: 20px;">Nhập địa chỉ giao hàng của bạn trước khi đặt hàng nhé!</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div style="margin-right: 20px;" class="total-price text-end">
                                    <span class="cart__subtotal-title">Tổng Phụ: </span>
                                    <span class="cart__subtotal">${sessionScope.BOOKCARTDETAIL.totalPriceOfCartWithVietnameseCurrency}</span>
                                </div>
                                <div style="margin-right: 20px;" class="total-price text-end">
                                    <span style="color: red;" class="cart__subtotal-title">Giảm Giá Voucher: </span>
                                    <span style="color: red;" class="cart__subtotal">- ${sessionScope.BOOKCARTDETAIL.discountPriceString}</span>
                                </div>
                                <div style="margin-right: 20px;" class="total-price text-end">
                                    <span class="cart__subtotal-title">Tổng Giá: </span>
                                    <span id="total-price-total" class="cart__subtotal">${sessionScope.BOOKCARTDETAIL.totalPriceOfCartCheckOutWithVietnameseCurrency}</span>
                                </div>
                                <div style="margin-left: 20px;">
                                    <a href="DispatchServlet" class="btn btn-outline-secondary">Tiếp Tục Mua Sắm</a>
                                    <button type="submit" name="action" id="btn-update-cart" class="btn btn-outline-secondary disabled" value="UpdateCart">Cập Nhật</button>
                                    <button type="submit" name="action" id="btn-checkout-cart" class="btn btn-success" value="CheckOut">Đặt Hàng</button>
                                    <input type="hidden" name="paymentType" value="COD" />
                                </div>
                                <div style="margin-top: 30px;" id="paypal-button-container"></div>
                            </div>
                        </div>
                    </footer>
                </form>
            </c:if>
            <c:if test="${sessionScope.BOOKCARTDETAIL.bookLists.size() == 0 || sessionScope.BOOKCARTDETAIL == null}">
                <h6 style="margin-top: 30px;" class="text-center text-danger">Giỏ hàng của bạn đang trống <a class="btn btn-warning" href="DispatchServlet">Mua Sắm Ngay!</a></h6>
            </c:if>
        </div>
        <div class="popup-delete" id="popup-full-delete">
            <div class="popup-content-delete" id="popup-khung-delete">
                <h4 style="padding-top: 20px;" class="title-pop-up login text-center">Xóa Sách Khỏi Giỏ Hàng</h4>
                <i class="far fa-times-circle close-delete-popup"></i>
                <div class="detail-pop-up">
                    <img class="img" id="show-image-book-delete" style="margin-left: auto; display: block; margin-right: auto; margin-top: 30px;" src="" width="120px" height="160px" id="img-setting" alt=""/>
                    <h6 style="padding-top: 30px; margin: 0 10px 0 10px;" class="text-center">Bạn đang xóa sách với tiêu đề <span id="book-delete"></span> , xác nhận xóa?</h6>
                    <form action="DispatchServlet" method="POST">
                        <table class="table-delete" style="margin-left: 20%; margin-top: 30px; margin-bottom: 30px;">
                            <tbody>
                                <tr>
                                    <td class="text-center" colspan="2">
                                        <button type="submit" value="RemoveCart" name="action" class="btn btn-danger">GỠ KHỎI GIỎ HÀNG</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="closeDeletePopup();">HỦY BỎ</button>
                                        <input type="hidden" id="bookID-delete-hidden" name="txtBookDeleteID" value="" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function popupDeleteBox(bookTitle, bookID, bookImage) {
                document.getElementById("book-delete").innerHTML = bookTitle;
                document.querySelector(".popup-delete").style.display = "flex";
                document.getElementById("bookID-delete-hidden").value = bookID;
                document.getElementById("show-image-book-delete").src = bookImage;
            }
            document.querySelector(".close-delete-popup").addEventListener("click", closeDeletePopup);

            document.getElementById("popup-full-delete").addEventListener("click", function (event1) {
                var box1 = document.getElementById("popup-khung-delete");
                var target1 = event1.target;
                do {
                    if (target1 == box1) {
                        return;
                    }
                    target1 = target1.parentNode;
                } while (target1);
                closeDeletePopup();
            });

            function closeDeletePopup() {
                document.querySelector(".popup-delete").style.display = "none";
            }

            function changeQuantity() {
                document.getElementById("paypal-button-container").style.display = "none";
                if (!document.getElementById("btn-checkout-cart").classList.contains("disabled")) {
                    document.getElementById("btn-checkout-cart").classList.add("disabled");
                }
                if (document.getElementById("btn-update-cart").classList.contains("disabled")) {
                    document.getElementById("btn-update-cart").classList.remove("disabled");
                }
            }
            var totalPrice = Math.round(${sessionScope.BOOKCARTDETAIL.totalPriceOfCartCheckOut / 23000} * 100) / 100;
            var homeAddress = document.getElementById("home-delivery").value;
            var address = document.getElementById("address-delivery").value;

            paypal.Buttons({
                createOrder: function (data, actions) {
                    return actions.order.create({
                        purchase_units: [{
                                amount: {
                                    value: totalPrice
                                }
                            }]
                    });
                },
                onApprove: function (data, actions) {
                    // This function captures the funds from the transaction.
                    return actions.order.capture().then(function (details) {
                        window.location.replace("DispatchServlet?action=CheckOut&paymentType=Paypal&paypalid=" + details.id + "&paypalemail=" + details.payer.email_address + "&paypalamount=" + details.purchase_units[0].amount.value + "&txtHomeNumber=" + homeAddress + "&txtAddress=" + address);
                    });
                }
            }).render('#paypal-button-container');


            if (homeAddress.length < 1 || address.length < 1) {
                document.getElementById("btn-checkout-cart").classList.add("disabled");
                document.getElementById("paypal-button-container").style.display = "none";
            }
        </script>
    </body>
</html>
