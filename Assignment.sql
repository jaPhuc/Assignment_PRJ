CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- Tạo bảng Genres (không thay đổi)
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY(1,1),
    GenreName VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO Genres (GenreName)
VALUES 
    ('Self Help'),
    ('Philosophy & Religion'),
    ('History & Strategy'),
    ('Short Stories'),
    ('Manga'),
    ('Literature'),
    ('Novel');

SELECT * FROM Genres;
DELETE FROM Genres;

-- Tạo bảng Books (xóa cột GenreID)
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Publisher VARCHAR(255)
);

-- Tạo bảng trung gian BookGenres để liên kết Books và Genres
CREATE TABLE BookGenres (
    BookID INT,
    GenreID INT,
    PRIMARY KEY (BookID, GenreID), -- Khóa chính là tổ hợp của BookID và GenreID
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

INSERT INTO BookGenres (BookID, GenreID)
VALUES 
    (1, 1),  -- 'Dac nhan tam' - Self Help
    (2, 1),  -- 'Quang ganh lo di & vui song' - Self Help
    (3, 1),  -- 'Atomic Habits' - Self Help
    (4, 1),  -- '7 thoi quen cua nguoi thanh dat' - Self Help
    (5, 1),  -- 'Lanh dao 101' - Self Help
    (6, 1),  -- 'Dam bi ghet' - Self Help
    (7, 1),  -- 'Ban co the dam phan bat cu dieu gi' - Self Help
    (8, 1),  -- 'Thay doi de thanh cong' - Self Help
    (9, 1),  -- 'Nha gia kim' - Self Help
    (10, 1), -- 'Di tim le song' - Self Help
    (11, 2), -- 'Luan ngu' - Philosophy & Religion
    (12, 2), -- 'Dao duc kinh' - Philosophy & Religion
    (13, 2), -- 'Kinh phap cu' - Philosophy & Religion
    (14, 2), -- 'Plato in 60 minuten' - Philosophy & Religion
    (15, 2), -- 'Tu thuat thanh Augustino' - Philosophy & Religion
    (16, 2), -- 'The gioi cua Sophie' - Philosophy & Religion
    (17, 2), -- 'Zarathustra da noi nhu the' - Philosophy & Religion
    (18, 2), -- 'Su an ui cua triet hoc' - Philosophy & Religion
    (19, 2), -- 'Doi thay doi khi chung ta thay doi' - Philosophy & Religion
    (20, 2), -- 'Bi mat cua hanh phuc' - Philosophy & Religion
    (21, 3), -- 'Binh phap Ton Tu' - History & Strategy
    (22, 3), -- 'Luoc su loai nguoi' - History & Strategy
    (23, 3), -- 'Luoc su tuong lai' - History & Strategy
    (24, 3), -- 'Nghe thuat chien tranh' - History & Strategy
    (25, 3), -- 'Cuoc doi Napoleon' - History & Strategy
    (26, 3), -- 'Ho Chi Minh bien nien su' - History & Strategy
    (27, 3), -- 'The chien Z' - History & Strategy
    (28, 3), -- 'Diep vien hoan hao' - History & Strategy
    (29, 3), -- 'Cuoc doi va su nghiep cua Winston Churchill' - History & Strategy
    (30, 3), -- 'Quan Vuong' - History & Strategy
    (31, 4), -- 'Nhat ky Anne Frank' - Short Stories
    (32, 4), -- 'Hat giong tam hon' - Short Stories
    (33, 4), -- 'Bat tre dong xanh' - Short Stories
    (34, 4), -- 'Nhung nguoi thich dua' - Short Stories
    (35, 4), -- 'Truyen ngan Nguyen Huy Thiep' - Short Stories
    (36, 4), -- 'Totto-chan ben cua so' - Short Stories
    (37, 4), -- 'Cay cam ngot cua toi' - Short Stories
    (38, 4), -- 'Khu vuon mua ha' - Short Stories
    (39, 4), -- 'Nguoi dan ong den tu Bac Kinh' - Short Stories
    (40, 4), -- 'Neu biet tram nam la huu han' - Short Stories
    (41, 5), -- 'One Piece' - Manga
    (42, 5), -- 'Naruto' - Manga
    (43, 5), -- 'Doraemon' - Manga
    (44, 5), -- 'Dragon Ball' - Manga
    (45, 5), -- 'Attack on Titan' - Manga
    (46, 5), -- 'Death Note' - Manga
    (47, 5), -- 'Detective Conan' - Manga
    (48, 5), -- 'Vagabond' - Manga
    (49, 5), -- 'Chihayafuru' - Manga
    (50, 6), -- 'Don Quixote' - Literature
    (51, 6), -- 'A Tale of Two Cities' - Literature
    (52, 6), -- 'Hồng Lâu Mộng' - Literature
    (53, 6), -- 'The Little Prince' - Literature
    (54, 6), -- 'The Hobbit' - Literature
    (55, 6), -- 'The Lion, the Witch and the Wardrobe' - Literature
    (56, 6), -- 'Harry Potter and the Sorcerer`s Stone' - Literature
    (57, 6), -- 'And Then There Were None' - Literature
    (58, 6), -- 'The Lord of the Rings' - Literature
    (59, 6), -- 'Harry Potter and the Chamber of Secrets' - Literature
    (60, 6), -- 'Harry Potter and the Prisoner of Azkaban' - Literature
    (61, 6), -- 'Harry Potter and the Goblet of Fire' - Literature
    (62, 6), -- 'Harry Potter and the Order of the Phoenix' - Literature
    (63, 6), -- 'Harry Potter and the Half-Blood Prince' - Literature
    (64, 6), -- 'Harry Potter and the Deathly Hallows' - Literature
    (65, 7), -- 'The Da Vinci Code' - Novel
    (66, 7), -- 'Murder on the Orient Express' - Novel
    (67, 7), -- 'The Girl with the Dragon Tattoo' - Novel
    (68, 7), -- 'The Hound of the Baskervilles' - Novel
    (69, 7), -- 'The Silence of the Lambs' - Novel
    (70, 7), -- 'Pride and Prejudice' - Novel
    (71, 7), -- 'Gone with the Wind' - Novel
    (72, 7), -- 'Fifty Shades of Grey' - Novel
    (73, 7), -- 'The Notebook' - Novel
    (74, 7), -- 'Me Before You' - Novel
    (75, 7), -- 'Dune' - Novel
    (76, 7), -- '1984' - Novel
    (77, 7), -- 'Brave New World' - Novel
    (78, 7), -- 'Fahrenheit 451' - Novel
    (79, 7), -- 'The Hitchhiker`s Guide to the Galaxy' - Novel
    (80, 7), -- 'Dracula' - Novel
    (81, 7), -- 'The Shining' - Novel
    (82, 7), -- 'Frankenstein' - Novel
    (83, 7), -- 'The Exorcist' - Novel
    (84, 7), -- 'Treasure Island' - Novel
    (85, 7), -- 'The Count of Monte Cristo' - Novel
    (86, 7), -- 'Life of Pi' - Novel
    (87, 7), -- 'Into the Wild' - Novel
    (88, 7), -- 'The Three Musketeers' - Novel
    (89, 7), -- 'The Catcher in the Rye' - Novel
    (90, 7), -- 'One Hundred Years of Solitude' - Novel
    (91, 7), -- 'Crime and Punishment' - Novel
    (92, 7), -- 'The Bell Jar' - Novel
    (93, 7), -- 'The Road' - Novel
    (94, 7), -- 'American Psycho' - Novel
    (95, 7); -- 'Gone Girl' - Novel

SELECT * FROM Books;

DELETE FROM BookGenres;
DELETE FROM Books;

INSERT INTO Books (Title, Author, Publisher)
VALUES 
    ('Dac nhan tam', 'Dale Carnegie', 'NXB Tong hop thanh pho Ho Chi Minh'),
    ('Quang ganh lo di & vui song', 'Dale Carnegie', 'NXB Tre'),
    ('Atomic Habits', 'James Clear', 'NXB Phuong Nam'),
    ('7 thoi quen cua nguoi thanh dat', 'Stephen R. Covey', 'NXB Tre'),
    ('Lanh dao 101', 'John C. Maxwell', 'NXB Hong Duc'),
    ('Dam bi ghet', 'Ichiro Kishimi & Fumitake Koga', 'NXB Lao Đong'),
    ('Ban co the dam phan bat cu dieu gi', 'Herb Cohen', 'NXB Cong Duong'),
    ('Thay doi de thanh cong', 'Spencer Johnson', 'NXB Van Hoc'),
    ('Nha gia kim', 'Paulo Coelho', 'NXB Van Hoc'),
    ('Di tim le song', 'Viktor Frankl', 'NXB Tong hop thanh pho Ho Chi Minh'),
    ('Luan ngu', 'Khong Tu', 'NXB Van Hoc'),
    ('Dao duc kinh', 'Lao Tu', 'NXB Tre'),
    ('Kinh phap cu', 'Phat Giao', 'NXB Hong Duc'),
    ('Plato in 60 minuten', 'Plato', 'NXB Hong Duc'),
    ('Tu thuat thanh Augustino', 'Augustine of Hippo', 'NXB Dong Nai'),
    ('The gioi cua Sophie', 'Jostein Gaarder', 'NXB The Gioi'),
    ('Zarathustra da noi nhu the', 'Friedrich Nietzsche', 'NXB Van Hoc'),
    ('Su an ui cua triet hoc', 'Alain de Botton', 'NXB The Gioi'),
    ('Doi thay doi khi chung ta thay doi', 'Andrew Matthews', 'NXB Tre'),
    ('Bi mat cua hanh phuc', 'Matthieu Ricard', 'NXB Tong hop thanh pho Ho Chi Minh'),
    ('Binh phap Ton Tu', 'Ton Tu', 'NXB Hong Duc'),
    ('Luoc su loai nguoi', 'Yuval Noah Harari', 'NXB Tri Thuc'),
    ('Luoc su tuong lai', 'Yuval Noah Harari', 'NXB Tri Thuc'),
    ('Nghe thuat chien tranh', 'Carl von Clausewitz', 'NXB Tri Thuc'),
    ('Cuoc doi Napoleon', 'Vincent Cronin', 'NXB Tri Thuc'),
    ('Ho Chi Minh bien nien su', 'Nhieu tac gia', 'NXB Chinh tri quoc gia su that'),
    ('The chien Z', 'Max Brooks', 'NXB Thong tan'),
    ('Diep vien hoan hao', 'Larry Berman', 'NXB Thong tan'),
    ('Cuoc doi va su nghiep cua Winston Churchill', 'Winston Churchill', 'NXB Hong Duc'),
    ('Quan Vuong', 'Niccolò Machiavelli', 'NXB Dong A'),
    ('Nhat ky Anne Frank', 'Anne Frank', 'NXB Dong A'),
    ('Hat giong tam hon', 'Nhieu tac gia', 'NXB Thanh pho Ho Chi Minh'),
    ('Bat tre dong xanh', 'J.D. Salinger', 'NXB Tong hop thanh pho Ho Chi Minh'),
    ('Nhung nguoi thich dua', 'Aziz Nesin', 'NXB Van hoc'),
    ('Truyen ngan Nguyen Huy Thiep', 'Nguyen Huy Thiep', 'NXB Van hoc'),
    ('Totto-chan ben cua so', 'Tetsuko Kuroyanagi', 'NXB Van hoc'),
    ('Cay cam ngot cua toi', 'José Mauro de Vasconcelos', 'NXB Van hoc'),
    ('Khu vuon mua ha', 'Kazumi Yumoto', 'NXB Van hoc'),
    ('Nguoi dan ong den tu Bac Kinh', 'Henning Mankell', 'NXB Hoi nha van'),
    ('Neu biet tram nam la huu han', 'Pham Lu An', 'NXB Van hoc'),
    ('One Piece', 'Eiichiro Oda', 'NXB Kim Dong'),
    ('Naruto', 'Masashi Kishimoto', 'NXB Kim Dong'),
    ('Doraemon', 'Fujiko F. Fujio', 'NXB Kim Dong'),
    ('Dragon Ball', 'Akira Toriyama', 'NXB Kim Dong'),
    ('Attack on Titan', 'Hajime Isayama', 'NXB Tre'),
    ('Death Note', 'Tsugumi Ohba', 'NXB Tre'),
    ('Detective Conan', 'Gosho Aoyama', 'NXB Kim Dong'),
    ('Vagabond', 'Takehiko Inoue', 'NXB Tre'),
    ('Chihayafuru', 'Yuki Suetsugu', 'Francisco de Robles'),
    ('Don Quixote', 'Miguel de Cervantes', 'NXB Tri Thuc'),
    ('A Tale of Two Cities', 'Charles Dickens', 'London'),
    ('Hong Lau Mong', 'Tao Tuyet Can', 'NXB Van hoc'),
    ('The Little Prince', 'Antoine de Saint-Exupéry', 'Reynal & Hitchcock'),
    ('The Hobbit', 'J.R.R. Tolkien', 'George Allen & Unwin'),
    ('The Lion, the Witch and the Wardrobe', 'C.S. Lewis', 'Geoffrey Bles'),
    ('Harry Potter and the Sorcerer`s Stone', 'J.K. Rowling', 'Bloomsbury'),
    ('And Then There Were None', 'Agatha Christie', 'Collins Crime Club'),
    ('The Lord of the Rings', 'J.R.R. Tolkien', 'Allen & Unwin'),
    ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Bloomsbury'),
    ('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Bloomsbury'),
    ('Harry Potter and the Goblet of Fire', 'J.K. Rowling', 'Bloomsbury'),
    ('Harry Potter and the Order of the Phoenix', 'J.K. Rowling', 'Bloomsbury'),
    ('Harry Potter and the Half-Blood Prince', 'J.K. Rowling', 'Bloomsbury'),
    ('Harry Potter and the Deathly Hallows', 'J.K. Rowling', 'Bloomsbury'),
    ('The Da Vinci Code', 'Dan Brown', 'DoubleDay'),
    ('Murder on the Orient Express', 'Agatha Christie', 'Collins Crime Club'),
    ('The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Norstedts Förlag'),
    ('The Hound of the Baskervilles', 'Arthur Conan Doyle', 'George Newnes Ltd'),
    ('The Silence of the Lambs', 'Thomas Harris', 'St. Martins Press'),
    ('Pride and Prejudice', 'Jane Austen', 'Whitehall'),
    ('Gone with the Wind', 'Margaret Mitchell', 'Macmillan'),
    ('Fifty Shades of Grey', 'E.L. James', 'Vintage Books'),
    ('The Notebook', 'Nicholas Sparks', 'Warner Books'),
    ('Me Before You', 'Jojo Moyes', 'Michael Joseph'),
    ('Dune', 'Frank Herbert', 'Chilton Books'),
    ('1984', 'George Orwell', 'Tahabu'),
    ('Brave New World', 'Aldous Huxley', 'Chatto & Windus'),
    ('Fahrenheit 451', 'Ray Bradbury', 'Penguin'),
    ('The Hitchhiker`s Guide to the Galaxy', 'Douglas Adams', 'DoubleDay'),
    ('Dracula', 'Bram Stoker', 'Archibald Constable and Company'),
    ('The Shining', 'Stephen King', 'DoubleDay'),
    ('Frankenstein', 'Mary Shelley', 'Lackington'),
    ('The Exorcist', 'William Peter Blatty', 'Harper & Row'),
    ('Treasure Island', 'Robert Louis Stevenson', 'Penguin'),
    ('The Count of Monte Cristo', 'Alexandre Dumas', 'Penguin'),
    ('Life of Pi', 'Yann Martel', 'Vernon'),
    ('Into the Wild', 'Jon Krakauer', 'Marianne'),
    ('The Three Musketeers', 'Alexandre Dumas', 'Vintage'),
    ('The Catcher in the Rye', 'J.D. Salinger', 'CDIMEX'),
    ('One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 'CDIMEX'),
    ('Crime and Punishment', 'Fyodor recognisesDostoevsky', 'The Russian Messenger'),
    ('The Bell Jar', 'Sylvia Plath', 'NXB Tri thuc'),
    ('The Road', 'Cormac McCarthy', 'Alfred A. Knopf'),
    ('American Psycho', 'Bret Easton Ellis', 'Vintage'),
    ('Gone Girl', 'Gillian Flynn', 'Crown Publishing Group');

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(0,1),
    RoleName VARCHAR(50) UNIQUE NOT NULL
);
INSERT INTO Roles (RoleName) VALUES ('admin'), ('user');

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
	RollNumber VARCHAR(8) UNIQUE NOT NULL,
	Password VARCHAR(255) NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address TEXT,
    Email VARCHAR(255) NOT NULL,
	RoleID INT,
	FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

SELECT * FROM Users;

SELECT COUNT(*) FROM Users WHERE fullName = 'Nguyen Van B';

DROP TABLE Users;

DELETE FROM Users WHERE RollNumber = 'CE11111';

INSERT INTO Users (RollNumber, Password, FullName, PhoneNumber, Address, Email, RoleID) VALUES 
('CE100000', 'e10adc3949ba59abbe56e057f20f883e', 'Nguyen Van A', 9999999999, 'HCM', 'nguyenvana@gmail.com', 1);

SELECT * FROM Users WHERE RollNumber = 'CE10000' AND Password = '123456';

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    BookID INT,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Fine DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

SELECT * FROM Transactions;

CREATE TABLE TransactionHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    TransactionID INT,
    UserID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    Fine DECIMAL(10, 2),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);