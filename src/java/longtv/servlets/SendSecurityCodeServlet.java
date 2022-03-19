/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.AccountDAO;
import longtv.dtos.AccountDTO;
import longtv.util.EncryptPassword;
import longtv.util.SendSMSAPI;
import longtv.util.ValidateInput;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SendSecurityCodeServlet", urlPatterns = {"/SendSecurityCodeServlet"})
public class SendSecurityCodeServlet extends HttpServlet {

    private static final String ERROR = "error";
    private static final String SUCCESS = "sendsuccess";
    private static final String INVALID_PHONE_NO = "invalidphone";
    private static final String ALREADY_EXIST_PHONE = "alreadyexist";

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
        String result = ERROR;
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            int code = (int) (100000 + (Math.random() * 899999));
            String encryptCode = EncryptPassword.encodePassword(String.valueOf(code));
            String phoneNumber = "";
            if (account == null) {
                phoneNumber = request.getParameter("txtPhone");
                if (ValidateInput.validatePhone(phoneNumber)) {
                    if (!ValidateInput.validateExistPhone(phoneNumber, "123")) {
                        AccountDAO dao = new AccountDAO();
                        if (dao.checkExistPhoneNumber(phoneNumber)) {
                            if (dao.updatePhoneSecurity(phoneNumber, encryptCode)) {
                                result = SUCCESS;
                            }
                        } else {
                            if (dao.insertPhoneSecurity(phoneNumber, encryptCode)) {
                                result = SUCCESS;
                            }
                        }
                    } else {
                        result = ALREADY_EXIST_PHONE;
                    }
                } else {
                    result = INVALID_PHONE_NO;
                }
            } else {
                phoneNumber = account.getPhoneNumber();
                AccountDAO dao = new AccountDAO();
                if (dao.checkExistPhoneNumber(phoneNumber)) {
                    if (dao.updatePhoneSecurity(phoneNumber, encryptCode)) {
                        result = SUCCESS;
                    }
                } else {
                    if (dao.insertPhoneSecurity(phoneNumber, encryptCode)) {
                        result = SUCCESS;
                    }
                }
            }
            if (result.equals(SUCCESS)) {
                SendSMSAPI sendCode = new SendSMSAPI();
                sendCode.setPhone(phoneNumber);
                sendCode.setMessage("OTP Dang Ky Tai Khoan Ban Sach: " + code);
                sendCode.sendGetJSON();
                System.out.println("Code : " + code );
            }

        } catch (Exception e) {
            log("ERROR at SendSecurityCodeServlet: " + e.getMessage());
        } finally {
            out.write(result);
            out.close();
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
