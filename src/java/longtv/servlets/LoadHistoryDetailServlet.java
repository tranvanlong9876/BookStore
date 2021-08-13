/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.ShoppingDAO;
import longtv.daos.VoucherDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.BookCartListDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.HistoryHeaderDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadHistoryDetailServlet", urlPatterns = {"/LoadHistoryDetailServlet"})
public class LoadHistoryDetailServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String REDIRECT_TO_ORDER_DETAIL = "historydetail.jsp";
    private static final String INVALID_ROLE = "SearchBookServlet";

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
                String orderID = request.getParameter("orderID");
                if (orderID != null && !orderID.isEmpty()) {
                    Locale localeVN = new Locale("vi", "VN");
                    NumberFormat convertToVND = NumberFormat.getCurrencyInstance(localeVN);
                    ShoppingDAO dao = new ShoppingDAO();
                    List<BookCartListDTO> listDetail = dao.loadHistoryDetail(orderID);
                    HistoryHeaderDTO order = dao.getOrderHeaderWithOrderID(orderID);
                    float subTotal = 0;
                    float discountPrice = 0;
                    for (int i = 0; i < listDetail.size(); i++) {
                        subTotal += (listDetail.get(i).getBookPrice() * listDetail.get(i).getBookQuantity());
                    }
                    if (order.getDiscountCode() != null && !order.getDiscountCode().isEmpty()) {
                        VoucherDAO voucher = new VoucherDAO();
                        int discountPercent = voucher.getDiscountPercent(order.getDiscountCode());
                        discountPrice = (subTotal * discountPercent) / 100;
                    }
                    request.setAttribute("DISCOUNT_PRICE", convertToVND.format(discountPrice));
                    request.setAttribute("SUB_TOTAL", convertToVND.format(subTotal));
                    request.setAttribute("BOOK_LIST_ORDERDETAIL", listDetail);
                    request.setAttribute("ORDER_HEADER_DETAIL", order);

                    url = REDIRECT_TO_ORDER_DETAIL;
                }
            } else {
                url = INVALID_ROLE;
                request.setAttribute("SEARCHBOOK_STATUS", "Vui lòng đăng nhập để thực hiện yêu cầu này!");
            }
        } catch (Exception e) {
            log("ERRROR at LoadHistoryDetailServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi load dữ liệu đặt hàng";
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
