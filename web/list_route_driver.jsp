<%-- 
    Document   : list_route_driver
    Created on : Nov 8, 2023, 9:13:39 PM
    Author     : tuna
--%>

<jsp:useBean class="model.repository.CarRepository" id="showcar"></jsp:useBean>
<jsp:useBean class="model.repository.LocationRepository" id="showlocation"></jsp:useBean>
<jsp:useBean class="model.repository.TicketRepository" id="showticket"></jsp:useBean>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/list_staff.css"/>

        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <style>
            .modal {
                top: 10%;
            }

            .table td, table th{
                text-align: center;
            }

            /* Add this CSS to your stylesheet */
            .btn-fix {
                /* Your regular button styles here */
                border: none;
                color: blue;
            }

            .btn-fix:active,
            .btn-fix:focus {
                outline: none;
                border: none;
            }

        </style>
    </head>
    <body>
        <%@ include file="/include/header.jsp" %>
        <%@ include file="/include/sidebar.jsp" %>
        <div class="body">
            <div class="box-list">
                <div class="title-page">
                    List Car Route
                </div>
                <form action="listcarroute" method="post">
                    <table width="100%" cellspacing="0" class="table-search">
                        <tbody>
                            <tr>
                                <td>                                   
                                    <select name="from" id="from" class="form-control col-sm-12">
                                        <option value="0">--Option--</option>
                                        <c:forEach var="location" items="${show1.listLocations}">
                                            <option value="${location.id}">${location.province}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <select class="form-control col-sm-12" name="to">
                                        <option value="0">--Option--</option>
                                        <c:forEach var="location" items="${show1.listLocations}">
                                            <option value="${location.id}">${location.province}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td class="date">
                                    <input class="form-control col-sm-12" type="date" name="datestart">
                                </td>
                                <td>
                                    <input type="submit" class="btn-find-ticket" value="Tìm vé">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>



                <div class="table">
                    <table border="2" class="table table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th>Name car</th>
                                <th>Plate</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Start</th>
                                <th>End</th>
                                <th>Date Start</th>
                                <th>Book</th>
                                <th>Payed</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="route" items="${rlistS}">
                                <tr>
                                    <td>${showcar.getCar(route.id).name}</td>
                                    <td>${showcar.getCar(route.id).licenseplate}</td>
                                    <td>${showlocation.getlocation(route.from).province}</td>
                                    <td>${showlocation.getlocation(route.to).province}</td>
                                    <td>${route.start}</td>
                                    <td>${route.end}</td>
                                    <td>${route.datestart}</td>
                                    <td>${showticket.getNumTicketsByRoute1(route.id)}</td>
                                    <td>${showticket.getNumTicketsByRoute2(route.id)}</td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- The Modal -->
        <form action="updatecarroute" method="get">
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">Update Car Route</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <!-- Modal body -->
                        <div class="modal-body">
                            <div class="container-fluid">
                                <input name="id" type="text" class="form-control" id="idInput" hidden>
                                <div class="form-group">
                                    <label for="nameInput">Name</label>
                                    <select name="name" class="form-control" id="typeInput" >
                                        <c:forEach var="name" items="${show.getListCars()}">
                                            <option value="${name.id}">${name.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="fromType">From</label>
                                    <select name="from" class="form-control" id="typeInput">
                                        <option value="">--Option--</option>
                                        <c:forEach var="location" items="${show1.listLocations}">
                                            <option value="${location.id}">${location.province}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="toType">To</label>
                                    <select name="to" class="form-control" id="typeInput">
                                        <option value="">--Option--</option>
                                        <c:forEach var="location" items="${show1.listLocations}">
                                            <option value="${location.id}">${location.province}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group" style="display: inline-block; margin-right: 80px; ">
                                    <label for="startType">Start Time</label>
                                    <select name="start" id="start">
                                        <% for (int hour = 0; hour < 24; hour++) { %>
                                        <% for (int minute = 0; minute < 60; minute += 60) {%>
                                        <option value="<%= String.format("%02d:%02d", hour, minute)%>">
                                            <%= String.format("%02d:%02d %s", hour % 12 == 0 ? 12 : hour % 12, minute, hour < 12 ? "AM" : "PM")%>
                                        </option>
                                        <% } %>
                                        <% }%>
                                    </select>
                                </div>
                                <div class="form-group" style="display: inline-block;">
                                    <label for="endType">Arrive Time</label>
                                    <select name="end" id="end">
                                        <% for (int hour = 0; hour < 24; hour++) { %>
                                        <% for (int minute = 0; minute < 60; minute += 60) {%>
                                        <option value="<%= String.format("%02d:%02d", hour, minute)%>">
                                            <%= String.format("%02d:%02d %s", hour % 12 == 0 ? 12 : hour % 12, minute, hour < 12 ? "AM" : "PM")%>
                                        </option>
                                        <% } %>
                                        <% }%>
                                    </select>
                                </div>
                                <div class="form-group" style="display: inline-block; margin-right: 50px; ">
                                    <label for="datestartInput">Date start</label>
                                    <input name="datestart" class="form-control" type="date" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
                                </div>
                                <div class="form-group" style="display: inline-block;">
                                    <label for="priceInput" >Price</label>
                                    <input name="price" type="text" class="form-control" id="priceInput" placeholder="Enter Price">
                                </div>
                                <div class="form-group">
                                    <label for="driverInput">Name</label>
                                    <select name="user_id" class="form-control" id="typeInput" >
                                        <c:forEach var="driver" items="${show2.getAllDrivers()}">
                                            <option value="${driver.id}">${driver.fullname}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Update</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            // Add an event listener to all "Update" buttons
            const updateButtons = document.querySelectorAll('.update-carroute');
            updateButtons.forEach(function (button) {
                button.addEventListener('click', function (event) {
                    const carId = button.getAttribute('data-carroute-id');
                    const idInput = document.getElementById('idInput');
                    idInput.value = carId;
                });
            });
        </script>
    </body>
</html>