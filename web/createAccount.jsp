<%-- 
    Document   : createAccount
    Created on : Feb 28, 2022, 8:48:26 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo Tài Khoản</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="./js/createnew.js" type="text/javascript"></script>
        <link rel="stylesheet" href="./css/newBook.css"/>
        <link rel="stylesheet" href="https://getbootstrap.com/docs/5.0/dist/css/bootstrap.min.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
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
                        <c:redirect url="DispatchServlet" />
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
                                <a class="btn btn-success" href="DispatchServlet?action=CreateVoucherPage">Thêm Voucher Mới</a>
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
        <h1 style="text-align: center;">Tạo Tài Khoản</h1>
        <form action="DispatchServlet" method="POST" id="check-valid">
            <table class="register-form" border="0" style="margin-left: 500px;">
                <tbody>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <h6>Vui lòng nhập đầy đủ thông tin tài khoản</h6>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-center" colspan="2">
                            <img class="img-avatar" src="images/default-avatar.jpg" width="150px" height="200px" id="img-avatar-id" alt=""/>
                            <input type="hidden" id="link-avatar" name="avatarImageLink" value="images/default-avatar.jpg" />
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Avatar: 
                        </td>
                        <td>
                            <input class="form-control" type="file" id="file" name="txtAvatar" />
                        </td>
                    </tr>
                    <tr class="invalid-avatar-image">
                        <td colspan="2">
                            <font color="red">
                            <p style="text-align: center;" id="file-status"></p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Tài Khoản: </td>
                        <td>
                            <input class="form-control" type="text" id="cust-username" name="txtUsername" value="${param.txtUsername}" />
                        </td>
                    </tr>
                    <tr class="invalid-username">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-username-text"></p>
                            </font>
                        </td>
                    <tr>
                    <tr>
                        <td class="title-profile">Mật khẩu: </td>
                        <td>
                            <input class="form-control" type="password" id="cust-password" name="txtPassword" value="" />
                        </td>
                    </tr>
                    <tr class="invalid-password">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-password-text"></p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Xác nhận mật khẩu: </td>
                        <td>
                            <input class="form-control" type="password" id="cust-confirm-password" name="txtConfirmPassword" value="" />
                        </td>
                    </tr>
                    <tr class="invalid-confirm-password">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-confirm-password-text"></p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Họ và Tên: </td>
                        <td>
                            <input class="form-control" type="text" id="cust-fullname" name="txtFullname" value="${param.txtFullname}" />
                        </td>
                    </tr>
                    <tr class="invalid-fullname">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-fullname-text"></p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Số Điện Thoại: </td>
                        <td>
                            <input class="form-control" id="phone-number-verify" placeholder="090xxxxxxx" type="text" name="txtPhone" value="${param.txtPhone}" />
                        </td>
                        <td>
                            <button class="btn btn-primary" id="btn-send-otp" type="button" onclick="callAjaxSendOTP();">Gửi Mã OTP</button>
                        </td>
                    </tr>
                    <tr class="status-send-phonecode">
                        <td colspan="3" class="text-center">
                            <font color="red">
                            <p style="text-align: center;" id="sendcode-status">Chúng tôi sẽ gửi mã OTP để xác minh số điện thoại của bạn</p>
                            </font>
                        </td>
                    </tr>
                    <tr class="otp-code-field" style="display: none;">
                        <td class="title-profile">Mã OTP: </td>
                        <td>
                            <input class="form-control" id="cust-otp" placeholder="Nhập mã xác minh 6 số của bạn" type="text" name="txtOTP" value="${param.txtOTP}" />
                        </td>
                    </tr>
                    <tr class="invalid-otp">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-otp-text"></p>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="title-profile">Email: </td>
                        <td>
                            <input class="form-control" id="cust-email" placeholder="abc@gmail.com" type="text" name="txtEmail" value="${param.txtEmail}" />
                        </td>
                    </tr>
                    <tr class="invalid-email">
                        <td colspan="2" class="text-center">
                            <font color="red">
                            <p id="invalid-email-text"></p>
                            </font>
                        </td>
                    </tr>
                    <tr style="padding-bottom: 100px;">
                        <td style="text-align: center;" colspan="2">
                            <button type="button" id="button-register-account" class="btn btn-success" disabled="true" style="margin-right: 10px; " onclick="callAjaxCreateAccount();" type="button" name="action">Tạo Tài Khoản</button>
                            <a class="btn btn-outline-secondary" href="DispatchServlet">Hủy Bỏ</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script>
            $("#file").change(function () {
                addAvatar();
            });

            function callAjaxCreateAccount() {
                var avatar = document.getElementById("link-avatar").value;
                var username = document.getElementById("cust-username").value;
                var password = document.getElementById("cust-password").value;
                var confirmPassword = document.getElementById("cust-confirm-password").value;
                var fullName = document.getElementById("cust-fullname").value;
                var phoneNo = document.getElementById("phone-number-verify").value;
                var otp = document.getElementById("cust-otp").value;
                var email = document.getElementById("cust-email").value;

                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {
                        txtUsername: username,
                        photoLink: avatar,
                        txtPassword: password,
                        txtConfirm: confirmPassword,
                        txtFullName: fullName,
                        txtEmail: email,
                        txtPhone: phoneNo,
                        txtOTP: otp,
                        action: "RegisterAccount"
                    },
                    success: function (data, textStatus, jqXHR) {
                        var jsonResponse = JSON.parse(data);
                        const responseCode = jsonResponse.responseCode;
                        switch (responseCode) {
                            case 2:
                                document.querySelector(".invalid-username").style.display = "none";
                                document.querySelector(".invalid-password").style.display = "none";
                                document.querySelector(".invalid-confirm-password").style.display = "none";
                                document.querySelector(".invalid-fullname").style.display = "none";
                                document.querySelector(".invalid-otp").style.display = "none";
                                document.querySelector(".invalid-email").style.display = "none";
                                if (typeof jsonResponse.invalidUsername !== 'undefined') {
                                    document.querySelector(".invalid-username").style.display = "table-row";
                                    document.getElementById("invalid-username-text").innerHTML = jsonResponse.invalidUsername;
                                }
                                if (typeof jsonResponse.invalidPassword !== 'undefined') {
                                    document.querySelector(".invalid-password").style.display = "table-row";
                                    document.getElementById("invalid-password-text").innerHTML = jsonResponse.invalidPassword;
                                }
                                if (typeof jsonResponse.invalidConfirmPassword !== 'undefined') {
                                    document.querySelector(".invalid-confirm-password").style.display = "table-row";
                                    document.getElementById("invalid-confirm-password-text").innerHTML = jsonResponse.invalidConfirmPassword;
                                }
                                if (typeof jsonResponse.invalidFullname !== 'undefined') {
                                    document.querySelector(".invalid-fullname").style.display = "table-row";
                                    document.getElementById("invalid-fullname-text").innerHTML = jsonResponse.invalidFullname;
                                }
                                if (typeof jsonResponse.wrongOTP !== 'undefined') {
                                    document.querySelector(".invalid-otp").style.display = "table-row";
                                    document.getElementById("invalid-otp-text").innerHTML = jsonResponse.wrongOTP;
                                }
                                if (typeof jsonResponse.invalidEmail !== 'undefined') {
                                    document.querySelector(".invalid-email").style.display = "table-row";
                                    document.getElementById("invalid-email-text").innerHTML = jsonResponse.invalidEmail;
                                }
                                break;
                            case 3:
                                window.location.href = "DispatchServlet?action=LoginPage&status=Tài khoản đã được tạo thành công, chúc bạn đăng nhập mua sách vui vẻ!";
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

            function callAjaxSendOTP() {
                var phoneNo = document.getElementById("phone-number-verify").value;
                var success = "sendsuccess";
                var invalidphone = "invalidphone";
                var alreadyexistphone = "alreadyexist";
                var count = 30;
                $.ajax({
                    url: "DispatchServlet",
                    method: "POST",
                    data: {txtPhone: phoneNo, action: "SendSecurityCode"},
                    success: function (data, textStatus, jqXHR) {
                        switch (data) {
                            case success :
                                document.getElementById("btn-send-otp").disabled = true;
                                document.querySelector(".status-send-phonecode").style.display = "table-row";
                                document.getElementById("sendcode-status").innerHTML = "Mã OTP đã được gửi đến số điện thoại, vui lòng nhập mã OTP dưới đây.";
                                document.querySelector(".otp-code-field").style.display = "table-row";
                                document.getElementById("button-register-account").disabled = false;
                                setTimeout(function () {
                                    document.getElementById("btn-send-otp").disabled = false;
                                }, 31000);
                                var intervalId = setInterval(function () {
                                    document.getElementById("btn-send-otp").innerHTML = count + " s";
                                    count--;
                                    if (count == -1) {
                                        clearInterval(intervalId);
                                        document.getElementById("btn-send-otp").innerHTML = "Gửi lại mã OTP";
                                    }
                                }, 1000);
                                break;
                            case alreadyexistphone :
                                document.querySelector(".status-send-phonecode").style.display = "table-row";
                                document.getElementById("sendcode-status").innerHTML = "Số điện thoại đã liên kết với một tài khoản khác rồi, vui lòng nhập số mới.";
                                break;
                            case invalidphone :
                                document.querySelector(".status-send-phonecode").style.display = "table-row";
                                document.getElementById("sendcode-status").innerHTML = "Số điện thoại không đúng định dạng, vui lòng nhập chính xác.";
                                break;
                            default :
                                console.log("Error.");
                                break;
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            }
        </script>
    </body>
</html>

