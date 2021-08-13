/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.util;

import java.io.Serializable;
import longtv.daos.VoucherDAO;
import longtv.dtos.CreateNewBookDTO;
import longtv.dtos.InvalidBookDTO;
import longtv.dtos.InvalidVoucherDTO;
import longtv.dtos.VoucherDTO;

/**
 *
 * @author Admin
 */
public class ValidateInput implements Serializable {

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
