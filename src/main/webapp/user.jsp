<%@ page import="beans.User" %>
    <%@ page import="java.util.*" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport" />
            <link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
                integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" rel="stylesheet" />
            <title>User Managment System</title>
        </head>

        <body>
            <nav class="navbar navbar-dark bg-dark p-2">
                <a class="navbar-brand">User Managment System</a>
                <form class="form-inline">
                    <input aria-label="Search" class="form-control mr-sm-2" placeholder="Search" type="search" />
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                        Search
                    </button>

                </form>
            </nav>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 py-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">User Managment System</h5>
                                <% if(request.getAttribute("existingUser")==null){ %>
                                    <form action="/insert" method="POST">
                                        <div class="form-group">
                                            <input class="form-control" id="name" name="name" placeholder="Name"
                                                type="text" />
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="email" name="email" placeholder="E-Mail"
                                                type="email" />
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="country" name="country"
                                                placeholder="Country" type="text" />
                                        </div>
                                        <button class="btn btn-outline-success" type="submit">
                                            Submit
                                        </button>
                                    </form>
                                    <% }else{ User existingUser=(User)request.getAttribute("existingUser"); %>

                                        <form action="/update" method="POST">
                                            <div class="form-group">
                                                <input class="form-control" id="name" name="name" placeholder="Name"
                                                    type="text" value="<%= existingUser.getName() %>" />
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" id="email" name="email" placeholder="E-Mail"
                                                    value="<%= existingUser.getEmail() %>" type="email" />
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" id="country" name="country"
                                                    placeholder="Country" value="<%= existingUser.getCountry() %>"
                                                    type="text" />
                                            </div>
                                            <button class="btn btn-outline-warning" type="submit">
                                                Update
                                            </button>
                                        </form>
                                        <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Country</th>
                                        <th scope="col">Edit</th>
                                        <th scope="col">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if(request.getAttribute("listUsers")!=null){ List<User>
                                        listUsers=(List)request.getAttribute("listUsers"); for(User user:listUsers){ %>
                                        <tr>
                                            <th scope="row">
                                                <%= user.getId() %>
                                            </th>
                                            <td>
                                                <%= user.getName() %>
                                            </td>
                                            <td>
                                                <%= user.getEmail() %>
                                            </td>
                                            <td>
                                                <%= user.getCountry() %>
                                            </td>
                                            <td>
                                                <a aria-pressed="true" class="btn btn-outline-primary"
                                                    href="/edit/<%= user.getId() %>" role="button">Edit</a>
                                            </td>
                                            <td>
                                                <a aria-pressed="true" class="btn btn-outline-danger"
                                                    href="/delete/<%= user.getId() %>" role="button">Delete</a>
                                            </td>
                                        </tr>
                                        <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <script crossorigin="anonymous"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
                src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
            <script crossorigin="anonymous"
                integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
                src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
            <script crossorigin="anonymous"
                integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
                src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"></script>
        </body>

        </html>