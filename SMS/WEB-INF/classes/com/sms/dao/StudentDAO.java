package com.sms.dao;

import com.sms.model.Student;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    // --- Database Connection Details (Verify these are correct for your XAMPP) ---
    private String jdbcURL = "jdbc:mysql://localhost:3306/studentsystem?useSSL=false";
    private String jdbcUsername = "root"; 
    private String jdbcPassword = "";     

    // --- SQL Statements ---
    private static final String INSERT_STUDENT_SQL = "INSERT INTO student (name, email, course) VALUES (?, ?, ?)";
    private static final String SELECT_STUDENT_BY_ID = "SELECT id, name, email, course FROM student WHERE id = ?";
    
    // UPDATED: Added ORDER BY name ASC for sorting
    private static final String SELECT_ALL_STUDENTS = "SELECT * FROM student ORDER BY name ASC";
    
    private static final String DELETE_STUDENT_SQL = "DELETE FROM student WHERE id = ?";
    private static final String UPDATE_STUDENT_SQL = "UPDATE student SET name = ?, email = ?, course = ? WHERE id = ?";
    
    // NEW: SQL for searching by name OR course
    private static final String SEARCH_STUDENTS_SQL = "SELECT * FROM student WHERE name LIKE ? OR course LIKE ?"; 

    // --- Connection Method ---
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    // --- CRUD Methods ---

    // 1. CREATE or INSERT
    public void insertStudent(Student student) throws SQLException {
        System.out.println(INSERT_STUDENT_SQL);
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STUDENT_SQL)) {
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getEmail());
            preparedStatement.setString(3, student.getCourse());
            System.out.println(preparedStatement); 
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
    }

    // 2. READ All (Now sorted by name)
    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDENTS);) {
            
            System.out.println(preparedStatement); 
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String course = rs.getString("course");
                students.add(new Student(id, name, email, course));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // 3. READ Single Student
    public Student selectStudent(int id) {
        Student student = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_BY_ID)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String course = rs.getString("course");
                student = new Student(id, name, email, course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }
    
    // 4. UPDATE
    public boolean updateStudent(Student student) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_STUDENT_SQL)) {
            statement.setString(1, student.getName());
            statement.setString(2, student.getEmail());
            statement.setString(3, student.getCourse());
            statement.setInt(4, student.getId());
            
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    // 5. DELETE
    public boolean deleteStudent(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_STUDENT_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    
    // 6. NEW: SEARCH 
    public List<Student> searchStudents(String searchTerm) {
        List<Student> students = new ArrayList<>();
        // Prepends and appends '%' for LIKE matching
        String searchWildcard = "%" + searchTerm + "%"; 
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_STUDENTS_SQL);) {
            
            preparedStatement.setString(1, searchWildcard); // Check name
            preparedStatement.setString(2, searchWildcard); // Check course
            
            System.out.println(preparedStatement); 
            ResultSet rs = preparedStatement.executeQuery();

            // Process the ResultSet
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String course = rs.getString("course");
                students.add(new Student(id, name, email, course));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}