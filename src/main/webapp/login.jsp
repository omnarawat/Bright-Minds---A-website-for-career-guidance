<!DOCTYPE html>
<html>
<!--<body>
  <form action="add" method="get">
    Enter 1st number:<input type= "text" name="num1"><br>
    Enter 2nd number:<input type= "text" name="num2"><br>
    <input type= "submit">   
    </form>
</body>-->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>login Form</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="style.css">
</head>

<body class="login-page">

	<!-- Sign Up Section starts here -->
	<div class="container" id="signup" style="display: none;">
		<h1 class="form-title" id=" ">Register</h1>
		<form action="Signup" method = "post">
			<div class="input-group">

				<i class="fas fa-user"></i> <input type="text" name="fName"
					id="fname" placeholder="First Name" required> <label
					for="fname">First Name</label>
			</div>
			<div class="input-group">
				<i class="fas fa-user"></i> <input type="text" name="lName"
					id="lName" placeholder="Last Name" required> <label
					for="lName">Last Name</label>
			</div>
			<div class="input-group">
				<i class="fas fa-envelope"></i> <input type="email" name="email"
					id="email" placeholder="Email" required> <label for="email">Email</label>
			</div>
			<div class="input-group">
				<i class="fas fa-lock"></i> <input type="password" name="password"
					id="password" placeholder="Password" required> <label
					for="password">Password</label>
			</div>
			<input type="submit" class="btn" value="Sign Up" name="Sign Up">

		</form>
		<p class="or">------------or------------</p>
		<div class="icons">
			<i class="fab fa-google"></i> <i class="fab fa-facebook"></i>
		</div>
		<div class="links">
			<p>Already have account ?</p>

			<button id="signInButton">Sign In</button>

		</div>
	</div>

	<!-- Sign Up Section ends here -->


	<!-- Sign in Section starts here -->
	<div class="container" id="signIn">
		<h1 class="form-title" id=" ">Sign In</h1>
		<form action="${pageContext.request.contextPath}/Login" method="post">

			<div class="input-group">
				<i class="fas fa-envelope"></i> <input type="email" name="email"
					id="email" placeholder="Email" required> <label for="email">Email</label>
			</div>
			<div class="input-group">
				<i class="fas fa-lock"></i> <input type="password" name="password"
					id="password" placeholder="Password" required> <label
					for="password">Password</label>
			</div>
			<p class="recover">
				<a href="#"> Recover Password</a>

			</p>
			Sign In <input type="submit" class="btn" value="Sign In"
				name="SignIn">

		</form>
		<p class="or">------------or------------</p>
		<div class="icons">
			<i class="fab fa-google"></i> <i class="fab fa-facebook"></i>
		</div>
		<div class="links">
			<p>Don't have account yet ?</p>
			<button id="signUpButton">Sign Up</button>

		</div>
	</div>
	<!-- Sign in Section ends here -->

	<script src="script.js"></script>

</body>
</html>
