<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
ul {
	padding: 0px;
	margin: 10px;
	list-style: none;
}

.jobdisplayholder {
	min-height: 180px;
}

.jobholder>a {
	text-decoration: none;
}

.jobholder {
	
	border: 1px solid #f05f40 !important;
	box-shadow: 0 3px 3px 0 #888888 !important;
	transition: 0.3s;
	margin: 5px -5px;
}

.jobholder:hover {
	box-shadow: 0 4px 6px 0 #888888 !important;
}

.jobDescription {
	color: black;
	text-align:center;
	height: 124px;
	border-bottom: 1px solid #666;
}

.jobpostion {
	color: #7c795d;
	font-family: times, Times New Roman, times-roman, georgia, serif;
	font-weight: bold;
	text-transform: capitalize;
}
.jobaddress{
	text-transform: capitalize;
}
.jobcompanyname {
	color: #444;
	font-family: Gill Sans, Verdana;
	text-transform: capitalize;
}
.subTitle {
text-align:center;
text-transform: capitalize;
}

.pageBody {
	/* 	margin: 2px 5px; */
	margin-left: 2%;
	min-height: 470px;
}

.pageFooter {
	/* 	margin: 2px 5px; */
	margin-left: 5%;
}
</style>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
</head>
<body>
	<div class="col-md-8">
		<!-- Blog Search Well -->



		<div class="row pageBody">
			<ul>
				<li><c:if test="${param.verifiedReqeusted eq true }">
						<c:choose>
							<c:when test="${param.verified eq true}">
								<div class="container-fluid"
									style="margin: 2px 2px; padding: 5px;">
									<div class="alert alert-success">Congratulations! Your
										email alert request has been verified.</div>
								</div>
							</c:when>
							<c:when test="${param.verified eq false}">
								<div class="container-fluid"
									style="margin: 2px 2px; padding: 5px;">
									<div class="alert alert-danger">Your email alert request
										is not verified.Something goes wrong</div>
								</div>
							</c:when>
						</c:choose>
					</c:if></li>
				<li><div class="container-fluid"
						style="background-color: #ECE9E6; margin: 2px 5px; padding: 5px; box-shadow: 1px 1px 2px grey;">
						<div class="input-group">

							<input type="text" class="form-control" id="jobsearchinput">
							<span class="input-group-btn">
								<button id="search" class="btn btn-default" type="button"
									style="height: 32px; margin: 0px;" placement="top"
									title="Search">
									<span class="glyphicon glyphicon-search"></span>
								</button>
								<button type="button" class="btn btn-default"
									style="height: 32px; margin: 0px;" data-toggle="modal"
									data-target="#emailAlertModal" placement="top"
									title="Email alert">
									<span class="glyphicon glyphicon-bell"></span>
								</button>
							</span>


						</div>
						<!-- /.input-group -->
					</div></li>
				<c:forEach items="${postedJobs}" var="postedJob">

					<li><div class="col-sm-6 col-md-4 jobdisplayholder">
							<div class="jobholder">
								<a
									href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">
									<div class="jobDescription">
										<p>
										<h3>
											<span class="jobpostion">${postedJob.position}</span>
										</h3>
											For <span class="jobcompanyname">
												${postedJob.company.name}</span>
										<br> <span class="jobaddress">${postedJob.company.city},
											${postedJob.company.country}</span>
										</p>

									</div>
								</a>
								<div class="subTitle">
									<p>

										Until 
										<fmt:formatDate type="date" value="${postedJob.deadLine}" />
									</p>
								</div>

							</div>

						</div></li>
				</c:forEach>
			</ul>
		</div>

		<input type="hidden" id="contextvalue"
			value="${pageContext.request.contextPath}" />

		<!-- Pager -->
		<div class="row pageFooter">
			<input type="hidden" id="totalPageSize" value="${totalPageSize}">
			<nav>
				<ul class="pagination" id="jobsPagination">
					<c:if test="${totalPageSize>1}">
						<li id="previousPage"><a
							href="${pageContext.request.contextPath}/jobPosts/${catigory}/${pageNumber>1?(pageNumber-1):1}.html"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${startat}" end="${endat}">
						<c:choose>
							<c:when test="${i == pageNumber}">
								<li class="active">
							</c:when>
							<c:when test="${i != pageNumber}">
								<li class="" id="${i}">
							</c:when>
						</c:choose>
						<a
							href="${pageContext.request.contextPath}/jobPosts/${catigory}/${i}.html"><c:out
								value="${i}" /> </a>
						</li>
					</c:forEach>
					<c:if test="${totalPageSize>1}">
						<li id="nextPage"><a
							href="${pageContext.request.contextPath}/jobPosts/${catigory}/${pageNumber<totalPageSize?(pageNumber+1):totalPageSize}.html"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	<!-- Modal -->

	<div class="modal fade" id="emailAlertModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<form class="form-horizontal">
				<div class="modal-content">
					<div class="modal-header">
						<button id="btnClose" type="button" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Do you want email
							alert?</h4>
						<div class="progress" id="progressbar">
							<div class="progress-bar progress-bar-striped active"
								role="progressbar" aria-valuenow="45" aria-valuemin="0"
								aria-valuemax="100" style="width: 45%">
								<span class="sr-only" id="percentCompleted"></span>
							</div>
						</div>
					</div>
					<!-- 					register.html?success=false&message=Exists -->
					<%-- ${param.message eq 'Exists'} --%>
					<div class="modal-body">
						<div id="alert_successmsg" class="alert alert-success"
							style="display: none;">Please check your email address to
							verify your request.</div>
						<div id="alert_errormsg" class="alert alert-danger"
							style="display: none;">Error!</div>
						<div class="form-group">
							<div class="col-sm-12">
								<input type="text" class="form-control" id="name_alertme"
									placeholder="Your name">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<input type="email" class="form-control" id="email_alertme"
									placeholder="Your email">
							</div>
						</div>
						<div class="form-group">
							<div id="parentSelect" class="col-sm-12">
								<select name="selectedCompany" id="position_alertme"
									class="form-control selectpicker">
									<option value="selectpositon">Select position</option>
									<c:forEach items="${positions}" var="selectedPosition">
										<option value="${selectedPosition}">${selectedPosition}</option>
									</c:forEach>
								</select>
							</div>
						</div>

					</div>
					<div class="modal-footer">
						<button id="btnCancel" type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button id="btnAlert" type="button" class="btn btn-primary">Alert
							me</button>
					</div>

				</div>
			</form>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$(document)
			.ready(
					function() {//btnClose btnCancel

						$(".alert").delay(2000).slideUp(500, function() {
							$(this).alert('close');
						});

						$('#progressbar').hide();
						function clearAlertForm() {
							$('#name_alertme').val(null);
							$('#email_alertme').val(null);
							// 		$('#position_alertme').val('selectpositon');
							// 		$('#position_alertme').html('Select position');
							$("#position_alertme option:selected").prop(
									"selected", false);
							$("#position_alertme").prop("selectedIndex", 0);
							$("#position_alertme").val(
									$("#position_alertme option:first").val());
							$("#position_alertme option:first").attr(
									'selected', 'selected');
							$('#alert_errormsg').css('display', 'none');
							$('#alert_successmsg').css('display', 'none');
							$('#btnAlert').show();
						}
						function isEmail(email) {
							var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
							return regex.test(email);
						}

						$('#btnAlert')
								.click(
										function() {
											clearAlertForm();
											var aname = $('#name_alertme');
											var aemail = $('#email_alertme');
											var aposition = $('#position_alertme');
											var isValid = true;
											$('#alert_errormsg').css('display',
													'none');
											$('#alert_successmsg').css(
													'display', 'none');
											if (aposition.val() == "selectpositon") {

												$('#parentSelect').find(
														'button').css(
														'border-color', 'red');
												aposition.focus();
												$('#alert_errormsg').css(
														'display', 'block');
												isValid = false;
											} else {
												$('#parentSelect').find(
														'button')
														.css('border-color',
																'black');
											}
											if (aemail.val() == null
													|| aemail.val() == ""
													|| !isEmail(aemail.val())) {

												aemail.css('border-color',
														'red');
												aemail.focus();
												isValid = false;
											} else {
												aemail.css('border-color',
														'black');
											}
											if (aname.val() == null
													|| aname.val() == "") {

												aname
														.css('border-color',
																'red');
												aname.focus();
												isValid = false;
											} else {
												aname.css('border-color',
														'black');
											}
											if (isValid) {
												$('#progressbar').show();
												//alert("alert me after"+$('#progressbar').css('display'));
												$
														.ajax({
															type : 'POST',
															url : '${pageContext.request.contextPath}/alertme',
															contentType : 'application/json',
															dataType : 'json',
															data : JSON
																	.stringify({
																		user_name : aname
																				.val(),
																		user_eamil : aemail
																				.val(),
																		selecte_position : aposition
																				.val()
																	}),
															success : function(
																	data) {
																//alert(data.isSaved+' in success');
																$(
																		'#progressbar')
																		.hide();
																if (data.isSaved == 'true') {
																	$(
																			'#alert_successmsg')
																			.css(
																					'display',
																					'block');
																	$(
																			'#btnAlert')
																			.hide();
																} else {
																	$(
																			'#alert_errormsg')
																			.css(
																					'display',
																					'block');
																	$(
																			'#alert_errormsg')
																			.html(
																					'Email alert already requested');
																}
															},
															error : function(ts) {
																$(
																		'#progressbar')
																		.hide();
																$(
																		'#alert_errormsg')
																		.css(
																				'display',
																				'block');
																$('#btnAlert')
																		.hide();
																// 						alert(ts.responseText);
															}
														});

											}

										});
						$('#search')
								.click(
										function() {
											var catValue = $('#jobsearchinput')
													.val();
											if (catValue == null
													|| catValue == "") {
												// 			location.reload(true);
												window.location
														.replace('${pageContext.request.contextPath}/');

											} else {
												window.location
														.replace('${pageContext.request.contextPath}/jobPosts/'
																+ catValue
																+ '/1.html');
											}

										});
						$('#jobsPagination li').click(function() {
							var selectedLi = $('#jobsPagination li.active');

						});

						$("#jobsearchinput")
								.autocomplete(
										{
											source : function(query, process) {
												$
														.ajax({
															type : 'GET',
															url : '${pageContext.request.contextPath}/catigories',
															contentType : 'application/json',
															dataType : 'json',
															data : {
																q : query.term
															},
															success : function(
																	data) {
																process(data);
															},
															error : function(ts) {
																//alert(ts.responseText);
															}
														});
											}
										});

					});
</script>


