/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import longtv.daos.ShoppingDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.HistoryHeaderDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ConsiderCancelRequestServlet", urlPatterns = {"/ConsiderCancelRequestServlet"})
public class ConsiderCancelRequestServlet extends HttpServlet {
    private static final String ERROR = "error";
    private static final String SUCCESS = "success";

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
        PrintWriter out = response.getWriter();
        String successCode = ERROR;
        try {
            AccountDTO account = (AccountDTO) request.getSession().getAttribute("ACCOUNTDETAIL");
            if(account != null) {
                if(account.getRolename().equals("Admin")) {
                    int requestCode = Integer.parseInt(request.getParameter("optionCode"));
                    String orderID = request.getParameter("orderID");
                    ShoppingDAO dao = new ShoppingDAO();
                    Timestamp time = new Timestamp(new Date().getTime());
                    if(requestCode == 1) {
                        dao.changeOrderStatus(orderID, 4);
                        dao.insertOrderExecuting(orderID, 6, 4, "Yêu cầu hủy đơn hàng của bạn đã được chấp nhận, đồng thời Shipper tiến hành quá trình trả hàng.", account.getFullname(), time, 1);
                        HistoryHeaderDTO dto = dao.getOrderHeaderWithOrderID(orderID);
                        if(dto.getPaymentPaypalID() != null) {
                            dao.refundUserCheckOut(dto.getPaypalAccount(), dto.getPaymentPaypalID(), dto.getPayAmountDollar(), orderID);
                        }
                    } else {
                        dao.changeOrderStatus(orderID, 2);
                        dao.insertOrderExecuting(orderID, 6, 2, "Yêu cầu hủy đon hàng của bạn đã bị từ chối, đơn hàng sẽ tiếp tục được giao.", account.getFullname(), time, 1);
                    }
                   successCode = SUCCESS;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.write(successCode);
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
