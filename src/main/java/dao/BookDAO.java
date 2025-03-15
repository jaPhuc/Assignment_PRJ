/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Books;
import utils.DBContext;

/**
 *
 * @author giaph
 */
public class BookDAO extends DBContext {
    // Lấy tất cả sách từ cơ sở dữ liệu
    public List<Books> getAllBooks() throws SQLException {
        List<Books> bookList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT b.BookID, b.Title, b.Author, b.Publisher, STRING_AGG(g.GenreName, ', ') AS Genres " +
                         "FROM Books b " +
                         "LEFT JOIN BookGenres bg ON b.BookID = bg.BookID " +
                         "LEFT JOIN Genres g ON bg.GenreID = g.GenreID " +
                         "GROUP BY b.BookID, b.Title, b.Author, b.Publisher";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookID(rs.getInt("BookID"));
                book.setTitle(rs.getString("Title"));
                book.setAuthor(rs.getString("Author"));
                book.setPublisher(rs.getString("Publisher"));
                book.setGenres(rs.getString("Genres"));
                bookList.add(book);
            }
        } catch (SQLException e) {
            throw new SQLException("Error retrieving book list: " + e.getMessage());
        }
        return bookList;
    }

    // Tìm kiếm sách theo tiêu đề (không phân biệt hoa thường)
    public List<Books> searchBooksByTitle(String searchQuery) throws SQLException {
        List<Books> bookList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT b.BookID, b.Title, b.Author, b.Publisher, STRING_AGG(g.GenreName, ', ') AS Genres " +
                         "FROM Books b " +
                         "LEFT JOIN BookGenres bg ON b.BookID = bg.BookID " +
                         "LEFT JOIN Genres g ON bg.GenreID = g.GenreID " +
                         "WHERE b.Title LIKE ? " +
                         "GROUP BY b.BookID, b.Title, b.Author, b.Publisher";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchQuery + "%"); // Tìm kiếm gần đúng
            rs = stmt.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookID(rs.getInt("BookID"));
                book.setTitle(rs.getString("Title"));
                book.setAuthor(rs.getString("Author"));
                book.setPublisher(rs.getString("Publisher"));
                book.setGenres(rs.getString("Genres"));
                bookList.add(book);
            }
        } catch (SQLException e) {
            throw new SQLException("Error searching books: " + e.getMessage());
        }
        return bookList;
    }
}
