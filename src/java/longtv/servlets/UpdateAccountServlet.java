/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.servlets;

import com.google.gson.Gson;
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
import longtv.dtos.InvalidAccountDTO;
import longtv.util.EncryptPassword;
import longtv.util.ValidateInput;
import static longtv.util.ValidateInput.checkCorrectOldPassword;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/UpdateAccountServlet"})
public class UpdateAccountServlet extends HttpServlet {

    private static final int ERROR = 0;
    private static final int SUCCESS = 1;
    private static final int INVALID = 2;

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
        int url = ERROR;
        InvalidAccountDTO invalid = null;
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNTDETAIL");
            if (account != null) {
                boolean updatePassword = Boolean.parseBoolean(request.getParameter("isChangePassword"));
                String fullName = request.getParameter("txtFullName");
                String gender = request.getParameter("gender");
                String birthDay = request.getParameter("birthday");
                String email = request.getParameter("email");
                String homeNo = request.getParameter("homeNo");
                String district = request.getParameter("district");
                String newPassword = request.getParameter("txtNewPassword");
                String confirmPassword = request.getParameter("txtConfirm");
                String oldPassword = request.getParameter("txtOldPassword");
                String photoLink = request.getParameter("photoLink");
                AccountDTO dtoUpdate = new AccountDTO();
                dtoUpdate.setUsername(account.getUsername());
                dtoUpdate.setFullname(fullName);
                dtoUpdate.setGender(gender);
                dtoUpdate.setDayOfBirth(birthDay);
                dtoUpdate.setEmail(email);
                dtoUpdate.setHomeNumber(homeNo);
                dtoUpdate.setDistrict(district);
                dtoUpdate.setOldPassword(oldPassword);
                dtoUpdate.setPassword(newPassword);
                dtoUpdate.setConfirmPassword(confirmPassword);
                dtoUpdate.setImageLink(photoLink);
                ValidateInput validate = new ValidateInput();
                invalid = validate.checkUpdateAccount(dtoUpdate, updatePassword);
                if (invalid.isValidateStatus()) {
                    AccountDAO dao = new AccountDAO();
                    if (dao.updateAccountInfo(dtoUpdate, account.getUsername())) {
                        url = SUCCESS;
                        if (updatePassword) {
                            dtoUpdate.setOldPassword(EncryptPassword.encodePassword(dtoUpdate.getOldPassword()));
                            if (!checkCorrectOldPassword(dtoUpdate.getUsername(), dtoUpdate.getOldPassword())) {
                                invalid.setInvalidOldPassword("Sai mật khẩu cũ, vui lòng nhập lại!");
                                url = INVALID;
                            } else {
                                dao.updatePassword(EncryptPassword.encodePassword(dtoUpdate.getPassword()), account.getUsername());
                            }
                        }
                    }
                } else {
                    url = INVALID;
                }

            }
        } catch (Exception e) {
            e.getMessage();
        } finally {
            invalid.setResponseCode(url);
            Gson gson = new Gson();
            String jsonRes = gson.toJson(invalid);
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
