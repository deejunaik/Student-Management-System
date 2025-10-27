<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 80%; margin: 0 auto; }
        h1 { color: #333; text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .new-btn { background-color: #28a745; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px; margin-bottom: 20px; display: inline-block; }
        .home-link { margin-left: 20px; }
        .edit-btn { color: #007bff; text-decoration: none; margin-right: 10px; }
        .delete-btn { color: #dc3545; text-decoration: none; }
        .search-bar { margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between;}
    </style>
</head>
<body>
<div class="container">
    <h1>Student Management System</h1>
    
    <div class="header-buttons">
        <a href="StudentController?action=new" class="new-btn">Add New Student</a>
        <a href="index.html" class="home-link">Home</a>
    </div>

    <div class="search-bar">
        <form action="StudentController" method="get" style="display: flex;">
            <input type="hidden" name="action" value="search" />
            <input type="text" name="searchTerm" placeholder="Search by Name or Course" 
                   value="${searchTerm != null ? searchTerm : ''}" 
                   style="padding: 8px; border: 1px solid #ccc; width: 300px;">
            <button type="submit" style="padding: 8px 15px; background-color: #f0ad4e; color: white; border: none; border-radius: 5px; margin-left: 10px;">Search</button>
        </form>
        <c:if test="${searchTerm != null && searchTerm != ''}">
            <a href="StudentController?action=list" style="padding: 8px 15px; text-decoration: none; border-radius: 5px; color: #666; border: 1px solid #ccc;">Clear Search</a>
        </c:if>
    </div>
    
    <h2>List of Students <c:if test="${searchTerm != null && searchTerm != ''}"> (Results for: "${searchTerm}")</c:if></h2>
    
    <c:if test="${listStudent == null or listStudent.size() == 0}">
        <p>No students found in the database. <c:if test="${searchTerm != null && searchTerm != ''}"> (Try clearing the search)</c:if></p>
    </c:if>

    <c:if test="${listStudent.size() > 0}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${listStudent}">
                    <tr>
                        <td><c:out value="${student.id}" /></td>
                        <td><c:out value="${student.name}" /></td>
                        <td><c:out value="${student.email}" /></td>
                        <td><c:out value="${student.course}" /></td>
                        <td>
                            <a href="StudentController?action=edit&id=<c:out value='${student.id}' />" class="edit-btn">Edit</a>
                            &nbsp;&nbsp;&nbsp;
                            <a href="StudentController?action=delete&id=<c:out value='${student.id}' />" class="delete-btn" onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>