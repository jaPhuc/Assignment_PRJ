<%-- 
    Document   : register
    Created on : Mar 8, 2025, 8:43:20 AM
    Author     : giaph
--%>


<%@page import="model.Users"%>
<%@page import="dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>

        <div class="container">
            <!-- Thanh điều hướng -->
            <nav class="navbar navbar-light bg-light px-3">
                <a class="navbar-brand" href="mainPage">Library</a>
                <div class="ms-auto">
                    <a class="btn btn-success ms-2" href="register.jsp">Sign Up</a>
                </div>
            </nav>

            <!-- Form đăng nhập -->
            <div class="container d-flex justify-content-center align-items-center" style="min-height: 50vh;">
                <div class="w-50">
                    <h1 class="text-center mb-4">Login</h1>
                    <form method="post" action="Login">
                        <div class="mb-3">
                            <label class="form-label">Roll Number</label>
                            <input type="text" class="form-control" name="rollNumber" required placeholder="Enter Roll Number">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required placeholder="Enter your password">
                        </div>
                        <div class="text-left">
                            <button type="submit" class="btn btn-primary"><i class="bi bi-person-circle"></i> Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal thông báo -->
        <div class="modal fade" id="messageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Notification</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="messageContent"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let message = "<%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%>";
                let error = "<%= request.getAttribute("error") != null ? request.getAttribute("error") : ""%>";

                if (message !== "") {
                    document.getElementById("messageContent").innerText = message;
                    var modal = new bootstrap.Modal(document.getElementById('messageModal'));
                    modal.show();
                    setTimeout(() => {
                        window.location.href = "mainPage.jsp";
                    }, 2000);
                }

                if (error !== "") {
                    document.getElementById("messageContent").innerText = error;
                    var modal = new bootstrap.Modal(document.getElementById('messageModal'));
                    modal.show();
                }
            });
        </script>

    </body>
</html>