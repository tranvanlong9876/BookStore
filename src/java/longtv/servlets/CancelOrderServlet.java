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
import longtv.daos.ShoppingDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.HistoryHeaderDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/CancelOrderServlet"})
public class CancelOrderServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "LoadHistoryDetailServlet";

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
            Timestamp time = new Timestamp(new Date().getTime());
            Timestamp newTime = new Timestamp(time.getTime() + (10 * 1000));
            String desc = "";
            String nameAction = "";
            if (account != null) {
                String orderID = request.getParameter("orderID").trim();
                String reason = request.getParameter("txtReason");
                ShoppingDAO dao = new ShoppingDAO();
                int orderStatus = dao.loadOrderStatusBaseOnPK(orderID);
                int changeStatusTo = 0;
                if (account.getRolename().equals("User")) {
                    nameAction = account.getFullname();
                    switch (orderStatus) {
                        case 1:
                            changeStatusTo = 5;
                            break;
                        case 2:
                            changeStatusTo = 6;
                            break;
                    }

                    if (changeStatusTo == 5) {
                        HistoryHeaderDTO hhDTO = dao.getOrderHeaderWithOrderID(orderID);
                        desc = "Đơn hàng đã được tự động hủy thành công, chúng tôi sẽ xử lý và hoàn tiền (nếu có) cho bạn trong 24h đồng hồ.";
                        if (hhDTO.getPaymentPaypalID() != null) {
                            if (!dao.refundUserCheckOut(hhDTO.getPaypalAccount(), hhDTO.getPaymentPaypalID(), hhDTO.getPayAmountDollar(), orderID)) {
                                url = ERROR;
                            }
                        }
                    } else {
                        desc = "Đơn hàng đã được gửi yêu cầu hủy đến quản trị viên, bạn vui lòng chờ chúng tôi duyệt nhé.";
                    }
                    // end role User.
                } else if (account.getRolename().equals("Admin")) { 
                    nameAction = "Quản trị viên";
                    switch (orderStatus) {
                        case 1:
                            changeStatusTo = 5;
                            desc = "Đơn hàng đã hủy ngay lập tức do hành động của quản trị viên.";
                            break;
                        case 2:
                            changeStatusTo = 4;
                            desc = "Đơn hàng đã hủy ngay lập tức do hành động của quản trị viên, đồng thời nhà vận chuyển tiến hành vận chuyển hàng hóa về lại.";
                            break;
                    }
                    HistoryHeaderDTO hhDTO = dao.getOrderHeaderWithOrderID(orderID);
                    
                    if (hhDTO.getPaymentPaypalID() != null) {
                        if (!dao.refundUserCheckOut(hhDTO.getPaypalAccount(), hhDTO.getPaymentPaypalID(), hhDTO.getPayAmountDollar(), orderID)) {
                            url = ERROR;
                        }
                    }
                } 
                if (dao.changeOrderStatus(orderID, changeStatusTo)) {
                    if (dao.insertOrderExecuting(orderID, orderStatus, changeStatusTo, nameAction + " đã yêu cầu hủy đơn hàng với lý do: " + reason, account.getUsername(), time, 1)) {
                        url = SUCCESS;
                    }
                }
                dao.insertOrderExecuting(orderID, changeStatusTo, changeStatusTo, desc, "System", newTime, 1);
            }
        } catch (Exception e) {
            log("ERROR at CancelOrderServlet: " + e.getLocalizedMessage());
            String errorServlet = "Lỗi đã xảy ra khi cập nhật trạng thái đơn hàng";
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
