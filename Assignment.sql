CREATE DATABASE LibraryManagement3;
USE LibraryManagement3;

-- Tạo bảng Genres
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY(1,1),
    GenreName VARCHAR(100) NOT NULL
);

-- Tạo bảng Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Publisher VARCHAR(255),
    GenreID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);
INSERT INTO Books (Title, Author, Publisher, GenreID) 
VALUES ('Book 1', 'Author 1', 'Publisher 1', NULL);

-- Tạo bảng Roles
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(0,1),
    RoleName VARCHAR(50) UNIQUE NOT NULL
);
INSERT INTO Roles (RoleName) VALUES ('admin'), ('user');

-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    RollNumber VARCHAR(8) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address TEXT,
    Email VARCHAR(255) NOT NULL,
    RoleID INT,
	DefaultLoanDays INT DEFAULT 14,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Chèn dữ liệu mẫu vào Users
INSERT INTO Users (RollNumber, Password, FullName, PhoneNumber, Address, Email, RoleID) 
VALUES ('CE10000', 'e10adc3949ba59abbe56e057f20f883e', 'Nguyen Van A', '9999999999', 'HCM', 'nguyenvana@gmail.com', 1);

-- Tạo bảng Transactions
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
	RollNumber VARCHAR(8),
    BookID INT,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Fine DECIMAL(10,2) DEFAULT 0.00,
	ExtendedDays INT DEFAULT 0,
	ExtensionReason VARCHAR(MAX),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
	FOREIGN KEY (RollNumber) REFERENCES Users(RollNumber),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Transactions (UserID, RollNumber, BookID, BorrowDate, DueDate, ReturnDate, Fine) 
VALUES (2, 'CE190872', 1, '2025-02-28', '2025-03-15', NULL, 0.00);

-- Tạo bảng TransactionHistory
CREATE TABLE TransactionHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    TransactionID INT,
    UserID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    Fine DECIMAL(10,2),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Tạo bảng LoanSettings
CREATE TABLE LoanSettings (
    SettingID INT PRIMARY KEY IDENTITY(1,1),
    DefaultLoanDays INT NOT NULL DEFAULT 14,
    LateFeePerDay DECIMAL(10, 2) NOT NULL DEFAULT 15000,
    MaxBooksAllowed INT NOT NULL DEFAULT 10
);
INSERT INTO LoanSettings (DefaultLoanDays, LateFeePerDay, MaxBooksAllowed) 
VALUES (14, 15000, 10);

-- Tạo bảng NotificationSettings
CREATE TABLE NotificationSettings (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    RollNumber VARCHAR(8) NOT NULL,
    NotificationInterval VARCHAR(10) NOT NULL DEFAULT '24',
    FOREIGN KEY (RollNumber) REFERENCES Users(RollNumber)
);
INSERT INTO NotificationSettings (RollNumber, NotificationInterval) 
SELECT RollNumber, '24' FROM Users;

-- Kiểm tra dữ liệu
SELECT * FROM Users;
SELECT * FROM Transactions;
SELECT * FROM TransactionHistory;

DELETE FROM Transactions WHERE RollNumber = 'CE190872';

UPDATE Transactions SET DueDate = DATEADD(day, 2, DueDate) WHERE RollNumber = 'CE190872' AND ReturnDate IS NULL;
SELECT DueDate FROM Transactions WHERE RollNumber = 'CE190872' AND ReturnDate IS NULL;
SELECT TOP 1 DueDate FROM Transactions WHERE RollNumber = 'CE190872' AND ReturnDate IS NULL ORDER BY DueDate DESC;
