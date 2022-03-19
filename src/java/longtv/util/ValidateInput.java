/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.util;

import java.io.Serializable;
import longtv.daos.AccountDAO;
import longtv.daos.VoucherDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.CreateNewBookDTO;
import longtv.dtos.InvalidAccountDTO;
import longtv.dtos.InvalidBookDTO;
import longtv.dtos.InvalidVoucherDTO;
import longtv.dtos.VoucherDTO;

/**
 *
 * @author Admin
 */
public class ValidateInput implements Serializable {

    public static boolean validateEmail(String email) {
        return email.matches("^[a-zA-Z]+[a-zA-Z0-9\\-_]+@[a-zA-Z]+(\\.[a-zA-Z]+){1,3}$");
    }

    public static boolean validatePhone(String phone) {
        return phone.matches("[0-9]{5,20}");
    }

    public static boolean validateUsername(String username) {
        return (username.length() <= 50 && username.length() > 6);
    }

    public static boolean validatePassword(String password) {
        return (password.length() <= 50 && password.length() > 6);
    }

    public static boolean validateOTP(String otp) {
        return (otp.length() == 6);
    }

    public static boolean validateOldPassword(String password) {
        return (password.length() <= 50 && password.length() > 6);
    }

    public static boolean validateMatchingPassword(String password, String confirm) {
        return password.equals(confirm);
    }

    public static boolean validateFullName(String fullName) {
        return (fullName.length() >= 2 && fullName.length() <= 50);
    }

    public static boolean validatePhoto(String photo) {
        return photo.length() >= 3;
    }

    public static boolean validateExistEmail(String email, String username) throws Exception {
        AccountDAO checkAccount = new AccountDAO();
        return checkAccount.checkExistEmail(email, username);
    }

    public static boolean validateExistPhone(String phone, String username) throws Exception {
        AccountDAO checkAccount = new AccountDAO();
        return checkAccount.checkExistPhone(phone, username);
    }

    public static boolean validateExistUsername(String username) throws Exception {
        AccountDAO checkAccount = new AccountDAO();
        return checkAccount.checkExistUsername(username);
    }

    public static boolean checkCorrectOTP(String otp, String phone) throws Exception {
        AccountDAO checkAccount = new AccountDAO();
        return checkAccount.checkCorrectOTP(otp, phone);
    }

    public static boolean checkCorrectOldPassword(String username, String password) throws Exception {
        AccountDAO checkAccount = new AccountDAO();
        AccountDTO dto = checkAccount.checkLogin(username, password);
        return dto != null;
    }

    public static boolean validateHomeNo(String homeNo) throws Exception {
        return (homeNo.length() <= 50 && homeNo.length() > 6);
    }

    public static boolean validateDistrict(String district) throws Exception {
        return (district.length() <= 50 && district.length() > 6);
    }

    public InvalidAccountDTO checkUpdateAccount(AccountDTO dto, boolean updatePassword) throws Exception {
        InvalidAccountDTO errorObject = new InvalidAccountDTO();
        boolean valid = true;
        if (!validateEmail(dto.getEmail())) {
            errorObject.setInvalidEmail("Email không hợp lệ");
            valid = false;
        }

        if (!validateFullName(dto.getFullname())) {
            errorObject.setInvalidFullname("Tên quá dài hoặc ngắn");
            valid = false;
        }

        if (!validateHomeNo(dto.getHomeNumber())) {
            errorObject.setInvalidHomeNo("Số nhà, đường không hợp lệ");
            valid = false;
        }

        if (!validateDistrict(dto.getDistrict())) {
            errorObject.setInvalidDistrict("Phường quận không hợp lệ");
            valid = false;
        }

        if (validateExistEmail(dto.getEmail(), dto.getUsername())) {
            errorObject.setInvalidEmail("Email này đã tồn tại!");
            valid = false;
        }

        if (updatePassword) {
            if (!validatePassword(dto.getPassword())) {
                errorObject.setInvalidPassword("Mật khẩu không hợp lệ");
                valid = false;
            }
            if (!validateMatchingPassword(dto.getPassword(), dto.getConfirmPassword())) {
                errorObject.setInvalidConfirmPassword("Mật khẩu xác nhận không trùng khớp");
                valid = false;
            }
            if (!validateOldPassword(dto.getOldPassword())) {
                errorObject.setInvalidOldPassword("Mật khẩu cũ không hợp lệ");
                valid = false;
            }
        }
        errorObject.setValidateStatus(valid);
        return errorObject;
    }

    public InvalidAccountDTO statusValidate(AccountDTO dto) throws Exception {
        InvalidAccountDTO errorObject = new InvalidAccountDTO();
        boolean valid = true;
        if (!validateEmail(dto.getEmail())) {
            errorObject.setInvalidEmail("Email không hợp lệ");
            valid = false;
        }

        if (!validatePassword(dto.getPassword())) {
            errorObject.setInvalidPassword("Mật khẩu không hợp lệ");
            valid = false;
        }
        if (!validateMatchingPassword(dto.getPassword(), dto.getConfirmPassword())) {
            errorObject.setInvalidConfirmPassword("Mật khẩu xác nhận không trùng khớp");
            valid = false;
        }

        if (!validateUsername(dto.getUsername())) {
            errorObject.setInvalidUsername("Tài khoản không hợp lệ");
            valid = false;
        }

        if (!validateFullName(dto.getFullname())) {
            errorObject.setInvalidFullname("Tên quá dài hoặc ngắn");
            valid = false;
        }

        if (!validateOTP(dto.getOtp())) {
            errorObject.setWrongOTP("Vui lòng nhập OTP đầy đủ 6 số");
            valid = false;
        }

        if (validateExistEmail(dto.getEmail(), dto.getUsername())) {
            errorObject.setInvalidEmail("Email này đã tồn tại!");
            valid = false;
        }

        if (validateExistPhone(dto.getPhoneNumber(), dto.getUsername())) {
            errorObject.setInvalidPhone("Số điện thoại này đã tồn tại!");
            valid = false;
        }

        if (validateExistUsername(dto.getUsername())) {
            errorObject.setInvalidUsername("Tài khoản này đã tồn tại, vui lòng chọn một tài khoản khác!");
            valid = false;
        }

        errorObject.setValidateStatus(valid);
        return errorObject;
    }

    public static boolean validateBookQuantity(String quantity) {
        int quantityAfterCheck;
        try {
            quantityAfterCheck = Integer.parseInt(quantity);
        } catch (NumberFormatException e) {
            e.getMessage();
            return false;
        }
        return quantityAfterCheck > 0;
    }

    public static boolean validateBookPrice(String price) {
        float priceAfterCheck;
        try {
            priceAfterCheck = Float.parseFloat(price);
        } catch (NumberFormatException e) {
            e.getMessage();
            return false;
        }
        return priceAfterCheck > 0;
    }

    public static boolean validateBookAuthor(String author) {
        return (author.length() <= 50 && author.length() > 4);
    }

    public static boolean validateBookDescription(String description) {
        return (description.length() >= 5 && description.length() <= 4000);
    }

    public static boolean validateBookTitle(String title) {
        return (title.length() >= 5 && title.length() <= 300);
    }

    public static boolean validateBookImage(String bookPhoto) {
        return bookPhoto.length() >= 3;
    }

    public static boolean validateNewCategory(String newCategory) {
        return newCategory.length() >= 3 && newCategory.length() <= 50;
    }

    public InvalidBookDTO checkValidBookRegister(CreateNewBookDTO dto) throws Exception {
        InvalidBookDTO invalidDTO = new InvalidBookDTO();
        boolean isValidBook = true;
        if (!validateBookImage(dto.getImage())) {
            isValidBook = false;
            invalidDTO.setInvalidImage("Vui lòng đính kèm hình ảnh của cuốn sách.");
        }
        if (!validateBookTitle(dto.getTitle())) {
            isValidBook = false;
            invalidDTO.setInvalidTitle("Tiêu đề của sách ngắn hoặc dài quá, hãy chỉnh sửa lại.");
        }
        if (!validateBookDescription(dto.getDescription())) {
            isValidBook = false;
            invalidDTO.setInvalidDescription("Mô tả của sách ngắn hoặc dài quá, hãy chỉnh sửa lại.");
        }
        if (!validateBookAuthor(dto.getAuthor())) {
            isValidBook = false;
            invalidDTO.setInvalidAuthor("Tác giả của sách ngắn hoặc dài quá, hãy chỉnh sửa lại.");
        }
        if (!validateBookPrice(dto.getPrice())) {
            isValidBook = false;
            invalidDTO.setInvalidPrice("Giá cả của sách nhập không đúng định dạng.");
        }
        if (!validateBookQuantity(dto.getQuantity())) {
            isValidBook = false;
            invalidDTO.setInvalidQuantity("Số lượng của sách nhập không đúng định dạng.");
        }
        invalidDTO.setIsValidBook(isValidBook);
        return invalidDTO;
    }

    public static boolean validateDiscountPercent(String discount) {
        int discountPercent;
        try {
            discountPercent = Integer.parseInt(discount);
        } catch (NumberFormatException e) {
            e.getMessage();
            return false;
        }
        return discountPercent >= 1 && discountPercent <= 99;
    }

    public static boolean validateDiscountDescription(String description) {
        return (description.length() >= 5 && description.length() <= 200);
    }

    public static boolean validateDiscountCode(String code) {
        return code.length() >= 3 && code.length() <= 50;
    }

    public static boolean validateExpiredDate(String date) {
        return date.length() >= 3;
    }

    public static boolean checkExistDiscountCode(String code) throws Exception {
        VoucherDAO voucher = new VoucherDAO();
        return voucher.checkExistVoucher(code);
    }

    public InvalidVoucherDTO checkValidVoucher(VoucherDTO voucher) throws Exception {
        InvalidVoucherDTO invalidVoucher = new InvalidVoucherDTO();
        boolean isValidVoucher = true;

        if (!validateDiscountCode(voucher.getDiscountCode())) {
            isValidVoucher = false;
            invalidVoucher.setInvalidDiscountCode("Mã giảm giá không hợp lệ.");
        }

        if (!validateDiscountDescription(voucher.getDiscountDesc())) {
            isValidVoucher = false;
            invalidVoucher.setInvalidDiscountDesc("Vui lòng nêu rõ mô tả chi tiết, không dài quá 200 kí tự.");
        }

        if (!validateDiscountPercent(voucher.getDiscountPercent())) {
            isValidVoucher = false;
            invalidVoucher.setInvalidDiscountPercent("Phần trăm giảm giá phải nằm từ 1 đến 99%.");
        }

        if (!validateExpiredDate(voucher.getExpiredDate())) {
            isValidVoucher = false;
            invalidVoucher.setInvalidExpiredDate("Vui lòng chọn rõ thời gian hết hạn phiếu giảm giá.");
        }

        if (checkExistDiscountCode(voucher.getDiscountCode())) {
            isValidVoucher = false;
            invalidVoucher.setInvalidDiscountCode("Mã giảm giá này đã tồn tại rồi, vui lòng nhập mã khác!");
        }

        invalidVoucher.setIsValidVoucher(isValidVoucher);
        return invalidVoucher;
    }
}
