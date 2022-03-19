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
        <title>Tạo Sách Mới</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="./js/edit.js" type="text/javascript"></script>
        <link rel="stylesheet" href="./css/updateBook.css"/>
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
                                <a href="DispatchServlet" class="btn btn-warning">Quản Lý Sách</a>
                            </li>
                            <li style="margin-right: 10px">
                                <a class="btn btn-success" href="">Thêm Voucher Mới</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.ACCOUNTDETAIL.rolename eq 'User'}">
                            <li style="margin-right: 10px">
                                <a class="btn btn-warning" href="">Giỏ Hàng</a>
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
        <h1 style="text-align: center;">Cập Nhật Thông Tin Sách</h1>
        <form action="DispatchServlet" method="POST" id="check-valid">
            <c:set value="${requestScope.DETAIL_BOOK_UPDATE}" var="bookDetail" />
            <table class="register-form" border="0" style="margin-left: 500px;">
                <tbody>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <h6>Nhập thông tin mới cho cuốn sách của bạn</h6>
                        </td>
                    </tr>
                    <tr style="">
                        <td class="text-center" colspan="2">
                            <img class="img" src="${bookDetail.image}" width="150px" height="200px" id="img-setting" alt=""/>
                            <input type="hidden" id="link-photo" name="bookImageLink" value="${bookDetail.image}" />
                            <input type="hidden" id="old-photo" value="${bookDetail.image}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Hình Ảnh Mới: 
                        </td>
                        <td>
                            <input class="form-control" type="file" id="file" name="txtFile" />
                        </td>
                    </tr>
                    <tr class="not-valid-book-image" <c:if test="${not empty requestScope.INVALID_REGISTER.invalidImage}">style="display: table-row;"</c:if>>
                            <td colspan="2">
                                <font color="red">
                                <p style="text-align: center;" id="file-status">${requestScope.INVALID_REGISTER.invalidImage}</p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Mã Sách: </td>
                        <td>
                            <input class="form-control" type="text" name="txtBookID" value="${bookDetail.bookID}" readonly="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Tiêu Đề: </td>
                        <td>
                            <input class="form-control" type="text" name="txtBookTitle" value="${bookDetail.title}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidTitle != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidTitle}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Mô Tả: </td>
                        <td>
                            <textarea style="height: 200px; margin: 5px 0 5px 0;" class="form-control" placeholder="Cuốn sách này nói về gì..." name="txtBookDesc" maxlength="4000">${bookDetail.description}</textarea>
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidDescription != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidDescription}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Tác Giả: </td>
                        <td>
                            <input class="form-control" type="text" name="txtAuthor" value="${bookDetail.author}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidAuthor != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidAuthor}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Số Lượng: </td>
                        <td>
                            <input class="form-control" type="number" name="txtQuantity" value="${bookDetail.quantity}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidQuantity != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidQuantity}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Đơn Giá (VNĐ): </td>
                        <td>
                            <input class="form-control" placeholder="Nhập giá của sách..." type="text" name="txtPrice" value="${bookDetail.price}" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidPrice != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidPrice}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td class="title-profile">Danh Mục: </td>
                        <td>
                            <select class="form-select" id="category-dropdown-list" name="cboCategory">
                                <c:forEach items="${requestScope.ALLCATEGORIES}" var="category">
                                    <option <c:if test="${bookDetail.categoryID eq category.categoryID}">selected="true"</c:if> value="${category.categoryID}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                            <input placeholder="Nhập tên danh mục mới..." type="text" class="form-control" id="category-input" name="txtNewCategory" value="${param.txtNewCategory}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="text-center" colspan="2">
                            <label class="form-check-label enable-createnew-category" for="flexCheckDefault">
                                Tôi muốn sửa thành một danh mục mới:
                            </label>
                            <input class="form-check-input checkbox" type="checkbox" name="check-box-newcategory" id="check-changenew-category" onclick="enableNewCategory()" />
                        </td>
                    </tr>
                    <c:if test="${requestScope.INVALID_REGISTER.invalidNewCategory != null}">
                        <tr>
                            <td colspan="2" class="text-center">
                                <font color="red">
                                ${requestScope.INVALID_REGISTER.invalidNewCategory}
                                </font>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <button class="btn btn-warning" type="submit" name="action" value="UpdateBook">Cập Nhật</button>
                            <a class="btn btn-outline-secondary" href="DispatchServlet">Hủy Bỏ</a>
                            <input type="hidden" name="dboCategoryBook" value="${param.dboCategoryBook}" />
                            <input type="hidden" name="txtSearchBook" value="${param.txtSearchBook}" />
                            <input type="hidden" name="dboFluctuatingPrice" value="${param.dboFluctuatingPrice}" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script>
            
            getListener();
            
            $("#file").change(function () {
                updateFile();
            });
        </script>
    </body>
</html>
