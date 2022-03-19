/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtv.daos.AccountDAO;
import longtv.dtos.AccountDTO;
import longtv.dtos.ErrorServletDTO;
import longtv.dtos.InvalidAccountDTO;
import longtv.util.EncryptPassword;
import longtv.util.ValidateInput;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RegisterAccountServlet", urlPatterns = {"/RegisterAccountServlet"})
public class RegisterAccountServlet extends HttpServlet {

    private static final int VALIDATE_FAIL = 2;
    private static final int ERROR = 1;
    private static final int ALREADY_LOGIN = 0;
    private static final int SUCCESS = 3;

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        int responseCode = ERROR;
        PrintWriter out = response.getWriter();
        InvalidAccountDTO errorObj = null;
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account == null) {
                String otpReceived = request.getParameter("txtOTP").trim();
                String username = request.getParameter("txtUsername").trim().toLowerCase();
                String password = request.getParameter("txtPassword");
                String confirmPassword = request.getParameter("txtConfirm");
                String fullName = request.getParameter("txtFullName");
                String email = request.getParameter("txtEmail");
                String phone = request.getParameter("txtPhone");
                String fileName = request.getParameter("photoLink");
                AccountDTO dto = new AccountDTO();
                dto.setUsername(username);
                dto.setPassword(password);
                dto.setConfirmPassword(confirmPassword);
                dto.setFullname(fullName);
                dto.setEmail(email);
                dto.setPhoneNumber(phone);
                dto.setImageLink(fileName);
                dto.setOtp(otpReceived);
                ValidateInput input = new ValidateInput();
                errorObj = input.statusValidate(dto);
                if (errorObj.isValidateStatus()) {
                    String encryptOTP = EncryptPassword.encodePassword(dto.getOtp());
                    String encryptPassword = EncryptPassword.encodePassword(password);
                    dto.setPassword(encryptPassword);
                    AccountDAO dao = new AccountDAO();
                    if (dao.checkCorrectOTP(encryptOTP, dto.getPhoneNumber())) {
                        if (dao.insertAccountDetail(dto, 2)) {
                            responseCode = SUCCESS;
                        }
                    } else {
                        responseCode = VALIDATE_FAIL;
                        errorObj.setWrongOTP("Mã OTP không đúng hoặc đã thay đổi số điện thoại, vui lòng kiểm tra lại.");
                    }
                } else {
                    responseCode = VALIDATE_FAIL;
                }
            } else {
                responseCode = ALREADY_LOGIN;
            }
        } catch (Exception e) {
            log("ERROR at RegisterAccountServlet: " + e.getMessage());
            String errorServlet = "Lỗi đã xảy ra khi đăng ký tài khoản";
            String errorDetail = "Vui lòng liên hệ với quản trị viên để được hỗ trợ hoặc thử lại sau!";
            ErrorServletDTO error = new ErrorServletDTO(errorServlet, errorDetail);
            request.setAttribute("ERROR", error);
        } finally {
            errorObj.setResponseCode(responseCode);
            Gson gson = new Gson();
            String jsonRes = gson.toJson(errorObj);
            out.write(jsonRes);
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
        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(RegisterAccountServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(RegisterAccountServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
