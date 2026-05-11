<!-- navbar.jsp -->
<style>
/* Navbar Styling */
.navbar {
  display: flex;
  justify-content: space-between;   /* logo left, search right */
  align-items: center;
  background: rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(6px);
  padding: 14px 25px;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
  box-shadow: 0 4px 10px rgba(0,0,0,0.3);
}

.navbar .logo {
  font-size: 26px;
  font-weight: bold;
  color: #fff;
  letter-spacing: 1px;
}

.navbar .logo span {
  color: #ffa500;
}

/* Center the nav links */
.navbar .nav-links {
  list-style: none;
  display: flex;
  gap: 25px;
  margin: 0 auto; /* pushes links to center */
}

.navbar .nav-links li a {
  color: #fff;
  text-decoration: none;
  font-weight: 500;
  position: relative;
  transition: color 0.3s ease;
}

.navbar .nav-links li a::after {
  content: "";
  position: absolute;
  width: 0%;
  height: 2px;
  bottom: -4px;
  left: 0;
  background-color: #ffa500;
  transition: width 0.3s ease;
}

.navbar .nav-links li a:hover {
  color: #7FFF00;
}

.navbar .nav-links li a:hover::after {
  width: 100%;
}

/* Search box aligned right */
.search-box {
  margin-right: auto; /* pushes search bar to far right */
  display: flex;
  gap: 8px;
  align-items: center;
}

.search-box input {
  padding: 6px 12px;
  border-radius: 20px;
  border: 1px solid #ccc;
  outline: none;
  transition: box-shadow 0.3s ease;
}

.search-box input:focus {
  box-shadow: 0 0 8px #ffa500;
}

.search-box button {
  padding: 6px 14px;
  background: #ffa500;
  border: none;
  cursor: pointer;
  font-weight: bold;
  color: #fff;
  border-radius: 20px;
  transition: background 0.3s ease, transform 0.2s ease;
}

.search-box button:hover {
  background: #ff7f50;
  transform: scale(1.05);
}
</style>

<nav class="navbar about-us">
  <div class="logo">Bright<span>Minds</span></div>
  
  <ul class="nav-links">
    <li><a href="career-exploration.jsp" target="_blank">Psychometric Test</a></li>
    <li><a href="exam-details.jsp" target="_blank">Resource</a></li>
    <li><a href="contact.jsp#about-us">About Us</a></li>
    <li><a href="feedback.jsp" target="_blank">Feedback</a></li>
  </ul>
  
  <div class="search-box">
    <input type="text" id="searchInput" placeholder="Search for Colleges" />
    <button onclick="searchFunction()">Go</button>
  </div>
</nav>

<script>
  // Interactive search function
   function searchFunction() {
    const query = document.getElementById("searchInput").value.trim();
    if(query !== "") {
      // Example: redirect to Google search with the query
      window.open("https://www.google.com/search?q=" + encodeURIComponent(query), "_blank");
      
      // OR if you want to redirect to your own search.jsp page:
      // window.location.href = "search.jsp?query=" + encodeURIComponent(query);
    } else {
      alert("Please enter a college name to search.");
    }
  }
</script>
