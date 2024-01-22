 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/header.jsp"%>
<title>E-BookStore</title>
</head>
<body>
	<jsp:directive.include file="/includes/navbar.jsp" />

	<!--<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form class="row contact_form" id="loginForm" action="login" method="post">
					<div class="form-group">
						<label>Email address</label> 
						<input type="text" name="login-email" class="form-control" placeholder="Enter email">
					</div>
					<div class="form-group">
						<label>Password</label> 
						<input type="password" name="login-password" class="form-control" placeholder="Password">
					</div>
					<div class="text-center">
						<button type="submit" value="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
-->
<style>
    /* Kiểu dáng để căn giữa form và tạo khoảng cách từ header */
    .login-container {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 80vh; /* Điều chỉnh chiều cao của container tùy thuộc vào nhu cầu của bạn */
    }

    .login-part-form {
        background-color: #ffffff;
        padding: 20px;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }
</style>

<!-- HTML -->
<style>
    .login-container {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh; /* Đảm bảo form đăng nhập được căn giữa theo chiều dọc */
    }

    .login-part-form {
        background-color: #f8f9fa; /* Màu nền của form */
        padding: 10px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .login-heading {
        font-size: 28px;
        font-weight: bold;
        color: #007bff;
        margin-left:220px;
        margin-bottom: 20px;
        text-align: center;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .btn-login {
        width: 100%;
    }
    
</style>

<div class="container login-container">
    <div class="col-lg-6 col-md-6 login-part-form">
        <div class="login_part_form_iner">
            <c:if test="${message != null}">
                <p class="text-center" style="color: red;">${message}</p>
            </c:if>

            <form class="row contact_form" id="loginForm" action="login" method="post">
                <h3 class="text-center mb-4 login-heading">
                    Đăng nhập
                </h3>

                <div class="col-md-12 form-group p_star">
                    <input type="email" class="form-control" id="email" name="email" size="45" placeholder="Email" required>
                </div>

                <div class="col-md-12 form-group p_star">
                    <input type="password" class="form-control" id="password" name="password" size="15" placeholder="Mật khẩu" required>
                </div>

                <div class="col-md-12 form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-login">
                        Đăng nhập
                    </button>
                </div>
            </form>

            <div class="col-md-12 form-group">
                <p class="text-center">Bạn đã có tài khoản? <a href="register" class="text-primary">Đăng ký ở đây</a>.</p>
            </div>
        </div>
    </div>
</div>



	<%@include file="/includes/footer.jsp"%>
</body>
</html>