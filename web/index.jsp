<%-- 
    Document   : index
    Created on : Jun 22, 2021, 11:01:12 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cửa Hàng Sách Kỹ Thuật Phần Mềm</title>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
        <link href="./css/searchbook.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    </head>
    <body>
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
                    <!--
                    
                    -->
                </div>
                <ul class="nav justify-content-center">
                    <c:if test="${sessionScope.ACCOUNTDETAIL != null}">
                        <li style="margin-right: 10px">
                            <a href="DispatchServlet?action=Logout" class="btn btn-danger">Đăng Xuất</a>
                        </li>
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                            <li style="margin-right: 10px">
                                <a href="DispatchServlet?action=CreateNewBook" class="btn btn-warning">Thêm Sách Mới</a>
                            </li>
                            <li style="margin-right: 10px">
                                <a class="btn btn-success" href="DispatchServlet?action=CreateVoucherPage">Thêm Voucher Mới</a>
                            </li>
                            <li style="margin-right: 10px">
                                <a class="btn btn-info" href="DispatchServlet?action=HistoryPage">Danh Sách Đơn Đặt Hàng</a>
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
                                <a class="btn btn-success" href="DispatchServlet?action=HistoryPage">Lịch Sử Đặt Hàng</a>
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
        </div>
        <h1 class="text-center" style="margin-bottom: 20px;">Cửa Hàng Sách Kỹ Thuật Phần Mềm</h1>
        <div class="search-book" style="width: auto; margin-left: 20%;">
            <form action="DispatchServlet" method="GET">
                <table border="0" class="">               
                    <tbody>
                        <tr>
                            <td>
                                <div style="display: flex;">
                                    <strong style="margin-left: 45px; margin-top: 6px; margin-right: 5px;">Danh Mục: </strong>
                                    <select class="form-select" style="width: auto;" name="dboCategoryBook">
                                        <option value="0">Tất Cả</option>
                                        <c:forEach items="${requestScope.ALLCATEGORIES}" var="categories">
                                            <option <c:if test="${param.dboCategoryBook eq categories.categoryID}">selected="true"</c:if> value="${categories.categoryID}">${categories.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>

                            <td rowspan="2">
                                <div style="display: flex; justify-content: center;">
                                    <strong style="margin-left: 10px; margin-top: 6px; margin-right: 5px;">Tên Sách:</strong> 
                                    <input style="width: auto;" class="form-control" type="text" name="txtSearchBook" placeholder="Bạn muốn mua sách gì..." value="${param.txtSearchBook}" />
                                </div>
                            </td>
                            <td rowspan="2">
                                <button class="btn btn-outline-success" type="submit" name="action" value="SearchBook">
                                    <div style="display: flex;">
                                        Tìm Kiếm
                                    </div>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="display: flex; justify-content: center;">
                                    <strong style="margin-top: 6px; margin-right: 5px; margin-left: 15px;">Giá Dao Động:</strong>
                                    <select class="form-select" style="width: 66%; padding-left: 17px;" name="dboFluctuatingPrice">
                                        <option <c:if test="${param.dboFluctuatingPrice eq '0'}">selected="true"</c:if> value="0">Toàn Bộ Giá</option>
                                        <option <c:if test="${param.dboFluctuatingPrice eq '1'}">selected="true"</c:if> value="1">Dưới 100.000</option>
                                        <option <c:if test="${param.dboFluctuatingPrice eq '2'}">selected="true"</c:if> value="2">Từ 100.000 đến 300.000</option>
                                        <option <c:if test="${param.dboFluctuatingPrice eq '3'}">selected="true"</c:if> value="3">Từ 300.000 đến 1.000.000</option>
                                        <option <c:if test="${param.dboFluctuatingPrice eq '4'}">selected="true"</c:if> value="4">Từ 1.000.000 đến 3.000.000</option>
                                        <option <c:if test="${param.dboFluctuatingPrice eq '5'}">selected="true"</c:if> value="5">Trên 3.000.000</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        <c:if test="${not empty requestScope.SEARCHBOOK_STATUS}">
            <h6 class="text-center" style="color: red; margin-top: 15px;">${requestScope.SEARCHBOOK_STATUS}</h6>
        </c:if>
        <!--Card-->
        <div class="card-list">
            <c:forEach items="${requestScope.ALLBOOKS}" var="bookDetail" varStatus="counter">
                <form action="DispatchServlet" method="POST">
                    <div class="card" style="width: 17rem; margin-right: 20px; margin-bottom: 20px;">
                        <img src="${bookDetail.image}" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">${bookDetail.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Tác Giả: ${bookDetail.author}</h6>
                            <!--<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>-->
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Danh Mục: ${bookDetail.category}</li>
                            <li class="list-group-item">Số Lượng: ${bookDetail.quantity} cuốn</li>
                            <li class="list-group-item">Giá: ${bookDetail.price}</li>
                        </ul>
                        <div class="card-body">
                            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'Admin'}">
                                <div style="display: flex; justify-content: center; margin-top: 10px;">
                                    <button style="margin-right: 10px;" class="btn btn-primary" type="submit" value="EditBookPage" name="action">Cập Nhật</button>
                                    <button class="btn btn-danger" type="button" onclick="popupDeleteBox('${bookDetail.title}', '${bookDetail.bookID}', '${bookDetail.image}');">Xóa</button>
                                    <input type="hidden" name="txtBookID" value="${bookDetail.bookID}" />
                                    <input type="hidden" name="dboCategoryBook" value="${param.dboCategoryBook}" />
                                    <input type="hidden" name="txtSearchBook" value="${param.txtSearchBook}" />
                                    <input type="hidden" name="dboFluctuatingPrice" value="${param.dboFluctuatingPrice}" />
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'User' || empty sessionScope.ACCOUNTDETAIL}">
                                <div>
                                    <button style="margin: 10px 0 0 30px;" class="btn btn-warning" type="button" onclick="callAjaxAddToCart('${bookDetail.bookID}', '${bookDetail.title}');" value="AddToCart" name="action">Thêm Vào Giỏ Hàng</button>
                                    <input type="hidden" name="txtBookID" value="${bookDetail.bookID}" />
                                </div>
                            </c:if>
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>
        <c:if test="${requestScope.ALLBOOKS.size() == 0 || empty requestScope.ALLBOOKS}">
            <p style="font-size: 20px; color: red; font-style: italic;" class="text-center">Hiện tại không có sách thỏa mãn yêu cầu của bạn!</p>
        </c:if>
        <!--Card-->
        <div class="popup-delete" id="popup-full-delete">
            <div class="popup-content-delete" id="popup-khung-delete">
                <h4 style="padding-top: 20px; padding-bottom: 20px;" class="title-pop-up login text-center">Xác Nhận Xóa Sách</h4>
                <i class="far fa-times-circle close-delete-popup"></i>
                <div class="detail-pop-up">
                    <img class="img" id="show-image-book-delete" style="margin-left: auto; display: block; margin-right: auto; margin-bottom: 20px;" src="" width="120px" height="150px" id="img-setting" alt=""/>
                    <h6 style="padding-top: 10px; margin: 0 10px 0 10px;" class="text-center">Bạn đang xóa sách với tiêu đề <span id="book-delete"></span> , xác nhận xóa?</h6>
                    <form action="DispatchServlet" method="POST">
                        <table class="table-delete" style="margin-left: 27%; margin-top: 20px; margin-bottom: 20px;">
                            <tbody>
                                <tr>
                                    <td class="text-center">
                                        <button type="submit" value="ConfirmDeleteBook" name="action" class="btn btn-danger">Xác Nhận Xóa</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="closeDeletePopup();">Hủy Bỏ</button>
                                        <input id="bookID-delete-hidden" type="hidden" name="txtBookDeleteID" value="" />
                                        <input type="hidden" name="dboCategoryBook" value="${param.dboCategoryBook}" />
                                        <input type="hidden" name="txtSearchBook" value="${param.txtSearchBook}" />
                                        <input type="hidden" name="dboFluctuatingPrice" value="${param.dboFluctuatingPrice}" />
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

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-bottom-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "3000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };

            function callAjaxAddToCart(bookID, title) {
                var success = "success";
                var alreadyexist = "alreadyexist";
                var gotologinpage = "gotologinpage";
                var invalidrole = "invalidrole";
                var notfoundbook = "notfoundbook";
                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {txtBookID: bookID, action: "AddToCart"},
                    success: function (data, textStatus, jqXHR) {
                        var array = data.split("|");
                        switch (array[0]) {
                            case success :
                                toastr.success("Tiêu đề sách: " + title + " đã được thêm vào giỏ hàng thành công.");
                                break;
                            case alreadyexist:
                                toastr.warning("Sách bạn đang thêm vào đã tồn tại sẵn trong giỏ hàng.");
                                break;
                            case gotologinpage:
                                window.location.replace("DispatchServlet?action=LoginPage");
                                break;
                            case invalidrole:
                                toastr.warning("Vai trò của bạn không thể thực hiện việc mua sắm!");
                                break;
                            case notfoundbook:
                                toastr.error("Sách bạn đang thêm không còn tồn tại hoặc đã hết số lượng.");
                                break;
                            default :
                                toastr.error("Có lỗi xảy ra khi thêm sách vào giỏ hàng.");
                                break;
                        }
                        document.getElementById("sizeofcart").innerHTML = array[1];
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            }
        </script>
    </body>
</html>
