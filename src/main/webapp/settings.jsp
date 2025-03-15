<%@page import="model.Users"%>
<%@page import="dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings - Library</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            /* Dark mode tổng thể */
            body {
                background-color: #ffffff;
                color: #000000;
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                overflow-y: auto;
                position: relative;
            }

            /* Nút Back mới */
            .back-arrow-btn {
                display: flex;
                align-items: center;
                background: #66ff66;
                color: #000000;
                padding: 8px 12px;
                border-radius: 20px;
                border: 1px solid rgba(255, 255, 255, 0.1);
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                position: absolute;
                top: 10px;
                left: 10px;
                z-index: 1000;
            }
            .back-arrow-btn:hover {
                background: #00FF33;
                border-color: #006600;
                box-shadow: 0 4px 10px rgba(26, 115, 232, 0.2);
                transform: translateX(-2px);
            }
            .back-arrow-btn .arrow {
                margin-right: 6px;
                font-size: 1.2rem;
            }

            /* Container chính */
            .settings-container {
                background: #FFFFE0;
                color: #000000;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
                width: 100%;
                max-width: 900px;
                display: flex;
                flex-direction: column;
                border: 1px solid rgba(255, 255, 255, 0.05);
            }

            /* Phần đầu chứa Settings và Search */
            .header-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
                width: 100%;
            }
            h1 {
                font-family: 'Roboto', sans-serif;
                font-size: 2rem;
                font-weight: 700;
                color: #000000;
                text-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
                margin: 0;
                flex-grow: 1;
                text-align: center;
            }

            /* Thanh tìm kiếm */
            .search-bar {
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 600px;
                margin-left: auto;
            }
            .search-icon {
                color: #b0b0b0;
                font-size: 1.5rem;
                margin-right: 10px;
                transition: color 0.3s ease;
            }
            .search-input {
                background: #CCE6FF;
                border: 1px solid rgba(255, 255, 255, 0.1);
                color: #252525;
                padding: 10px 15px;
                border-radius: 20px;
                font-size: 1rem;
                width: 100%;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease;
            }
            .search-input::placeholder {
                color: #808080;
                font-style: italic;
            }
            .search-input:focus {
                outline: none;
                border-color: #1a73e8;
                box-shadow: 0 0 10px rgba(26, 115, 232, 0.3);
                background: #3a3a3a;
            }

            /* Bố cục hai cột */
            .settings-content {
                display: flex;
                width: 100%;
            }
            .settings-menu {
                flex: 1;
                padding-right: 20px;
                border-right: 1px solid rgba(255, 255, 255, 0.1);
            }
            .settings-details-container {
                flex: 2;
                padding-left: 20px;
            }

            /* Danh sách menu (bên trái) */
            .settings-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .settings-item {
                background: #FFFFCC;
                padding: 15px 20px;
                margin: 10px 0;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 1.1rem;
                font-weight: 500;
                color: #252525;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.05);
                text-align: left;
            }
            .settings-item:hover {
                background: #FFFF9C;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }
            .settings-item.active {
                background: #FFFF9C;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            /* Nội dung chi tiết (bên phải) - Đồng bộ từ General Settings */
            .settings-details {
                display: none;
                margin-top: 0;
                background: #FFFFCC;
                padding: 25px; /* Tăng padding để thoáng hơn */
                border-radius: 10px;
                text-align: left;
                width: 100%;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                opacity: 0;
                transform: translateY(10px);
                transition: all 0.3s ease;
            }
            .settings-details.active {
                display: block;
                opacity: 1;
                transform: translateY(0);
            }
            .settings-details h3 {
                font-size: 1.5rem; /* Tăng kích thước chữ */
                font-weight: 700; /* Tô đậm */
                color: #1a73e8; /* Màu xanh nổi bật */
                margin-bottom: 20px; /* Tăng khoảng cách dưới */
                padding-bottom: 8px;
                border-bottom: 2px solid #1a73e8; /* Gạch chân màu xanh */
                text-transform: uppercase; /* Chữ in hoa */
                letter-spacing: 1px; /* Khoảng cách chữ */
            }
            .detail-item {
                margin: 15px 0; /* Tăng khoảng cách giữa các mục */
                padding: 10px; /* Thêm padding */
                background: #FFFFE0; /* Nền từ General Settings */
                border: 2px solid;
                border-color: #BFBFBF;
                border-radius: 8px; /* Bo góc mềm hơn */
                transition: background 0.3s ease, transform 0.2s ease;
                display: flex;
                align-items: center;
            }
            .detail-item:hover {
                background: #FFFF9C; /* Hiệu ứng hover sáng hơn */
                transform: translateX(5px); /* Dịch nhẹ sang phải khi hover */
            }
            .detail-item label {
                font-size: 1rem; /* Tăng kích thước chữ */
                font-weight: 600;
                color: #252525;
                width: 220px; /* Tăng chiều rộng để tránh tràn */
                flex-shrink: 0;
            }
            .detail-item span, .detail-item input {
                font-size: 0.95rem; /* Tăng kích thước chữ */
                padding: 8px 12px; /* Tăng padding */
                background: #FFF2CC; /* Nền sáng hơn từ General Settings */
                border: 1px solid rgba(255, 255, 255, 0.15);
                border-radius: 6px;
                color: #252525;
                width: calc(100% - 230px); /* Điều chỉnh theo label */
                transition: all 0.3s ease;
            }
            .detail-item input:focus {
                outline: none;
                border-color: #1a73e8;
                box-shadow: 0 0 8px rgba(26, 115, 232, 0.2);
            }

            /* Modal cho gia hạn - Giữ nguyên */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background: #252525;
                padding: 20px;
                border-radius: 10px;
                width: 450px;
                max-width: 90%;
                text-align: left;
                position: relative;
                overflow: hidden;
            }
            .modal-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }
            .modal-btn:hover {
                background-color: #0056b3;
            }
            .modal-content input {
                width: 100%;
                margin-bottom: 10px;
            }
            .modal-content button {
                background: #1a73e8;
                color: #fff;
                border: none;
                padding: 8px 15px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }
            .modal-content button:hover {
                background: #1557b0;
            }
            .modal-content button:disabled {
                background: #666;
                cursor: not-allowed;
            }
            .modal-content .slide-container {
                display: flex;
                width: 100%;
            }
            .modal-content .slide {
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
                display: none;
            }
            .modal-content .slide.active {
                display: block;
            }
            .modal-content .note {
                font-size: 0.9rem;
                color: #FFD700;
                margin-top: 10px;
            }
            .button-container {
                display: flex;
                justify-content: space-between;
            }
            .back-btn {
                background: #808080;
            }
            .back-btn:hover {
                background: #666666;
            }

            /* Nút Done - Đồng bộ từ General Settings */
            .done-btn {
                background: linear-gradient(135deg, #1a73e8 0%, #1557b0 100%);
                color: #ffffff;
                padding: 8px 20px;
                border: none;
                border-radius: 20px;
                font-size: 0.95rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 15px;
                display: inline-block;
            }

            .done-btn:not(:disabled):hover {
                background: linear-gradient(135deg, #1557b0 0%, #1a73e8 100%);
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(26, 115, 232, 0.4);
            }

            .done-btn:disabled {
                background: #d7dbdd;
                color: #999;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            /* Hiệu ứng nháy đỏ - Giữ nguyên */
            .highlight {
                animation: flashRed 2s ease-in-out;
            }
            @keyframes flashRed {
                0% {
                    color: #ffffff;
                }
                50% {
                    color: #ff4444;
                }
                100% {
                    color: #d0d0d0;
                }
            }
            /* Thêm hiệu ứng phóng to - Giữ nguyên */
            .zoom-effect {
                animation: zoomInOut 1s ease-in-out;
            }
            @keyframes zoomInOut {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.2);
                }
                100% {
                    transform: scale(1);
                }
            }

            /* Màu sắc cho số sách mượn - Giữ nguyên */
            .book-count.green {
                color: #28a745;
            }
            .book-count.yellow {
                color: #FFD700;
            }
            .book-count.red {
                color: #dc3545;
            }
        </style>
    </head>
    <body>
        <!-- Nút Back nằm ngoài settings-container - Giữ nguyên -->
        <button class="back-arrow-btn" onclick="history.back()">
            <span class="arrow">←</span> Back
        </button>

        <div class="settings-container">
            <!-- Phần đầu chứa Settings và Search - Giữ nguyên -->
            <div class="header-container">
                <h1>Settings</h1>
                <div class="search-bar">
                    <span class="search-icon">🔍</span>
                    <input type="text" class="search-input" placeholder="Search" id="searchInput">
                </div>
            </div>

            <!-- Bố cục hai cột -->
            <div class="settings-content">
                <!-- Menu bên trái - Giữ nguyên -->
                <div class="settings-menu">
                    <ul class="settings-list">
                        <li><div class="settings-item active" data-target="account-info">Account</div></li>
                        <li><div class="settings-item" data-target="change-password">Change Password</div></li>
                        <li><div class="settings-item" data-target="general-settings">General Settings</div></li>
                    </ul>
                </div>

                <!-- Nội dung chi tiết bên phải -->
                <div class="settings-details-container">
                    <!-- Tài khoản - Áp dụng giao diện từ General Settings -->
                    <div class="settings-details active" id="account-info">
                        <h3 class="searchable">Account Information</h3>
                        <div class="detail-item">
                            <label class="searchable">Username:</label>
                            <span class="searchable"><%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getFullname() : "N/A"%></span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Roll Number:</label>
                            <span class="searchable"><%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getRollNumber() : "N/A"%></span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Phone Number:</label>
                            <span class="searchable"><%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getPhonenumber() : "N/A"%></span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Address:</label>
                            <span class="searchable"><%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getAddress() : "N/A"%></span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Email:</label>
                            <span class="searchable"><%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getEmail() : "N/A"%></span>
                        </div>
                    </div>

                    <!-- Modal thông báo password -->
                    <div id="customModal" class="modal">
                        <div class="modal-content">
                            <h3 id="modalTitle">Notification</h3>
                            <p id="modalMessage"></p>
                            <button onclick="closeModal()" class="modal-btn">OK</button>
                        </div>
                    </div>
                    <!-- Thay đổi mật khẩu - Áp dụng giao diện từ General Settings -->
                    <div class="settings-details" id="change-password">
                        <h3 class="searchable">Change Password</h3>
                        <form id="changePasswordForm" onsubmit="return changePassword(event)">
                            <div class="detail-item">
                                <label class="searchable">Current Password:</label>
                                <input type="password" id="currentPassword" placeholder="Enter current password" class="searchable" required>
                            </div>
                            <div class="detail-item">
                                <label class="searchable">New Password:</label>
                                <input type="password" id="newPassword" placeholder="Enter new password" class="searchable" required>
                            </div>
                            <div class="detail-item">
                                <label class="searchable">Confirm New Password:</label>
                                <input type="password" id="confirmNewPassword" placeholder="Confirm new password" class="searchable" required>
                            </div>
                            <button type="submit" class="done-btn">Done</button>
                        </form>
                    </div>

                    <!-- Cài đặt chung - Giữ nguyên vì đã có giao diện chuẩn -->
                    <div class="settings-details" id="general-settings">
                        <%
                            UserDAO userDAO = new UserDAO();
                            String rollNumber = session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getRollNumber() : "";
                            java.sql.Date dueDate = userDAO.getLatestDueDate(rollNumber);
                            String dueDaysDisplay;
                            int dueDays = 0;
                            boolean isOverdue = false;
                            if (dueDate != null) {
                                java.time.LocalDate dueLocalDate = dueDate.toLocalDate();
                                java.time.LocalDate today = java.time.LocalDate.now(java.time.ZoneId.systemDefault());
                                dueDays = (int) java.time.temporal.ChronoUnit.DAYS.between(today, dueLocalDate);
                                isOverdue = dueDays < 0;
                                dueDays = Math.max(0, dueDays);
                                dueDaysDisplay = dueDays + " ngày" + (isOverdue ? " (Đã trễ hạn)" : "");
                                System.out.println("DueDate: " + dueDate + ", DueDays: " + dueDays + ", IsOverdue: " + isOverdue);
                            } else {
                                dueDaysDisplay = "Chưa mượn sách";
                                System.out.println("No DueDate found for rollNumber " + rollNumber + ", no active transactions");
                            }
                            int lateDays = userDAO.getLateDays(rollNumber);
                            int bookCount = userDAO.getBookCount(rollNumber);
                            int maxBooksAllowed = userDAO.getMaxBooksAllowed();
                            int lateFeePerDay = userDAO.getLateFeePerDay();
                            String notificationInterval = userDAO.getNotificationInterval(rollNumber);
                        %>
                        <h3 class="searchable">Borrow Status</h3>
                        <div class="detail-item">
                            <label class="searchable">Days Left:</label>
                            <span class="searchable" id="defaultLoanDays"><%= dueDaysDisplay%></span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Extend Days:</label>
                            <button onclick="showExtendModal()" class="done-btn searchable" <%= (dueDate == null || isOverdue) ? "disabled" : ""%>>Gia hạn</button>
                        </div>

                        <h3 class="searchable">Phí phạt trễ hạn</h3>
                        <div class="detail-item">
                            <label class="searchable">Số ngày bạn nộp trễ là:</label>
                            <span class="searchable"><%= lateDays%> ngày</span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Số tiền bạn cần thanh toán là:</label>
                            <span class="searchable"><%= (lateDays > 0 && lateFeePerDay > 0) ? (lateDays * lateFeePerDay) + " VNĐ" : "0 VNĐ"%></span>
                        </div>

                        <h3 class="searchable">Giới hạn số lượng sách mượn</h3>
                        <div class="detail-item">
                            <label class="searchable">Số sách bạn đang mượn:</label>
                            <span class="book-count searchable <%= bookCount < 5 ? "green" : bookCount <= 8 ? "yellow" : "red"%>"><%= bookCount%> quyển</span>
                        </div>
                        <div class="detail-item">
                            <label class="searchable">Số sách còn lại bạn có thể mượn:</label>
                            <span class="searchable"><%= maxBooksAllowed - bookCount%> quyển</span>
                        </div>

                        <h3 class="searchable">Thời gian nhắc nhở trả sách</h3>
                        <div class="detail-item">
                            <label class="searchable">Thông báo với tôi:</label>
                            <select id="notificationInterval" onchange="updateNotification()">
                                <option value="12" <%= "12".equals(notificationInterval) ? "selected" : ""%>>12h/lần</option>
                                <option value="24" <%= "24".equals(notificationInterval) ? "selected" : ""%>>24h/lần</option>
                                <option value="48" <%= "48".equals(notificationInterval) ? "selected" : ""%>>48h/lần</option>
                                <option value="72" <%= "72".equals(notificationInterval) ? "selected" : ""%>>72h/lần</option>
                                <option value="0" <%= "0".equals(notificationInterval) ? "selected" : ""%>>Không cần thông báo</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal cho gia hạn - Giữ nguyên -->
            <div id="extendModal" class="modal">
                <div class="modal-content">
                    <div class="slide-container">
                        <!-- Slide 1: Nhập số ngày gia hạn -->
                        <div class="slide active" id="extendSlide1">
                            <h4>Extend days</h4>
                            <div class="detail-item">
                                <label>Number of days:</label>
                                <input type="number" id="extendDays" placeholder="Enter days (10.000 VNĐ/day)" min="1" oninput="checkDaysInput()">
                            </div>
                            <div class="button-container">
                                <button class="back-btn" onclick="closeModal()">Back</button>
                                <button id="nextBtn" onclick="showPaymentDetails()" disabled>Next</button>
                            </div>
                        </div>

                        <!-- Slide 2: Thông tin thanh toán -->
                        <div class="slide" id="extendSlide2">
                            <h4>Thông tin thanh toán</h4>
                            <div class="detail-item">
                                <label>Số tiền bạn cần phải trả là:</label>
                                <span id="paymentAmount"></span>
                            </div>
                            <div class="detail-item">
                                <label>Bank:</label>
                                <span>Vietcombank</span>
                            </div>
                            <div class="detail-item">
                                <label>Account number:</label>
                                <span>1013679489</span>
                            </div>
                            <div class="detail-item">
                                <label>Name:</label>
                                <span>Hong Tuan Nguyen</span>
                            </div>
                            <p class="note">Vui lòng chụp màn hình lại khi thực hiện giao dịch thành công</p>
                            <div class="button-container">
                                <button class="back-btn" onclick="goBack()">Back</button>
                                <button id="finishBtn" onclick="finishPayment()">Finish</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    // Đảm bảo mã chạy sau khi DOM được tải hoàn toàn - Giữ nguyên
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const settingsItems = document.querySelectorAll('.settings-item');
                                        if (settingsItems.length === 0) {
                                            console.error("Không tìm thấy phần tử .settings-item nào!");
                                            return;
                                        }

                                        settingsItems.forEach(item => {
                                            item.addEventListener('click', function () {
                                                const targetId = this.getAttribute('data-target');
                                                const targetDetail = document.getElementById(targetId);

                                                if (!targetDetail) {
                                                    console.error("Không tìm thấy phần tử với id: " + targetId);
                                                    return;
                                                }

                                                document.querySelectorAll('.settings-details').forEach(detail => {
                                                    detail.classList.remove('active');
                                                });
                                                document.querySelectorAll('.settings-item').forEach(i => {
                                                    i.classList.remove('active');
                                                });

                                                this.classList.add('active');
                                                targetDetail.classList.add('active');

                                                console.log("Đã chuyển sang mục: " + targetId);
                                            });
                                        });
                                    });

                                    // Search functionality - Giữ nguyên
                                    const searchInput = document.getElementById('searchInput');

                                    function applyZoomEffect(element) {
                                        element.classList.add('zoom-effect');
                                        setTimeout(() => {
                                            element.classList.remove('zoom-effect');
                                        }, 1000);
                                    }

                                    function handleSearch() {
                                        const searchTerm = searchInput.value.trim().toLowerCase();
                                        let found = false;

                                        document.querySelectorAll('.searchable').forEach(element => {
                                            element.style.transform = 'scale(1)';
                                            element.classList.remove('zoom-effect');
                                        });

                                        if (!searchTerm) {
                                            const accountItem = document.querySelector('.settings-item[data-target="account-info"]');
                                            const accountDetail = document.getElementById('account-info');
                                            document.querySelectorAll('.settings-item').forEach(item => item.classList.remove('active'));
                                            document.querySelectorAll('.settings-details').forEach(detail => detail.classList.remove('active'));
                                            accountItem.classList.add('active');
                                            accountDetail.classList.add('active');
                                            return;
                                        }

                                        document.querySelectorAll('.searchable').forEach(element => {
                                            const text = element.textContent.toLowerCase();
                                            if (text.includes(searchTerm)) {
                                                found = true;
                                                const parentDetail = element.closest('.settings-details');
                                                const targetId = parentDetail.id;
                                                const settingsItem = document.querySelector(`.settings-item[data-target="${targetId}"]`);

                                                document.querySelectorAll('.settings-details').forEach(detail => detail.classList.remove('active'));
                                                document.querySelectorAll('.settings-item').forEach(item => item.classList.remove('active'));
                                                parentDetail.classList.add('active');
                                                settingsItem.classList.add('active');

                                                applyZoomEffect(element);
                                            }
                                        });

                                        if (!found) {
                                            alert("No Find");
                                        }
                                    }

                                    // Change password functionality - Giữ nguyên
                                    function changePassword(event) {
                                        event.preventDefault();

                                        const currentPassword = document.getElementById('currentPassword').value;
                                        const newPassword = document.getElementById('newPassword').value;
                                        const confirmNewPassword = document.getElementById('confirmNewPassword').value;

                                        if (newPassword !== confirmNewPassword) {
                                            alert("Mật khẩu mới không trùng nhau");
                                            return false;
                                        }

                                        fetch('/Assignment/Setting', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/x-www-form-urlencoded',
                                            },
                                            body: new URLSearchParams({
                                                'rollNumber': '<%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getRollNumber() : ""%>',
                                                'currentPassword': currentPassword,
                                                'newPassword': newPassword,
                                                'action': 'changePassword'
                                            })
                                        })
                                                .then(response => response.text())
                                                .then(data => {
                                                    if (data === "success") {
                                                        alert("Bạn đã đổi mật khẩu thành công");
                                                        document.getElementById('changePasswordForm').reset();
                                                    } else if (data === "wrongCurrentPassword") {
                                                        alert("Nhập sai mật khẩu hiện tại");
                                                    } else {
                                                        alert("Lỗi khi đổi mật khẩu. Vui lòng thử lại.");
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    alert("Lỗi khi đổi mật khẩu. Vui lòng thử lại.");
                                                });

                                        return false;
                                    }

                                    // Modal và gia hạn functionality - Giữ nguyên
                                    const extendModal = document.getElementById('extendModal');
                                    const slide1 = document.getElementById('extendSlide1');
                                    const slide2 = document.getElementById('extendSlide2');
                                    const nextBtn = document.getElementById('nextBtn');
                                    const finishBtn = document.getElementById('finishBtn');

                                    function showExtendModal() {
                                        extendModal.style.display = 'flex';
                                        slide1.classList.add('active');
                                        slide2.classList.remove('active');
                                        document.getElementById('extendDays').value = '';
                                        nextBtn.disabled = true;
                                        finishBtn.disabled = true;
                                    }

                                    function closeModal() {
                                        extendModal.style.display = 'none';
                                    }

                                    function checkDaysInput() {
                                        const days = document.getElementById('extendDays').value;
                                        nextBtn.disabled = !days || days <= 0;
                                    }

                                    function showPaymentDetails() {
                                        const days = parseInt(document.getElementById('extendDays').value, 10);
                                        const fee = days * 10000;
                                        document.getElementById('paymentAmount').textContent = fee.toLocaleString('vi-VN') + " VNĐ";
                                        slide1.classList.remove('active');
                                        slide2.classList.add('active');
                                        finishBtn.disabled = false;
                                    }

                                    function goBack() {
                                        slide2.classList.remove('active');
                                        slide1.classList.add('active');
                                        finishBtn.disabled = true;
                                    }

                                    function finishPayment() {
                                        const days = parseInt(document.getElementById('extendDays').value, 10);
                                        const rollNumber = '<%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getRollNumber() : ""%>';

                                        if (isNaN(days) || days <= 0) {
                                            alert("Please enter a valid number of days.");
                                            return;
                                        }

                                        fetch('ExtendLoanServlet', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/x-www-form-urlencoded'
                                            },
                                            body: new URLSearchParams({
                                                'rollNumber': rollNumber,
                                                'extendDays': days
                                            })
                                        })
                                                .then(response => response.text())
                                                .then(data => {
                                                    console.log("Response from ExtendLoanServlet:", data);
                                                    if (data === "success") {
                                                        fetch('Setting', {
                                                            method: 'POST',
                                                            headers: {
                                                                'Content-Type': 'application/x-www-form-urlencoded'
                                                            },
                                                            body: new URLSearchParams({
                                                                'rollNumber': rollNumber,
                                                                'action': 'getDueDate'
                                                            })
                                                        })
                                                                .then(response => response.text())
                                                                .then(dueDays => {
                                                                    console.log("Due days from server:", dueDays);
                                                                    const defaultLoanDaysElement = document.getElementById('defaultLoanDays');
                                                                    const extendButton = document.querySelector('.done-btn[onclick="showExtendModal()"]');
                                                                    console.log("Default loan days before update:", defaultLoanDaysElement.textContent);

                                                                    const parsedDueDays = parseInt(dueDays, 10);
                                                                    if (!isNaN(parsedDueDays)) {
                                                                        const isOverdue = parsedDueDays < 0;
                                                                        defaultLoanDaysElement.textContent = (isOverdue ? 0 : parsedDueDays) + " ngày" + (isOverdue ? " (Đã trễ hạn)" : "");
                                                                        extendButton.disabled = isOverdue;
                                                                    } else {
                                                                        defaultLoanDaysElement.textContent = "Chưa mượn sách";
                                                                        extendButton.disabled = true;
                                                                    }

                                                                    console.log("Default loan days after update:", defaultLoanDaysElement.textContent);
                                                                    alert("Extension successful! Please take a screenshot as proof.");
                                                                    closeModal();
                                                                })
                                                                .catch(error => {
                                                                    console.error('Error fetching due date:', error);
                                                                    alert("Error updating due date. Please try again.");
                                                                });
                                                    } else {
                                                        alert("Error extending loan. Please try again. Error code: " + data);
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    alert("Error extending loan. Please try again. Details: " + error.message);
                                                    closeModal();
                                                });
                                    }

                                    // Update notification interval - Giữ nguyên
                                    function updateNotification() {
                                        const interval = document.getElementById('notificationInterval').value;
                                        const rollNumber = '<%= session.getAttribute("user") != null ? ((Users) session.getAttribute("user")).getRollNumber() : ""%>';
                                        fetch('UpdateNotificationServlet', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/x-www-form-urlencoded',
                                            },
                                            body: new URLSearchParams({
                                                'rollNumber': rollNumber,
                                                'interval': interval
                                            })
                                        })
                                                .then(response => response.text())
                                                .then(data => {
                                                    if (data === "success") {
                                                        alert("Cập nhật thời gian nhắc nhở thành công");
                                                    } else {
                                                        alert("Cập nhật thời gian nhắc nhở thành công");
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    alert("Cập nhật thời gian nhắc nhở thành công");
                                                });
                                    }

                                    // Trigger search on Enter key or input change - Giữ nguyên
                                    searchInput.addEventListener('keydown', function (event) {
                                        if (event.key === 'Enter') {
                                            handleSearch();
                                        }
                                    });

                                    searchInput.addEventListener('input', function () {
                                        if (!this.value.trim()) {
                                            handleSearch();
                                        }
                                    });
        </script>
    </body>
</html>