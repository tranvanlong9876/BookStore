/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.VoucherDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.InvalidVoucherDTO;
import longtv.dtos.VoucherDTO;
import longtv.util.ConvertInput;
import longtv.util.ValidateInput;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CreateNewVoucherServlet", urlPatterns = {"/CreateNewVoucherServlet"})
public class CreateNewVoucherServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String INVALID_ROLE = "SearchBookServlet";
    private static final String INVALID_VOUCHER = "createvoucher.jsp";
    private static final String SUCCESS = "SearchBookServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account != null) {
                if (account.getRolename().equals("Admin")) {
                    String voucherCode = request.getParameter("txtVoucherCode").toUpperCase().trim();
                    String voucherDesc = request.getParameter("txtVoucherDesc");
                    String discountPercent = request.getParameter("txtDiscountPercent");
                    String expireDate = request.getParameter("txtExpireDate");
                    VoucherDTO voucherDetails = new VoucherDTO(voucherCode, voucherDesc, expireDate, discountPercent);
                    ValidateInput checkValid = new ValidateInput();
                    InvalidVoucherDTO invalidVoucher = checkValid.checkValidVoucher(voucherDetails);
                    if (invalidVoucher.isIsValidVoucher()) {
                        Timestamp createTime = new Timestamp(new Date().getTime());
                        Timestamp expireTime = ConvertInput.convertInputDateTime(expireDate);
                        if(expireTime.compareTo(createTime) > 0) {
                            VoucherDAO dao = new VoucherDAO();
                            if(dao.createNewVoucher(voucherDetails, createTime, expireTime)) {
                                url = SUCCESS;
                                request.setAttribute("SEARCHBOOK_STATUS", "Mã Voucher mới: " + voucherCode + " đã được thêm vào thành công");
                            }
                        } else {
                            url = INVALID_VOUCHER;
                            invalidVoucher.setInvalidExpiredDate("Thời gian hết hạn phải xảy ra sau thời gian hiện tại.");
                            request.setAttribute("INVALID_VOUCHER", invalidVoucher);
                        }
                    } else {
                        url = INVALID_VOUCHER;
                        request.setAttribute("INVALID_VOUCHER", invalidVoucher);
                    }
                } else {
                    url = INVALID_ROLE;
                    request.setAttribute("SEARCHBOOK_STATUS", "Vai trò của bạn không đủ điều kiện để thực hiện yêu cầu này.");
                }
            } else {
                url = INVALID_ROLE;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập quyền Admin để thực hiện yêu cầu này!");
            }
        } catch (Exception e) {
            log("ERROR at CreateNewVoucherServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi tạo Voucher mới";
            String errorDetail = "Vui lòng liên hệ với quản trị viên để được hỗ trợ hoặc thử lại sau!";
            ErrorServletDTO error = new ErrorServletDTO(errorServlet, errorDetail);
            request.setAttribute("ERROR", error);
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
