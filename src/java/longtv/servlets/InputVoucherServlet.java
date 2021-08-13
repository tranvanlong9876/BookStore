/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.VoucherDAO;
import longtv.dtos.BookCartDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.VoucherDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "InputVoucherServlet", urlPatterns = {"/InputVoucherServlet"})
public class InputVoucherServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "UpdateCartDetailServlet";
    private static final String NOT_EXIST = "SearchBookServlet";

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
            String voucherCode = request.getParameter("txtVoucherCode").toUpperCase().trim();
            if (voucherCode == null) {
                voucherCode = "";
            }
            VoucherDAO dao = new VoucherDAO();
            VoucherDTO voucher = dao.applyVoucherDetail(voucherCode);
            BookCartDTO cart = (BookCartDTO) session.getAttribute("BOOKCARTDETAIL");
            if (voucher != null) {
                if (cart != null) {
                    cart.setVoucher(voucher);
                    session.setAttribute("BOOKCARTDETAIL", cart);
                    url = SUCCESS;
                } else {
                    url = NOT_EXIST;
                    request.setAttribute("SEARCHBOOK_STATUS", "Giỏ hàng không còn tồn tại nữa, bạn tiếp tục mua sắm nhé!");
                }
            } else {
                if (cart != null) {
                    cart.setVoucher(null);
                    session.setAttribute("BOOKCARTDETAIL", cart);
                    url = SUCCESS;
                    request.setAttribute("STATUS_VOUCHER", "Thông tin mã giảm giá bạn nhập không chính xác hoặc đã hết hạn sử dụng.");
                } else {
                    url = NOT_EXIST;
                    request.setAttribute("SEARCHBOOK_STATUS", "Giỏ hàng không còn tồn tại nữa, bạn tiếp tục mua sắm nhé!");
                }
            }
        } catch (Exception e) {
            log("ERROR at InputVoucherServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi nhập thông tin Voucher";
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
