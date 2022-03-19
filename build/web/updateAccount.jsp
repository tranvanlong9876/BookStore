<%-- 
    Document   : updateAccount
    Created on : Mar 13, 2022, 12:55:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="./js/createnew.js" type="text/javascript"></script>
        <link rel="stylesheet" href="./css/newBook.css"/>
        <link rel="stylesheet" href="./css/updateAccount.css"/>
        <script src="./js/header_bar.js"></script>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
        <title>Thông tin cá nhân</title>
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
            <div style="margin: 0 auto; width: 50%; padding: 10px;">
                <div style="text-align: center;">
                    <img id="show-new-photo" style="cursor: pointer; border-radius: 50%; margin: 10px;" src="${requestScope.ACCOUNT_INFO.imageLink}" width="120px" height="120px" alt="">
                    <div id="check-click">
                        <p style="font-weight: bold; font-size: 20px; margin-top: 5px; ">${requestScope.ACCOUNT_INFO.fullname}</p>
                        <div style="display: none; margin: 0 auto; width: 44%;">
                            <input style="width: auto; font-size: 20px; font-weight: bold;" type="text" placeholder="Tên của bạn..." class="form-control text-center" value="${sessionScope.ACCOUNTDETAIL.fullname}" />
                        </div>
                    </div>
                    <input style="display: none;" type="file" id="choose-avatar" />
                </div>
            </div>
            <div style="display: flex; width: 90%; margin: 0 auto;">
                <div style="width: 60%;">
                    <p style="font-weight: bold; font-size: 20px;" class="text-center">THÔNG TIN CÁ NHÂN</p>
                    <table style="margin: 0 auto;" border="0">
                        <tbody>
                            <tr>
                                <td>Tên tài khoản:<br/>
                                </td>
                                <td>${requestScope.ACCOUNT_INFO.username}</td>
                            </tr>
                            <tr>
                                <td>Họ tên: </td>
                                <td><input type="text" id="txtFullname" style="width: auto;" class="form-control" value="${requestScope.ACCOUNT_INFO.fullname}" /></td>
                            </tr>
                            <tr class="invalid-fullname">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-fullname-text"></p>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td>Vai trò: </td>
                                <td>${requestScope.ACCOUNT_INFO.rolename}</td>
                            </tr>
                            <tr>
                                <td>Giới Tính: </td>
                                <td>
                                    <select id="cboBirthDay" class="form-select" name="">
                                        <option <c:if test="${requestScope.ACCOUNT_INFO.gender eq 'M'}">selected="true"</c:if> value="M">Nam</option>
                                        <option <c:if test="${requestScope.ACCOUNT_INFO.gender eq 'F'}">selected="true"</c:if> value="F">Nữ</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày sinh: </td>
                                    <td>
                                        <input id="date-birthday" style="border: 0; width: auto; font-weight: 500; cursor: pointer" type="text" class="fa fa-calendar birthday" readonly="" />
                                        <input type="hidden" id="birthday-param" value="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><p class="text-center" style="margin: 5px 0 -5px 0; font-weight: bold; font-size: 20px">ĐỊA CHỈ GIAO HÀNG</p></td>
                                </tr>
                                <tr>
                                    <td>Số nhà, đường: </td>
                                    <td>
                                        Phường, Quận:
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="home-no" class="form-control" type="text" placeholder="Số nhà, đường chỗ ở" value="${requestScope.ACCOUNT_INFO.homeNumber}" />
                                </td>
                                <td>
                                    <input id="district" class="form-control" type="text" placeholder="Quận huyện, thành phố" value="${requestScope.ACCOUNT_INFO.district}" />
                                </td>
                            </tr>
                            <tr class="invalid-home-no">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-home-no-text"></p>
                                    </font>
                                </td>
                            </tr>
                            <tr class="invalid-district">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-district-text"></p>
                                    </font>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div style="width: 40%;">
                    <p style="font-weight: bold; font-size: 20px;" class="text-center">HỆ THỐNG BẢO MẬT</p>
                    <table style="margin: 0 auto;" border="0">
                        <tbody>
                            <tr>
                                <td>Số điện thoại:<br/>
                                </td>
                                <td>
                                    <span id="phone-number"></span>
                                    <input type="hidden" id="phone-number-hidden" value="${requestScope.ACCOUNT_INFO.phoneNumber}" />
                                </td>

                            </tr>
                            <tr>
                                <td>Email: </td>
                                <td><input id="txtEmail" type="text" style="width: auto;" class="form-control" value="${requestScope.ACCOUNT_INFO.email}" /></td>
                            </tr>
                            <tr class="invalid-email">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-email-text"></p>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td>Thay đổi mật khẩu: </td>
                                <td><input style="display: block; padding: 10px;" class="form-check-input checkbox" type="checkbox" name="check-box-password" id="check-change-password" onclick="enablePasswordText()"></td>
                            </tr>

                            <tr class="password-field removed">
                                <td colspan="2"><p class="text-center" style="margin: 5px 0 -5px 0; font-weight: bold; font-size: 20px">QUẢN LÝ MẬT KHẨU</p></td>
                            </tr>
                            <tr class="password-field removed">
                                <td>Mật khẩu mới: </td>
                                <td>
                                    Xác nhận mật khẩu:
                                </td>
                            </tr>
                            <tr class="password-field removed">
                                <td>
                                    <input id="new-password-field" class="form-control" type="password" placeholder="Nhập mật khẩu mới" />
                                </td>
                                <td>
                                    <input id="confirm-password-field" class="form-control" type="password" placeholder="Xác nhận mật khẩu mới" />
                                </td>
                            </tr>
                            <tr class="invalid-password">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-password-text"></p>
                                    </font>
                                </td>
                            </tr>
                            <tr class="invalid-confirm-password">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-confirm-password-text"></p>
                                    </font>
                                </td>
                            </tr>
                            <tr class="password-field removed">
                                <td class="text-center" colspan="2">Mật khẩu cũ: </td
                            </tr>
                            <tr class="password-field removed">
                                <td class="text-center" colspan="2">               
                                    <div style="margin: 0 auto; width: 70%;">
                                        <input id="old-password-field" class="form-control text-center" type="password" placeholder="Nhập mật khẩu cũ" />
                                    </div>
                                </td>
                            </tr>
                            <tr class="invalid-old-password">
                                <td colspan="2" class="text-center">
                                    <font color="red">
                                    <p id="invalid-old-password-text"></p>
                                    </font>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="margin: 10px auto 10px auto; width: 50%; padding: 10px;">
                <div style="text-align: center;">
                    <button style="margin-right: 10px;" type="button" onclick="popupUpdateBox();" class="btn btn-success">Cập Nhật</button>
                    <a href="DispatchServlet" class="btn btn-danger">Hủy Bỏ</a>
                </div>
            </div>
        </div>
        <div class="popup-delete" id="popup-full-delete">
            <div class="popup-content-delete" id="popup-khung-delete">
                <h4 style="padding-top: 20px;" class="title-pop-up login text-center">Cập Nhật Thông Tin Cá Nhân</h4>
                <i class="far fa-times-circle close-delete-popup"></i>
                <div class="detail-pop-up">
                    <h6 style="padding-top: 30px; margin: 0 10px 0 10px;" class="text-center">Bạn có chắc chắn muốn cập nhật thông tin cá nhân mới không ? <span style="color: red;">Sau khi cập nhật thành công sẽ cần đăng nhập lại để lưu mọi thay đổi.</span></h6>
                    <div style="margin: 0 auto; width: 50%;">
                        <table class="table-delete" style="margin-left: 20%; margin-top: 30px; margin-bottom: 30px;">
                            <tbody>
                                <tr>
                                    <td class="text-center" colspan="2">
                                        <button type="submit" value="RemoveCart" name="action" onclick="ajaxExecuteUpdateUser();" class="btn btn-danger">XÁC NHẬN</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="closeDeletePopup();">HỦY BỎ</button>
                                        <input type="hidden" id="bookID-delete-hidden" name="txtBookDeleteID" value="" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>

            getListener();

            let date = new Date(Date.parse("${requestScope.ACCOUNT_INFO.dayOfBirth}"));
            var month = date.getUTCMonth() + 1; //months from 1-12
            var day = date.getUTCDate();
            var year = date.getUTCFullYear();
            loadDate(day, month, year);
            if (isNaN(year)) {
                document.getElementById("date-birthday").value = "Vui lòng chọn ngày sinh!"
            }

            function loadDate(day, month, year) {
                document.getElementById("date-birthday").value = day + " tháng " + month + " năm " + year;
                document.getElementById("birthday-param").value = year + "/" + month + "/" + day;
            }

            $("#choose-birthday").datepicker();

            document.querySelector(".fa.fa-calendar.birthday").addEventListener("click", function () {
                $('.fa.fa-calendar.birthday').datepicker('show');
            });

            $('.fa.fa-calendar.birthday').change(function () {
                let dateUpdate = new Date(Date.parse(document.querySelector(".fa.fa-calendar.birthday").value));
                dateUpdate.setDate(dateUpdate.getDate() + 1);
                var month1 = dateUpdate.getUTCMonth() + 1; //months from 1-12
                var day1 = dateUpdate.getUTCDate();
                var year1 = dateUpdate.getUTCFullYear();
                if ((document.querySelector(".fa.fa-calendar.birthday").value).length == 0) {
                    document.getElementById("date-birthday").value = "Vui lòng chọn ngày sinh!";
                }
                if (!isNaN(year1)) {
                    loadDate(day1, month1, year1);
                }
            });

            function ajaxExecuteUpdateUser() {
                var fullName = document.getElementById("txtFullname").value;
                var birthday = document.getElementById("birthday-param").value;
                var gender = document.getElementById("cboBirthDay").value;
                var homeNo = document.getElementById("home-no").value;
                var district = document.getElementById("district").value;
                var isChangePassword = document.getElementById("check-change-password").checked;
                var oldPassword = document.getElementById("old-password-field").value;
                var newPassword = document.getElementById("new-password-field").value;
                var confirmPassword = document.getElementById("confirm-password-field").value;
                var photoLink = document.getElementById("show-new-photo").src;
                var email = document.getElementById("txtEmail").value;

                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {
                        photoLink: photoLink,
                        txtNewPassword: newPassword,
                        txtConfirm: confirmPassword,
                        txtOldPassword: oldPassword,
                        txtFullName: fullName,
                        email: email,
                        birthday: birthday,
                        gender: gender,
                        homeNo: homeNo,
                        district: district,
                        isChangePassword: isChangePassword,
                        action: "UpdateAccountForm"
                    },
                    success: function (data, textStatus, jqXHR) {
                        closeDeletePopup();
                        var jsonResponse = JSON.parse(data);
                        const responseCode = jsonResponse.responseCode;
                        switch (responseCode) {
                            case 2:
                                document.querySelector(".invalid-fullname").style.display = "none";
                                document.querySelector(".invalid-home-no").style.display = "none";
                                document.querySelector(".invalid-district").style.display = "none";
                                document.querySelector(".invalid-email").style.display = "none";
                                document.querySelector(".invalid-password").style.display = "none";
                                document.querySelector(".invalid-confirm-password").style.display = "none";
                                document.querySelector(".invalid-old-password").style.display = "none";
                                if (typeof jsonResponse.invalidFullname !== 'undefined') {
                                    document.querySelector(".invalid-fullname").style.display = "table-row";
                                    document.getElementById("invalid-fullname-text").innerHTML = jsonResponse.invalidFullname;
                                }
                                if (typeof jsonResponse.invalidHomeNo !== 'undefined') {
                                    document.querySelector(".invalid-home-no").style.display = "table-row";
                                    document.getElementById("invalid-home-no-text").innerHTML = jsonResponse.invalidHomeNo;
                                }
                                if (typeof jsonResponse.invalidDistrict !== 'undefined') {
                                    document.querySelector(".invalid-district").style.display = "table-row";
                                    document.getElementById("invalid-district-text").innerHTML = jsonResponse.invalidDistrict;
                                }
                                if (typeof jsonResponse.invalidEmail !== 'undefined') {
                                    document.querySelector(".invalid-email").style.display = "table-row";
                                    document.getElementById("invalid-email-text").innerHTML = jsonResponse.invalidEmail;
                                }
                                if (typeof jsonResponse.invalidPassword !== 'undefined') {
                                    document.querySelector(".invalid-password").style.display = "table-row";
                                    document.getElementById("invalid-password-text").innerHTML = jsonResponse.invalidPassword;
                                }
                                if (typeof jsonResponse.invalidOldPassword !== 'undefined') {
                                    document.querySelector(".invalid-old-password").style.display = "table-row";
                                    document.getElementById("invalid-old-password-text").innerHTML = jsonResponse.invalidOldPassword;
                                }
                                if (typeof jsonResponse.invalidConfirmPassword !== 'undefined') {
                                    document.querySelector(".invalid-confirm-password").style.display = "table-row";
                                    document.getElementById("invalid-confirm-password-text").innerHTML = jsonResponse.invalidConfirmPassword;
                                }
                                break;
                            case 1:
                                window.location.href = "DispatchServlet?action=Logout";
                                break;
                            default:
                                break;
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });

            }

            function popupUpdateBox() {
                document.querySelector(".popup-delete").style.display = "flex";
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

            var firstImage = document.getElementById("show-new-photo").src;

            $("#choose-avatar").change(function () {
                updateAvatar(firstImage);
            });

            document.getElementById("show-new-photo").addEventListener("click", function () {
                document.getElementById("choose-avatar").click();
            });

            var phoneNo = document.getElementById("phone-number-hidden").value;

            var phoneNoAfterExecute = "";
            var count = 1;
            var addDot = 0;
            for (var i = 0; i < phoneNo.length; i++) {
                phoneNoAfterExecute += phoneNo[i];
                count++;
                if (count == 4 && addDot < 2) {
                    phoneNoAfterExecute += ".";
                    addDot += 1;
                    ;
                    count = 1;
                }
            }

            document.getElementById("phone-number").innerHTML = phoneNoAfterExecute;

            function enablePasswordText() {
                var checkBox = document.getElementById("check-change-password");
                var list = document.querySelectorAll(".password-field");
                if (checkBox.checked) {
                    for (var i = 0; i < list.length; ++i) {
                        list[i].classList.remove('removed');
                    }
                } else {
                    for (var i = 0; i < list.length; ++i) {
                        list[i].classList.add('removed');
                    }
                }
            }

        </script>
    </body>
</html>
