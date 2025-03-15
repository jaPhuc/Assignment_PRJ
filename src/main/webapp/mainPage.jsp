<%@page import="model.Users"%>
<%@page import="java.sql.*, java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Main Page - Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background-color: #ffffff;
            color: #000000;
            padding-top: 130px;
            margin: 0;
            position: relative;
            font-family: 'Roboto', sans-serif;
        }

        .navbar {
            background-color: #ffffff;
            padding: 20px 20px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
        }

        .fpt-logo {
            display: flex;
            align-items: center;
            font-family: 'Dancing Script', cursive;
            font-weight: 700;
            font-size: 2.2rem;
        }
        .fpt-letter {
            padding: 4px 8px;
            border-radius: 5px;
            margin: 0 2px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
            font-weight: 900;
        }
        .fpt-f {
            color: #0066cc;
            background-color: transparent;
        }
        .fpt-p {
            color: #ff6200;
            background-color: transparent;
        }
        .fpt-t {
            color: #28a745;
            background-color: transparent;
        }
        .library-text {
            color: #000000;
            margin-left: 5px;
            font-family: 'Dancing Script', cursive;
        }

        .navbar-nav {
            flex-grow: 1;
            justify-content: center;
            position: relative;
        }
        .nav-link {
            color: #000000 !important;
            font-size: 1.1rem;
            margin: 0 20px;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
            text-decoration: none;
        }
        .nav-link:hover {
            color: #0066cc !important;
        }
        .nav-link.active {
            color: #0066cc !important;
        }
        .underline {
            position: absolute;
            bottom: -5px;
            height: 2px;
            background-color: #0066cc;
            transition: all 0.3s ease;
        }
        .nav-link.genre {
            display: flex;
            align-items: center;
            position: relative;
        }
        .nav-link.genre i.fas {
            margin-left: 0.2cm;
        }
        .nav-item {
            position: relative;
        }
        .nav-item .dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 5px 0;
            min-width: 100px;
            z-index: 1000;
        }
        .nav-item:hover .dropdown {
            display: block;
        }
        .dropdown-item {
            color: #000000;
            padding: 5px 15px;
            text-decoration: none;
            display: block;
            font-size: 1rem;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dropdown-item:hover {
            background-color: #f0f0f0;
            color: #0066cc;
        }

        .search-container {
            display: flex;
            align-items: center;
            margin: 0 15px;
            position: relative;
        }
        .search-icon {
            color: #000000;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            margin-right: 10px;
        }
        .search-icon:hover::after {
            content: "Search";
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            background-color: #e0e0e0;
            color: #000000;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 0.9rem;
            white-space: nowrap;
            z-index: 1000;
        }
        .search-icon i {
            color: #000000;
        }
        .search-form {
            display: flex;
            align-items: center;
            opacity: 0;
            width: 0;
            transition: opacity 0.3s ease, width 0.3s ease;
            z-index: 2;
        }
        .search-container:hover .search-icon {
            opacity: 0;
        }
        .search-container:hover .search-form {
            opacity: 1;
            width: 150px;
        }
        .search-input {
            background-color: #f0f0f0;
            border: 1px solid #d0d0d0;
            color: #000000;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
        }
        .search-input::placeholder {
            color: #6B7280;
        }
        .search-input:focus {
            outline: none;
            border-color: #0066cc;
            box-shadow: 0 0 5px rgba(0, 102, 204, 0.5);
        }

        .login-btn {
            color: #0066cc !important;
            font-weight: 500;
            padding: 5px 15px;
            border-radius: 20px;
            text-decoration: none;
            margin-left: 10px;
            transition: color 0.3s ease;
            border: none;
            background: none;
        }
        .login-btn:hover {
            color: #005bb5 !important;
        }
        .signup-btn {
            background-color: #0066cc;
            color: #ffffff !important;
            font-weight: 500;
            padding: 5px 15px;
            border-radius: 20px;
            text-decoration: none;
            margin-left: 10px;
            transition: background-color 0.3s ease;
            border: none;
        }
        .signup-btn:hover {
            background-color: #005bb5;
            color: #ffffff !important;
        }

        .user-container {
            display: flex;
            align-items: center;
            position: relative;
            margin-left: 10px;
            margin-right: 20px;
        }
        .user-icon {
            width: 28px;
            height: 28px;
            background-color: #000000;
            border-radius: 50%;
            position: relative;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 8px;
        }
        .user-icon::before {
            content: '';
            width: 10px;
            height: 10px;
            background-color: #ffffff;
            border-radius: 50%;
            position: absolute;
            top: 5px;
        }
        .user-icon::after {
            content: '';
            width: 14px;
            height: 14px;
            background-color: #ffffff;
            position: absolute;
            bottom: 3px;
            clip-path: polygon(50% 0%, 100% 100%, 0% 100%);
        }
        .user-icon:hover {
            transform: scale(1.2);
            background-color: #0066cc;
        }
        .user-greeting {
            color: #000000;
            font-weight: 500;
            font-size: 1.1rem;
            cursor: pointer;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .user-greeting:hover {
            color: #0066cc !important;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 5px 0;
            min-width: 150px;
            z-index: 2000;
        }
        .user-container:hover .dropdown-menu {
            display: block;
        }
        .dropdown-item {
            color: #000000;
            padding: 5px 15px;
            text-decoration: none;
            display: block;
            font-size: 1rem;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dropdown-item:hover {
            background-color: #f0f0f0;
            color: #0066cc;
        }
        .dropdown-item.logout {
            display: flex;
            align-items: center;
        }
        .dropdown-item.logout i {
            margin-right: 5px;
            transition: color 0.3s ease;
        }
        .dropdown-item.logout:hover i {
            color: #ff0000;
        }
        .dropdown-item.logout:hover {
            color: #ff0000;
            background-color: #f0f0f0;
        }

        .container {
            background-color: #ffffff;
            padding: 40px 20px;
            border-radius: 0;
            box-shadow: none;
            margin-top: 20px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
            gap: 40px;
        }
        .container .content {
            max-width: 45%;
        }
        .container h1 {
            color: #000000;
            font-size: 3rem;
            font-weight: 700;
            margin: 0 0 10px 0;
            letter-spacing: 1px;
            font-family: 'Roboto', sans-serif;
        }
        .container p {
            color: #6B7280;
            font-size: 1rem;
            margin: 0 0 20px 0;
            line-height: 1.5;
        }

        .btn-custom {
            background-color: #0066cc;
            color: #ffffff;
            border: none;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 10px;
        }
        .btn-custom:hover {
            background-color: #005bb5;
        }

        .btn-join {
            background-color: #0066cc;
            color: #ffffff;
            border: none;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            text-transform: uppercase;
        }
        .btn-join:hover {
            background-color: #005bb5;
        }

        .book-image {
            max-width: 400px;
            height: auto;
            border-radius: 10px;
        }

        .feature-section {
            text-align: center;
            margin-top: 40px;
        }
        .feature-section h3 {
            font-size: 2rem;
            color: #000000;
            font-weight: 700;
            margin-bottom: 30px;
        }
        .feature-items {
            display: flex;
            justify-content: center;
            gap: 40px;
        }
        .feature-item {
            text-align: center;
            max-width: 300px;
        }
        .feature-icon {
            color: #000000;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .feature-item p {
            color: #6B7280;
            font-size: 1rem;
            line-height: 1.5;
        }

        .book-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .book-table th, .book-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        .book-table th {
            background-color: #f0f0f0;
            color: #000000;
            font-weight: 700;
        }
        .book-table td {
            color: #000000;
        }
        .book-table tr:hover {
            background-color: #f0f0f0;
        }

        #faqSection {
            margin-top: 50px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 0;
            box-shadow: none;
        }
        .faq-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        .faq-title {
            text-align: center;
            font-size: 2rem;
            color: #000000;
            font-weight: bold;
        }
        .faq-subtitle {
            text-align: center;
            color: #6B7280;
            margin-bottom: 30px;
        }
        .faq-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        .faq-item {
            background: #f0f0f0;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }
        .faq-question {
            font-weight: bold;
            margin-bottom: 5px;
            color: #000000;
        }
        .faq-answer {
            color: #6B7280;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1500;
        }
        .overlay.active {
            display: block;
        }

        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.6);
            width: 400px;
            z-index: 2000;
            font-family: 'Roboto', sans-serif;
            text-align: center;
        }
        .popup.active {
            display: block;
        }
        .popup h4 {
            color: #000000;
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-align: center;
        }
        .popup ul {
            list-style: none;
            padding: 0;
            margin: 0 0 15px 0;
        }
        .popup li {
            margin-bottom: 8px;
        }
        .popup a {
            color: #0066cc;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .popup a:hover {
            color: #005bb5;
        }
        .popup p {
            color: #6B7280;
            font-size: 0.85rem;
            margin: 4px 0;
        }
        .popup .popup-back-btn {
            background-color: #d1d5db;
            color: #000000;
            border: none;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: inline-block;
        }
        .popup .popup-back-btn:hover {
            background-color: #9ca3af;
        }

        .feedback-popup textarea {
            width: 100%;
            height: 150px;
            background-color: #f0f0f0;
            border: 1px solid #d0d0d0;
            color: #000000;
            padding: 12px;
            border-radius: 6px;
            font-size: 1rem;
            resize: none;
            margin-bottom: 20px;
        }
        .feedback-popup textarea:focus {
            outline: none;
            border-color: #0066cc;
            box-shadow: 0 0 5px rgba(0, 102, 204, 0.5);
        }
        .feedback-popup .send-btn {
            background-color: #0066cc;
            color: #ffffff;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .feedback-popup .send-btn:hover {
            background-color: #005bb5;
        }
        .feedback-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer {
            background-color: #f8f9fa;
            padding: 40px 20px;
            color: #000000;
            border-top: 3px solid #28a745;
            margin-top: 50px;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
        }
        .footer h5 {
            font-size: 1.3rem;
            font-weight: 700;
            color: #28a745;
            margin-bottom: 15px;
            position: relative;
            font-family: 'Dancing Script', cursive;
            white-space: nowrap;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        .footer h5.subscribe-title {
            font-size: 1.1rem;
        }
        .footer h5::before {
            content: '';
            position: absolute;
            left: 0;
            top: -5px;
            width: 40px;
            height: 2px;
            background-color: #0066cc;
        }
        .footer p {
            color: #6B7280;
            font-size: 1rem;
            margin: 8px 0;
            transition: color 0.3s ease;
        }
        .footer .footer-logo {
            font-family: 'Dancing Script', cursive;
            font-size: 2rem;
            color: #28a745;
            margin-bottom: 15px;
            font-weight: 700;
        }
        .footer .subscribe-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .footer .subscribe-form input {
            background-color: #ffffff;
            border: 1px solid #28a745;
            color: #000000;
            padding: 8px;
            border-radius: 20px;
            width: 70%;
            font-size: 0.95rem;
            transition: border-color 0.3s ease;
        }
        .footer .subscribe-form input::placeholder {
            color: #6B7280;
        }
        .footer .subscribe-form input:focus {
            border-color: #0066cc;
            outline: none;
        }
        .footer .subscribe-form button {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .footer .subscribe-form button:hover {
            background-color: #218838;
        }
        .footer .contact-info p {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .footer .contact-info p i {
            color: #0066cc;
            font-size: 1.2rem;
        }
        .footer .contact-info p strong {
            color: #28a745;
            font-weight: 600;
        }
        .footer .contact-info p:hover {
            color: #0066cc;
        }

        .illustration {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            width: 200px;
            height: auto;
            opacity: 0.7;
            pointer-events: none;
        }
        @media (max-width: 768px) {
            .illustration {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg navbar-dark">
            <a class="navbar-brand" href="mainPage">
                <span class="fpt-logo">
                    <span class="fpt-letter fpt-f">F</span>
                    <span class="fpt-letter fpt-p">P</span>
                    <span class="fpt-letter fpt-t">T</span>
                    <span class="library-text">Library</span>
                </span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#introduction">Introduction</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#list">My Books</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link genre" href="#">Genre <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown">
                            <a href="#" class="dropdown-item">Action</a>
                            <a href="#" class="dropdown-item">Comedy</a>
                            <a href="#" class="dropdown-item">Fantasy</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#faqSection">FAQs</a>
                    </li>
                </ul>
                <div class="search-container">
                    <span class="search-icon"><i class="fas fa-search" style="color: #000000;"></i></span>
                    <form class="search-form" action="mainPage" method="get">
                        <input type="text" class="search-input" placeholder="Search" name="query">
                    </form>
                </div>
            </div>

            <div class="ms-auto">
                <%
                    if (session != null && session.getAttribute("user") != null) {
                        Users user = (Users) session.getAttribute("user");
                        String fullName = user.getFullname() != null ? user.getFullname() : user.getRollNumber();
                        String[] nameParts = fullName.split("\\s+");
                        String lastName = nameParts[nameParts.length - 1];
                %>
                <div class="user-container">
                    <span class="user-icon"></span>
                    <a class="user-greeting">Hi, <%= lastName%></a>
                    <div class="dropdown-menu">
                        <a href="settings.jsp" class="dropdown-item">Settings</a>
                        <a href="#" class="dropdown-item" onclick="showHelpPopup()">Help</a>
                        <a href="#" class="dropdown-item" onclick="showFeedbackPopup()">Feedback</a>
                        <a href="Logout" class="dropdown-item logout"><i class="fas fa-sign-out-alt"></i> Log out</a>
                    </div>
                </div>
                <%
                    } else {
                %>
                <a class="login-btn" href="Login">Log in</a>
                <a class="signup-btn" href="Register">Sign up</a>
                <%
                    }
                %>
            </div>
        </nav>

        <div class="container" id="introduction">
            <div class="content">
                <button class="btn-custom">We provide</button>
                <h1>Your community's knowledge information is ready</h1>
                <p>FPT Library is the largest online book library in Vietnam with millions of e-books in every field</p>
                <a href="Register" class="btn-join">JOIN</a>
            </div>
            <img src="https://cdn.cmsfly.com/67d30eecb99cf4001f539e60/images/photo1585521549926ca6526bda09e-Rkp7h.jpeg" alt="Book Stack" class="book-image">
        </div>

        <div class="feature-section" id="introduction">
            <h3>The library offers the following features:</h3>
            <div class="feature-items">
                <div class="feature-item">
                    <i class="fas fa-book feature-icon" style="color: #000000;"></i>
                    <h5 class="fw-bold">Efficient Book Management</h5>
                    <p>Streamline your book collection with advanced tools for easy categorization, tracking, and updates.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-clock feature-icon" style="color: #000000;"></i>
                    <h5 class="fw-bold">Save Time, Better Book Control</h5>
                    <p>Automate repetitive tasks and gain full control over your inventory with real-time updates.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-user-check feature-icon" style="color: #000000;"></i>
                    <h5 class="fw-bold">Enhanced User Experience</h5>
                    <p>Enjoy a seamless, intuitive interface designed for quick access and smooth navigation.</p>
                </div>
            </div>
        </div>

        <div class="container" id="introduction">
            <h3 class="text-center mb-4" id="list">Book List</h3>
            <table class="book-table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Publisher</th>
                        <th>Genres</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        dao.BookDAO bookDAO = new dao.BookDAO();
                        String query = request.getParameter("query");
                        try {
                            List<model.Books> bookList;
                            if (query != null && !query.trim().isEmpty()) {
                                bookList = bookDAO.searchBooksByTitle(query);
                            } else {
                                bookList = bookDAO.getAllBooks();
                            }
                            if (bookList != null && !bookList.isEmpty()) {
                                for (model.Books book : bookList) {
                    %>
                    <tr>
                        <td><%= book.getTitle()%></td>
                        <td><%= book.getAuthor()%></td>
                        <td><%= book.getPublisher() != null ? book.getPublisher() : "Unknown"%></td>
                        <td><%= book.getGenres() != null ? book.getGenres() : "No genres"%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4" class="text-center">No books available.</td></tr>
                    <%
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='4'>Error loading book list: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div id="faqSection" class="container-sm">
            <div class="faq-container">
                <h2 class="faq-title">FAQs - Frequently Asked Questions</h2>
                <p class="faq-subtitle">If you can't find an answer, please contact us for support.</p>
                <div class="faq-list">
                    <div class="faq-item">
                        <p class="faq-question">How to borrow a book?</p>
                        <p class="faq-answer">You need to log in to the system, select a book, and click the "Borrow book" button.</p>
                    </div>
                    <div class="faq-item">
                        <p class="faq-question">How long can I borrow a book?</p>
                        <p class="faq-answer">You can borrow a book for a maximum of 14 days. You can renew it if you want to borrow longer.</p>
                    </div>
                    <div class="faq-item">
                        <p class="faq-question">How to renew a book?</p>
                        <p class="faq-answer">Go to the "My Books" section, select the book to renew, and click the "Renew" button.</p>
                    </div>
                    <div class="faq-item">
                        <p class="faq-question">Is there a fee for borrowing books?</p>
                        <p class="faq-answer">Borrowing books is completely free, but you may be fined if you return a book late.</p>
                    </div>
                    <div class="faq-item">
                        <p class="faq-question">What should I do if I lose a book?</p>
                        <p class="faq-answer">You need to contact the library to learn about the compensation or replacement process.</p>
                    </div>
                    <div class="faq-item">
                        <p class="faq-question">How to find a book quickly?</p>
                        <p class="faq-answer">Use the search bar on the homepage and enter keywords related to the book you need.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="overlay" id="overlay"></div>

        <div class="popup" id="helpPopup">
            <ul>
                <li><a href="#faqSection" onclick="closeHelpPopup(); scrollToFAQs();">FAQs</a></li>
                <li>
                    <strong style="color: #000000;">Contact Support:</strong>
                    <p><span style="color: #1E90FF; font-weight: 600;">Email:</span> hongtuannguyencm@gmail.com</p>
                    <p><span style="color: #FF6200; font-weight: 600;">Phone Number:</span> 0818578616</p>
                    <p><span style="color: #28A745; font-weight: 600;">Messenger:</span> FPTLibrary.the</p>
                </li>
            </ul>
            <button class="popup-back-btn" onclick="closeHelpPopup()">Back</button>
        </div>

        <div class="popup feedback-popup" id="feedbackPopup">
            <h4>Feedback</h4>
            <textarea placeholder="Enter your feedback..." id="feedbackInput"></textarea>
            <div class="feedback-buttons">
                <button class="popup-back-btn" onclick="closeFeedbackPopup()">Back</button>
                <button class="send-btn" onclick="sendFeedback()">Send</button>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5 class="footer-logo">FPT Library</h5>
                        <p>We want to bring customers an exciting experience with great books from publishers worldwide with zero cost.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>CONTACT</h5>
                        <div class="contact-info">
                            <p><i class="fas fa-map-marker-alt"></i> <strong>Address:</strong> An Binh, Ninh Kieu, Can Tho</p>
                            <p><i class="fab fa-facebook-messenger"></i> <strong>Messenger:</strong> FPTLibrary.the</p>
                            <p><i class="fas fa-envelope"></i> <strong>Email:</strong> hongtuannguyencm@gmail.com</p>
                            <p><i class="fas fa-phone-alt"></i> <strong>Phone:</strong> 0818578616</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <h5 class="subscribe-title">SUBSCRIBE FOR OFFERS</h5>
                        <form class="subscribe-form" id="subscribeForm" onsubmit="handleSubscribe(event)">
                            <input type="email" id="subscribeEmail" placeholder="Your email" required>
                            <button type="submit">Subscribe</button>
                        </form>
                        <p style="font-size: 0.9rem; margin-top: 10px;">Subscribe to receive the latest offers</p>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const navLinks = document.querySelectorAll('.nav-link');
                                const navbarNav = document.querySelector('.navbar-nav');
                                const underline = document.createElement('div');
                                underline.classList.add('underline');
                                navbarNav.appendChild(underline);

                                let activeLink = navLinks[0];
                                activeLink.classList.add('active');
                                updateUnderline();

                                navLinks.forEach(link => {
                                    link.addEventListener('click', function (e) {
                                        e.preventDefault();

                                        if (activeLink !== this) {
                                            activeLink.classList.remove('active');
                                            activeLink.style.color = '#000000';
                                            this.classList.add('active');
                                            this.style.color = '#0066cc';
                                            activeLink = this;
                                            updateUnderline();
                                        }

                                        const targetId = this.getAttribute('href').substring(1);
                                        const targetElement = document.getElementById(targetId);
                                        const navbarHeight = document.querySelector('.navbar').offsetHeight;
                                        const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - navbarHeight;

                                        window.scrollTo({
                                            top: targetPosition,
                                            behavior: 'smooth'
                                        });
                                    });
                                });

                                function updateUnderline() {
                                    const rect = activeLink.getBoundingClientRect();
                                    const navRect = navbarNav.getBoundingClientRect();
                                    underline.style.width = rect.width + 'px';
                                    underline.style.left = (rect.left - navRect.left) + 'px';
                                }

                                window.addEventListener('resize', updateUnderline);
                            });

                            function showOverlay() {
                                document.getElementById('overlay').classList.add('active');
                            }
                            function hideOverlay() {
                                document.getElementById('overlay').classList.remove('active');
                            }

                            function showHelpPopup() {
                                document.getElementById('helpPopup').classList.add('active');
                                showOverlay();
                            }
                            function closeHelpPopup() {
                                document.getElementById('helpPopup').classList.remove('active');
                                hideOverlay();
                            }
                            function scrollToFAQs() {
                                const faqSection = document.getElementById('faqSection');
                                const navbarHeight = document.querySelector('.navbar').offsetHeight;
                                const targetPosition = faqSection.getBoundingClientRect().top + window.pageYOffset - navbarHeight;

                                window.scrollTo({
                                    top: targetPosition,
                                    behavior: 'smooth'
                                });
                            }

                            function showFeedbackPopup() {
                                document.getElementById('feedbackPopup').classList.add('active');
                                showOverlay();
                            }
                            function closeFeedbackPopup() {
                                document.getElementById('feedbackPopup').classList.remove('active');
                                hideOverlay();
                            }
                            function sendFeedback() {
                                const feedback = document.getElementById('feedbackInput').value.trim();
                                if (feedback) {
                                    alert("Feedback has been sent, thank you for your contribution!");
                                    closeFeedbackPopup();
                                } else {
                                    alert("Please enter feedback before sending!");
                                }
                            }

                            function handleSubscribe(event) {
                                event.preventDefault();
                                const email = document.getElementById('subscribeEmail').value.trim();
                                if (email) {
                                    alert("We will notify you of offers at the earliest time. Thank you for your interest in our service!");
                                    document.getElementById('subscribeEmail').value = '';
                                }
                            }

                            document.querySelectorAll('.footer-links a').forEach(anchor => {
                                anchor.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    const targetId = this.getAttribute('href').substring(1);
                                    const targetElement = document.getElementById(targetId);
                                    const navbarHeight = document.querySelector('.navbar').offsetHeight;
                                    const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - navbarHeight;

                                    window.scrollTo({
                                        top: targetPosition,
                                        behavior: 'smooth'
                                    });
                                });
                            });
    </script>
</body>
</html>