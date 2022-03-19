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
        <link rel="stylesheet" href="./css/historydetail.css" />
        <script src="./js/header_bar.js"></script>
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
                <div class="dropdown text-end" id="account-info" style="display: flex; margin-right: 15px; padding-top: 2px">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <span style="margin: 5px">
                            <p>Xin chào, ${sessionScope.ACCOUNTDETAIL.fullname} <img style="object-fit: cover;" src="${sessionScope.ACCOUNTDETAIL.imageLink}" alt="mdo" width="32" height="32" class="rounded-circle"></p>
                        </span>
                    </c:if>
                </div>
                <ul class="nav justify-content-center">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <li style="margin-right: 10px">
                            <a class="btn btn-warning" href="DispatchServlet">Trở Về Trang Chủ</a>
                        </li>
                        <li style="margin-right: 10px">
                            <a class="btn btn-info" href="DispatchServlet?action=HistoryPage">Lịch Sử Đơn Hàng</a>
                        </li>
                    </c:if>
                    <li style="margin-right: 10px">
                        <a href="DispatchServlet?action=Logout" class="btn btn-danger">Đăng Xuất</a>
                    </li>
                </ul>
            </header>
            <h1 class="text-center">Thông Tin Đơn Hàng</h1>
            <h6 id="status-order-detail" class="text-center" style="color: red;"></h6>

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
            <div style="margin-left: 25%; margin-bottom: 5%; margin-top: 2%;">
                <a href="DispatchServlet?action=HistoryPage" style="margin-right: 5px;" class="btn btn-outline-secondary">< DANH SÁCH ĐƠN HÀNG</a>
                <button id="" style="margin-right: 5px;" class="btn btn-primary" onclick="popupTransferBox();">THÔNG TIN VẬN CHUYỂN</button>
                <button id="btn-cancel-order" onclick="popupCancelBox();" style="margin-right: 5px;" class="btn btn-danger">HỦY ĐƠN HÀNG</button>
                <input type="hidden" name="paymentType" value="COD" />
            </div>
        </div>
        <div class="popup-cancel" id="popup-full-delete">
            <div class="popup-content-cancel-order" id="popup-khung-delete">
                <h4 style="padding-top: 20px;" class="title-pop-up login text-center">Yêu Cầu Hủy Đơn Hàng</h4>
                <h6 style="padding-top: 10px; margin: 0 20px 0 20px;" class="text-center">Chúng tôi rất tiếc về việc đơn hàng đã xảy ra vấn đề khiến bạn không ưng ý, bạn hãy góp ý hoặc nêu lý do hủy đơn để chúng tôi xử lý sớm nhất nhé!</h6>
                <i class="far fa-times-circle close-delete-popup"></i>
                <div class="detail-pop-up">                    
                    <form action="DispatchServlet" method="POST">
                        <table class="table-delete" style="margin-left: 12%; margin-top: 10px; margin-bottom: 10px;">
                            <tbody>
                                <tr>
                                    <td style="display: inline-block; margin: 30px 20px 0 0;"><p style="font-weight: bold;">Lý do: </p></td>
                                    <td style="height: 300px;">
                                        <textarea required="" minlength="10" class="form-control" style="resize: none; width: 430px; height: 90%;" name="txtReason" placeholder="Vui lòng nêu rõ lý do hủy đơn của bạn..."></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center" colspan="2">
                                        <button style="margin-right: 10px;" type="submit" value="RequestCancelOrder" name="action" class="btn btn-danger">XÁC NHẬN HỦY</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="closeDeletePopup();">ĐÓNG</button>
                                        <input type="hidden" id="bookID-delete-hidden" name="orderID" value="${requestScope.ORDER_HEADER_DETAIL.orderID}" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>

        <div class="popup-transfer" id="popup-full-transfer">
            <div class="popup-content-transfer-order" id="popup-khung-transfer">
                <h4 style="padding-top: 20px;" class="title-pop-up login text-center">Thông Tin Vận Chuyển</h4>
                <h6 style="padding-top: 10px; margin: 0 20px 0 20px;" class="text-center">Chi tiết vận chuyển đơn hàng được thể hiện ở đây, bạn có thể xem trạng thái giao hàng cũng như đơn hàng đã đến đâu rồi nhé!</h6>
                <p id="status-change-shipping" style="margin: 5px 20px 0 20px; font-weight: bold; color: red; text-align: center; font-style: italic;"></p>
                <i class="far fa-times-circle close-transfer-popup"></i>
                <div style="margin: 20px 0 0 30px; width: 90%; height: 300px; border: 1px solid black; overflow-y: scroll;" class="detail-pop-up">                    
                    <form action="DispatchServlet" method="POST">
                        <table class="table-delete" style="margin-left: 10%; margin-top: 10px; margin-bottom: 10px;">
                            <tbody id="transfer-tree-table">
                            </tbody>
                        </table>
                    </form>
                </div>
                <div>
                    <table class="table-delete" style="margin-left: 27%; margin-top: 10px; margin-bottom: 10px;">
                        <tbody>
                            <tr>
                                <td class="text-center" colspan="2">
                                    <button style="margin-right: 10px;" type="button" onclick="popupShippingBox();" name="action" id="btn-update-order-executing" class="btn btn-primary <c:if test="${sessionScope.ACCOUNTDETAIL.rolename == 'User'}">disabled</c:if>">CẬP NHẬT THÔNG TIN</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="closeTransferPopup();">ĐÓNG</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="popup-shipping" id="popup-full-shipping">
                <div class="popup-content-shipping-order" id="popup-khung-shipping">
                    <h4 style="padding-top: 20px;" class="title-pop-up login text-center">Cập Nhật Quá Trình Vận Chuyển</h4>
                    <h6 style="padding-top: 10px; margin: 0 20px 0 20px;" class="text-center">Luôn luôn cập nhật quá trình vận chuyển để dễ hàng kiểm soát đơn giao của bạn. Lưu ý: Tính năng chỉ dành riêng cho người giao hàng, không phận sự vui lòng không sử dụng.</h6>
                    <i class="far fa-times-circle close-shipping-popup"></i>
                    <div style="margin: 20px 0 0 30px; width: 90%; height: 420px; border: 2px solid black; border-radius: 5%; opacity: 1;" class="detail-pop-up">
                        <p style="font-weight: bold; font-style: italic; margin-top: 10px; text-align: center;">Trạng thái đơn hàng hiện tại: ${requestScope.ORDER_HEADER_DETAIL.statusName}</p>         
                    <input type="hidden" id="statusOrder" />
                    <div style="margin-left: 23%; display: flex;">
                        <p style="margin: 15px 10px 0 0;">Cập nhật trạng thái: </p>
                        <select style="margin: 10px 0 0 0; width: 37%;" class="form-select" id="cboChangeStatus">
                            <option id="cho-lay-hang" value="1">Chờ lấy hàng</option>
                            <option id="dang-giao-hang" value="2">Đang giao hàng</option>
                            <option id="da-giao" value="3">Đã giao</option>
                            <option id="dang-tra-hang" value="4">Đang trả hàng</option>
                            <option id="da-huy-don" value="5">Đã hủy đơn</option>
                        </select>
                    </div>
                    <div>
                        <table class="table-delete" style="margin-left: 8%; margin-top: 10px; margin-bottom: 10px;">
                            <tbody>
                                <tr>
                                    <td style="display: inline-block; margin: 30px 20px 0 0;"><p style="font-weight: bold;">Mô tả: </p></td>
                                    <td style="height: 300px;">
                                        <textarea required="" minlength="10" class="form-control" style="resize: none; width: 430px; height: 90%;" id="txtDescription" placeholder="Thông tin thêm cho trạng thái đơn hàng của bạn..."></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div>
                    <table class="table-delete" style="margin-left: 36%; margin-top: 20px; margin-bottom: 10px;">
                        <tbody>
                            <tr>
                                <td class="text-center" colspan="2">
                                    <button style="margin-right: 10px;" type="button" onclick="changeOrderStatusShipper();" name="action" class="btn btn-primary">CẬP NHẬT</button>
                                    <button type="button" class="btn btn-outline-secondary" onclick="closeShippingPopup();">ĐÓNG</button>
                                </td> 
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>

            getListener();

            changeCancelButton("${requestScope.ORDER_HEADER_DETAIL.statusName}");

            function changeCancelButton(orderStatus) {
                var btnCancel = document.getElementById("btn-cancel-order");
                var statusOrder = document.getElementById("status-order-detail");
                var needToDisabled = false;
                var isShipper = false;
                switch (orderStatus) {
                    case "Đã Giao Hàng":
                        needToDisabled = true;
                        statusOrder.innerHTML = "Đơn hàng đã được giao thành công, bạn vui lòng kiểm tra hàng đã đủ chưa nhé!";
                        break;
                    case "Đã Hủy Đơn Hàng":
                        statusOrder.innerHTML = "Đơn hàng đã hủy thành công, nếu bạn thanh toán Paypal chúng tôi sẽ xử lý hoàn tiền trong 24h tới!";
                        needToDisabled = true;
                        break;
                    case "Đang Xem Xét Hủy Đơn":
                        statusOrder.innerHTML = "Yêu cầu hủy đơn của bạn đang chờ bên chúng tôi duyệt, sẽ thông báo cho bạn sớm nhất!";
                        needToDisabled = true;
                        document.getElementById("btn-update-order-executing").classList.add("disabled");
                        break;
                    default:
                        break;
                }

            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Shipper'}">
                isShipper = true;
            </c:if>

                if (isShipper) {
                    btnCancel.disabled = true;
                }

                if (needToDisabled) {
                    btnCancel.disabled = true;
                    btnCancel.innerHTML = orderStatus.toUpperCase();
                }
            }

            function closeDeletePopup() {
                document.querySelector(".popup-cancel").style.display = "none";
            }

            function closeTransferPopup() {
                document.querySelector(".popup-transfer").style.display = "none";
            }

            function closeShippingPopup() {
                document.querySelector(".popup-shipping").style.display = "none";
            }

            function popupCancelBox() {
                document.querySelector(".popup-cancel").style.display = "flex";
            }
            document.querySelector(".close-delete-popup").addEventListener("click", closeDeletePopup);
            document.querySelector(".close-transfer-popup").addEventListener("click", closeTransferPopup);
            document.querySelector(".close-shipping-popup").addEventListener("click", closeShippingPopup);

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

            document.getElementById("popup-full-transfer").addEventListener("click", function (event1) {
                var box1 = document.getElementById("popup-khung-transfer");
                var target1 = event1.target;
                do {
                    if (target1 == box1) {
                        return;
                    }
                    target1 = target1.parentNode;
                } while (target1);
                closeTransferPopup();
            });

            document.getElementById("popup-full-shipping").addEventListener("click", function (event1) {
                var box1 = document.getElementById("popup-khung-shipping");
                var target1 = event1.target;
                do {
                    if (target1 == box1) {
                        return;
                    }
                    target1 = target1.parentNode;
                } while (target1);
                closeShippingPopup();
            });

            function loadHeader(status) {
                return `<tr><td colspan="3"><h5 style="font-weight: bold;">` + status + `</h5></td></tr>`;
            }

            function loadOrderEmpty() {
                return `<tr><td colspan="3"><p style="color:red; font-weight: bold; font-style: italic; margin-top: 20px;">Lịch sử đơn hàng chưa được cập nhật hoặc không tìm thấy.</p></td></tr>`;
            }

            function loadInitTable(date, desc) {
                return `<tr>
                                        <td style="display: inline-block; margin: 20px 20px 0 0;"><p style="line-height: 20px; width: 70%; text-align: right; font-weight: bold;">` + date + `</p></td>
                                        <td style="display: inline-block; margin: 20px 20px 0 0;">
                                            <p>•</p>
                                        </td>
                                        <td style="display: inline-block; margin: 15px 20px 0 0;">
                                            <p style="white-space: pre-line; font-weight: bold; width: 300px; line-height: 20px; height: auto;">` + desc + `</p>
                                        </td>
                                    </tr>`;
            }

            function loadInitTableFirstLine(date, desc) {
                return `<tr id="accept-deny-order-admin">
                                        <td style="display: inline-block; margin: 20px 20px 0 0;"><p style="color: deeppink; line-height: 20px; width: 70%; text-align: right; font-weight: bold;">` + date + `</p></td>
                                        <td style="display: inline-block; margin: 20px 20px 0 0;">
                                            <p style="color: deeppink;">•</p>
                                        </td>
                                        <td style="display: inline-block; margin: 15px 20px 0 0;">
                                            <p style="white-space: pre-line; color: deeppink; font-weight: bold; width: 300px; line-height: 20px; height: auto;">` + desc + `</p>
                                        </td>
                                    </tr>`;
            }

            function loadButtonForAdmin() {
                return `<tr id="load-execute-cancel-admin">
                                        <td colspan="2" style="display: inline-block; margin: 0px 20px 20px 40px;"><p style="margin-top: 17px; font-weight: bold;">Xem xét yêu cầu:</p></td>
                                        <td colspan="2" style="display: inline-block; margin: 0px 20px 20px 0;"><button class="btn btn-success" onclick="processOrderRequest(1);"";>Đồng ý</button></td>
                                        <td style="display: inline-block; margin: 0px 20px 20px 0;"><button class="btn btn-warning" onclick="processOrderRequest(0);">TỪ CHỐI</button></td>
                                    </tr>`;
            }

            function changeOrderStatusShipper() {
                var statusFrom = document.getElementById("statusOrder").value;
                var statusTo = document.getElementById("cboChangeStatus").value;
                var description = document.getElementById("txtDescription").value;
                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {action: "ChangeStatusShipping", orderID: "${requestScope.ORDER_HEADER_DETAIL.orderID}", cboChangeFrom: statusFrom, cboChangeStatus: statusTo, txtDescription: description},
                    success: function (data, textStatus, jqXHR) {
                        switch (data) {
                            case "successNoChange":
                                closeShippingPopup();
                                loadAjaxOrderTransfer();
                                document.getElementById("status-change-shipping").innerHTML = "Cập nhật trạng thái vận chuyển thành công!";
                                break;
                            case "successYesChange":
                                window.location.href = "/BookStore/DispatchServlet?action=ViewOrderDetail&orderID=${requestScope.ORDER_HEADER_DETAIL.orderID}";
                            default:
                                console.log(data);
                                break;
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            }

            function loadAjaxOrderTransfer() {
                $.ajax({
                    url: "DispatchServlet",
                    method: "GET",
                    data: {action: "GetAllOrderTransfer", orderID: "${requestScope.ORDER_HEADER_DETAIL.orderID}"},
                    success: function (data, textStatus, jqXHR) {
                        var jsonResponse = JSON.parse(data);
                        var html = "";
                        var parentTree = document.getElementById("transfer-tree-table");
                        var statusFirstID = 1;
                        if (jsonResponse.length >= 1) {
                            var statusFirst = "";
                            var statusAfter = "";
                            for (var i = 0; i < jsonResponse.length; i++) {
                                if (i == 0) {
                                    statusFirst = jsonResponse[i].statusChangeTo;
                                    statusAfter = jsonResponse[i].statusChangeTo;
                                    statusFirstID = jsonResponse[i].statusChangeToID;
                                } else {
                                    statusAfter = jsonResponse[i].statusChangeTo;
                                }
                                if (statusAfter == statusFirst) {
                                    if (i == 0) {
                                        html += loadHeader(statusAfter);
                                    }
                                } else {
                                    html += loadHeader(statusAfter);
                                    statusFirst = statusAfter;
                                }
                                if (i > 0) {
                                    html += loadInitTable(jsonResponse[i].dateOfCreate, jsonResponse[i].description);
                                    var statusIDToAdmin = jsonResponse[i].statusChangeToID;
                                    var statusIDFromAdmin = jsonResponse[i].statusChangeFrom;
            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                                    if (statusIDToAdmin == 6 && statusIDFromAdmin == 2) {
                                        html += loadButtonForAdmin();
                                    }
            </c:if>
                                } else {
                                    html += loadInitTableFirstLine(jsonResponse[i].dateOfCreate, jsonResponse[i].description);
                                }
                            }
                            document.getElementById("statusOrder").value = statusFirstID;
                            if (statusFirstID != 4) {
                                document.getElementById("dang-tra-hang").disabled = true;
                                document.getElementById("da-huy-don").disabled = true;
                            } else {
                                document.getElementById("dang-tra-hang").disabled = false;
                                document.getElementById("da-huy-don").disabled = false;
                                document.getElementById("cho-lay-hang").disabled = true;
                                document.getElementById("dang-giao-hang").disabled = true;
                                document.getElementById("da-giao").disabled = true;
                                document.getElementById("dang-tra-hang").selected = true;
                            }
                            switch (statusFirstID) {
                                case 2:
                                    document.getElementById("cho-lay-hang").disabled = true;
                                    document.getElementById("dang-giao-hang").selected = true;
                                    break;
                                case 3:
                                    document.getElementById("cho-lay-hang").disabled = true;
                                    document.getElementById("dang-giao-hang").disabled = true;
                                    document.getElementById("da-giao").selected = true;
                                    break;
                                default:
                                    break;
                            }
                        } else {
                            html += loadOrderEmpty();
                        }
                        parentTree.innerHTML = html;
            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                        if (statusFirstID != 6) {
                            document.getElementById("load-execute-cancel-admin").style.display = "none";
                        }
            </c:if>
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            }

            function processOrderRequest(code) {
                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {action: "ProcessRequest", orderID: "${requestScope.ORDER_HEADER_DETAIL.orderID}", optionCode: code},
                    success: function (data, textStatus, jqXHR) {
                        switch (data) {
                            case "success":
                                window.location.href = "/BookStore/DispatchServlet?action=ViewOrderDetail&orderID=${requestScope.ORDER_HEADER_DETAIL.orderID}";
                                break;
                            default:
                                console.log(data);
                                break;
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            }

            function popupTransferBox() {
                document.querySelector(".popup-transfer").style.display = "flex";
                loadAjaxOrderTransfer();
            }

            function popupShippingBox() {
                document.querySelector(".popup-shipping").style.display = "flex";
                //loadAjaxOrderTransfer();
            }

        </script>
    </body>
</html>
