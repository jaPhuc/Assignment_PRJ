<%-- 
    Document   : register
    Created on : Mar 9, 2025, 10:52:54 AM
    Author     : giaph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <!-- Thanh điều hướng -->
            <nav class="navbar navbar-light bg-light px-3">
                <a class="navbar-brand" href="#">Library</a>
                <div class="ms-auto">
                    <a class="btn btn-success ms-2" href="login.jsp">Login</a>
                </div>
            </nav>

            <!-- Form đăng ký -->
            <div class="container d-flex justify-content-center align-items-center" style="min-height: 60vh;">
                <div class="w-50">
                    <h1 class="text-center mb-4">Register</h1>
                    <form method="post" action="Register">
                        <div class="mb-3">
                            <label class="form-label">Roll Number</label>
                            <input type="text" class="form-control" name="rollNumber" placeholder="Enter Roll Number" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" placeholder="Enter Fullname" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" class="form-control" name="phoneNumber" placeholder="Optional">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" class="form-control" name="address" placeholder="Optional">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter your Email" required>
                        </div>
                        <div class="text-left">
                            <button type="submit" class="btn btn-primary"><i class="bi bi-person-plus"></i> Register</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Thông Báo -->
        <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="messageModalLabel">Notification</h5>
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
                let form = document.querySelector("form");

                form.onsubmit = function (event) {
                    event.preventDefault(); // Ngăn chặn form gửi dữ liệu ngay lập tức

                    let rollNumber = document.querySelector("input[name='rollNumber']").value.trim();
                    let password = document.querySelector("input[name='password']").value.trim();
                    let fullName = document.querySelector("input[name='fullName']").value.trim();
                    let email = document.querySelector("input[name='email']").value.trim();

                    let errorMessage = "";

                    // Kiểm tra RollNumber: 2 chữ cái + 6 số
                    let rollNumberPattern = /^[A-Za-z]{2}\d{6}$/;
                    if (!rollNumberPattern.test(rollNumber)) {
                        errorMessage += "❌ RollNumber must have 8 lettters, 2 first are characters and last 6 are digits.\n";
                    }

                    // Kiểm tra Password: ít nhất 8 ký tự
                    if (password.length < 8) {
                        errorMessage += "❌ Password must have at least 8 letters.\n";
                    }

                    // Kiểm tra Email: định dạng hợp lệ
                    let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailPattern.test(email)) {
                        errorMessage += "❌ Invalid email.\n";
                    }

                    // Kiểm tra Full Name: ít nhất 2 từ
                    if (fullName.split(" ").length < 2) {
                        errorMessage += "❌ Invalid fullname.\n";
                    }

                    // Nếu có lỗi, hiển thị modal thông báo
                    if (errorMessage !== "") {
                        document.getElementById("messageContent").innerText = errorMessage;
                        var modal = new bootstrap.Modal(document.getElementById('messageModal'));
                        modal.show();
                    } else {
                        form.submit(); // Nếu không có lỗi, submit form
                    }
                };

                // Xử lý thông báo từ server
                let message = "<%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%>";
                let error = "<%= request.getAttribute("error") != null ? request.getAttribute("error") : ""%>";

                if (message !== "") {
                    document.getElementById("messageContent").innerText = message;
                    var modal = new bootstrap.Modal(document.getElementById('messageModal'));
                    modal.show();
                    setTimeout(() => {
                        window.location.href = "login.jsp";
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
