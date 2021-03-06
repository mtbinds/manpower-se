<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><la:message key="labels.admin_brand_title"/> | <la:message
            key="labels.searchlog_configuration"/></title>
    <jsp:include page="/WEB-INF/view/common/admin/head.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <jsp:include page="/WEB-INF/view/common/admin/header.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/view/common/admin/sidebar.jsp">
        <jsp:param name="menuCategoryType" value="log"/>
        <jsp:param name="menuType" value="searchLog"/>
    </jsp:include>
    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>
                            <la:message key="labels.searchlog_configuration_details"/>
                        </h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><la:link href="/admin/searchlog">
                                <la:message key="labels.searchlog_configuration_link_top"/>
                            </la:link></li>
                            <c:if test="${crudMode == 4}">
                                <li class="breadcrumb-item active"><la:message
                                        key="labels.searchlog_configuration_link_details"/></li>
                            </c:if>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <section class="content">
            <la:form action="/admin/searchlog/">
                <la:hidden property="crudMode"/>
                <c:if test="${crudMode==4}">
                    <la:hidden property="logType"/>
                    <la:hidden property="id"/>
                </c:if>
                <div class="row">
                    <div class="col-md-12">
                        <div
                                class="card card-outline <c:if test="${crudMode == 1 || crudMode == 2}">card-success</c:if><c:if test="${crudMode == 3}">card-danger</c:if><c:if test="${crudMode == 4}">card-primary</c:if>">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <la:message key="labels.searchlog_configuration_link_details"/>
                                </h3>
                                <div class="card-tools">
                                    <div class="btn-group">
                                        <la:link href="/admin/searchlog"
                                                 styleClass="btn btn-primary btn-xs">
                                            <la:message key="labels.searchlog_configuration_link_top"/>
                                        </la:link>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                    <%-- Message --%>
                                <div>
                                    <la:info id="msg" message="true">
                                        <div class="alert alert-info">${msg}</div>
                                    </la:info>
                                    <la:errors/>
                                </div>
                                    <%-- Form Fields --%>
                                <table class="table table-bordered">
                                    <tbody>
                                    <c:forEach var="info" items="${logParamItems}">
                                        <tr>
                                            <th style="width: 25%">${f:h(info.key)}</th>
                                            <c:choose>
                                                <c:when test="${info.key == 'Query ID'}">
                                                    <td><la:link
                                                            href="/admin/searchlog/search?logType=search&amp;queryId=${f:u(info.value)}&amp;userSessionId=&amp;requestedTimeRange=&amp;accessType=">${f:h(info.value)}</la:link></td>
                                                </c:when>
                                                <c:when test="${info.key == 'User Info ID'}">
                                                    <td><la:link
                                                            href="/admin/searchlog/search?logType=search&amp;queryId=&amp;userSessionId=${f:u(info.value)}&amp;requestedTimeRange=&amp;accessType=">${f:h(info.value)}</la:link></td>
                                                </c:when>
                                                <c:when test="${info.key == 'User Session ID'}">
                                                    <td><la:link
                                                            href="/admin/searchlog/search?logType=search&amp;queryId=&amp;userSessionId=${f:u(info.value)}&amp;requestedTimeRange=&amp;accessType=">${f:h(info.value)}</la:link></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>${f:h(info.value)}</td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer">
                                <c:if test="${crudMode == 4}">
                                    <button type="submit" class="btn btn-default" name="back"
                                            value="<la:message key="labels.searchlog_configuration_button_back" />">
                                        <em class="fa fa-arrow-circle-left"></em>
                                        <la:message key="labels.searchlog_configuration_button_back"/>
                                    </button>
                                    <c:if test="${editable}">
                                        <button type="button" class="btn btn-danger" name="delete"
                                                data-toggle="modal" data-target="#confirmToDelete"
                                                value="<la:message key="labels.searchlog_configuration_button_delete" />">
                                            <em class="fa fa-trash"></em>
                                            <la:message key="labels.searchlog_configuration_button_delete"/>
                                        </button>
                                        <div class="modal fade" id="confirmToDelete"
                                             tabindex="-1" role="dialog">
                                            <div class="modal-dialog">
                                                <div class="modal-content bg-danger">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">
                                                            <la:message key="labels.crud_title_delete"/>
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-label="Close">
                                                            <span aria-hidden="true">??</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>
                                                            <la:message key="labels.crud_delete_confirmation"/>
                                                        </p>
                                                    </div>
                                                    <div class="modal-footer justify-content-between">
                                                        <button type="button" class="btn btn-outline-light"
                                                                data-dismiss="modal">
                                                            <la:message key="labels.crud_button_cancel"/>
                                                        </button>
                                                        <button type="submit" class="btn btn-outline-light"
                                                                name="delete"
                                                                value="<la:message key="labels.crud_button_delete" />">
                                                            <em class="fa fa-trash"></em>
                                                            <la:message key="labels.crud_button_delete"/>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </la:form>
        </section>
    </div>
    <jsp:include page="/WEB-INF/view/common/admin/footer.jsp"></jsp:include>
</div>
<jsp:include page="/WEB-INF/view/common/admin/foot.jsp"></jsp:include>
</body>
</html>

