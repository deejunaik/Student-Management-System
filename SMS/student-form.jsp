<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${student != null}">Edit Student</c:when>
            <c:otherwise>Add New Student</c:otherwise>
        </c:choose>
    </title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 2px 2px 10px #aaa; }
        h1 { color: #333; text-align: center; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"] { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ddd; border-radius: 4px; }
        .button-group { text-align: right; }
        .button-group button { padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .back-link { margin-right: 15px; color: #6c757d; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h1>
            <c:choose>
                <c:when test="${student != null}">Edit Student</c:when>
                <c:otherwise>Add New Student</c:otherwise>
            </c:choose>
        </h1>

        <form action="StudentController" method="get">
            <c:if test="${student != null}">
                <input type="hidden" name="id" value="<c:out value='${student.id}' />" />
                <input type="hidden" name="action" value="update" />
            </c:if>
            <c:if test="${student == null}">
                <input type="hidden" name="action" value="insert" />
            </c:if>

            <div>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required
                       value="<c:out value='${student.name}' />" />
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required
                       value="<c:out value='${student.email}' />" />
            </div>
            <div>
                <label for="course">Course:</label>
                <input type="text" id="course" name="course" required
                       value="<c:out value='${student.course}' />" />
            </div>

            <div class="button-group">
                <a href="StudentController?action=list" class="back-link">Cancel</a>
                <button type="submit">
                    <c:choose>
                        <c:when test="${student != null}">Update</c:when>
                        <c:otherwise>Save</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</body>
</html>