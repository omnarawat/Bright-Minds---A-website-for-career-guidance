<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" >
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Choose Role — Student or Mentor</title>
  <!-- CSS CODE -->
  <style>
    :root{
      --bg1:#0f172a;
      --bg2:#07133a;
      --card:#0b1220;
      --accent1:#7c3aed; /* purple */
      --accent2:#06b6d4; /* teal */
      --glass: rgba(255,255,255,0.04);
      --muted: rgba(255,255,255,0.6);
    }
    /* animated gradient background */
    html,body{height:100%;}
    body{
      margin:0;
      font-family:Inter,ui-sans-serif,system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;
      background: linear-gradient(120deg,var(--bg1),var(--bg2));
      color:#e6eef8;
      display:flex;
      align-items:center;
      justify-content:center;
      overflow:hidden;
    }
    .bg-animated{
      position:fixed;inset:0;
      background: radial-gradient(600px 600px at 10% 20%, rgba(124,58,237,0.12), transparent 6%),
                  radial-gradient(400px 400px at 90% 80%, rgba(6,182,212,0.10), transparent 6%);
      pointer-events:none;
      animation: floaty 12s ease-in-out infinite;
      z-index:0;
    }
    @keyframes floaty{
      0%{transform:translateY(0) rotate(0deg)}
      50%{transform:translateY(-12px) rotate(2deg)}
      100%{transform:translateY(0) rotate(0deg)}
    }

    .wrap{
      position:relative; z-index:1; width:min(920px,94%);
      padding:36px; border-radius:16px;
      background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
      box-shadow: 0 8px 30px rgba(2,6,23,0.7);
      backdrop-filter: blur(8px);
    }
    header{display:flex;align-items:center;gap:16px;margin-bottom:18px}
    header h1{font-size:20px;margin:0}
    header p{color:var(--muted);margin:0;font-size:13px}

    .grid{
      display:grid;grid-template-columns:1fr 1fr;gap:18px;align-items:stretch;
    }

    /* role card */
    .role-card{
      position:relative; padding:20px;border-radius:12px;cursor:pointer;
      background: linear-gradient(180deg, rgba(255,255,255,0.015), rgba(255,255,255,0.01));
      border:1px solid rgba(255,255,255,0.04);
      transition:transform .28s cubic-bezier(.2,.9,.2,1), box-shadow .28s, border-color .28s;
      display:flex;flex-direction:column;gap:12px;min-height:160px;
      outline: none;
    }
    .role-card:focus{box-shadow:0 8px 30px rgba(7,12,32,0.6);transform:translateY(-6px)}
    .role-card:hover{transform:translateY(-8px);box-shadow:0 18px 40px rgba(2,6,23,0.6);border-color: rgba(255,255,255,0.08)}

    .role-icon{width:56px;height:56px;border-radius:12px;display:grid;place-items:center;font-size:22px}
    .student .role-icon{background:linear-gradient(135deg,var(--accent2), rgba(6,182,212,0.15));color:#024b53}
    .mentor .role-icon{background:linear-gradient(135deg,var(--accent1), rgba(124,58,237,0.12));color:#3c0d6d}

    .role-title{font-weight:600;font-size:18px}
    .role-desc{color:var(--muted);font-size:13px;flex:1}

    /* hidden radio (for accessibility & state) */
    input[type=radio]{position:absolute;left:-9999px}

    /* selected state using sibling selector */
    input[type=radio]:checked + label{border:1px solid rgba(255,255,255,0.14);transform:translateY(-10px);box-shadow:0 24px 60px rgba(2,6,23,0.65)}
    input[type=radio]:checked + label .badge{opacity:1;transform:translateY(0)}

    .badge{
      position:absolute;right:12px;top:12px;background:linear-gradient(90deg,var(--accent1),var(--accent2));
      padding:6px 10px;border-radius:999px;font-size:12px;font-weight:600;color:#021018;
      box-shadow:0 6px 18px rgba(11,22,40,0.6);opacity:0;transform:translateY(-6px);transition:all .28s;
    }

    /* small micro-animations */
    .sparkle{
      position:absolute;left:-30px;bottom:-30px;width:120px;height:120px;border-radius:50%;opacity:.06;filter:blur(18px);
      background:conic-gradient(from 90deg, rgba(124,58,237,0.35), rgba(6,182,212,0.35));transform:scale(.9);
      animation: pulse 3.6s ease-in-out infinite;
    }
    @keyframes pulse{0%{transform:scale(.9);opacity:.06}50%{transform:scale(1.06);opacity:.12}100%{transform:scale(.9);opacity:.06}}

    .controls{display:flex;gap:12px;align-items:center;justify-content:flex-end;margin-top:18px}
    .btn{padding:10px 14px;border-radius:10px;border:0;font-weight:600;cursor:pointer}
    .btn-primary{background:linear-gradient(90deg,var(--accent1),var(--accent2));color:#021018}
    .btn-ghost{background:transparent;color:var(--muted);border:1px solid rgba(255,255,255,0.04)}

    .selected-line{margin-top:12px;color:var(--muted);font-size:13px}

    /* responsive */
    @media (max-width:720px){
      .grid{grid-template-columns:1fr}
    }
  </style>
  <!-- HTML CODE -->
</head>
<body>
  <div class="bg-animated" aria-hidden="true"></div>

  <main class="wrap" role="main">
    <header>
      <div style="width:56px;height:56px;border-radius:12px;background:linear-gradient(135deg,rgba(255,255,255,0.03),rgba(255,255,255,0.01));display:grid;place-items:center;font-weight:700">R</div>
      <div>
        <h1>Choose your role</h1>
        <p>Select whether you're a <strong>Student</strong> or a <strong>Mentor</strong> to continue.</p>
      </div>
    </header>

    <form id="roleForm" action="${pageContext.request.contextPath}/RoleServlet" method="post">
      <div class="grid">
        <div style="position:relative">
          <input type="radio" id="student" value="student" checked>
          <label for="student" class="role-card student" tabindex="0">
            <div class="badge">Selected</div>
            <div class="role-icon">🎓</div>
            <div class="role-title">Student</div>
            <div class="role-desc">Explore career options, find scholarships, check exam details, and discover top colleges.</div>
            <div class="sparkle" aria-hidden="true"></div>
          </label>
        </div>

        <div style="position:relative">
          <input type="radio" id="mentor" value="mentor">
          <label for="mentor" class="role-card mentor" tabindex="0">
            <div class="badge">Selected</div>
            <div class="role-icon">🧑‍🏫</div>
            <div class="role-title">Mentor</div>
            <div class="role-desc">Chat with students and guide them according to their skills and learning needs.</div>
            <div class="sparkle" aria-hidden="true"></div>
          </label>
        </div>
      </div>

      <div class="controls">
        <input type="hidden" id="selectedRole" name="role" value="student">
        <button type="button" class="btn btn-ghost" id="clearBtn">Clear</button>
        <button type="submit" class="btn btn-primary">Continue</button>
      </div>

      <div id="selectedText" class="selected-line">Current: <strong>Student</strong></div>
    </form>
  </main>
 <!-- JS CODE -->
  <script>
  const form = document.getElementById('roleForm');
  const selectedText = document.getElementById('selectedText');
  const selectedRole = document.getElementById('selectedRole');

  function selectRole(role) {
    selectedRole.value = role;
    document.getElementById(role).checked = true;
    updateSelectedText();
  }

  function updateSelectedText() {
    const role = selectedRole.value;
    if (!role) {
      selectedText.innerHTML = 'Current: <strong>-</strong>';
      return;
    }
    selectedText.innerHTML = `Current: <strong>${role.charAt(0).toUpperCase() + role.slice(1)}</strong>`;
  }

  document.querySelectorAll('.role-card').forEach(card => {
    card.addEventListener('keydown', e => {
      if (e.key === ' ' || e.key === 'Enter') {
        e.preventDefault();
        selectRole(card.previousElementSibling.value);
      }
    });
    card.addEventListener('click', () => {
      selectRole(card.previousElementSibling.value);
    });
  });

  form.addEventListener('submit', e => {
    if (!selectedRole.value) {
      e.preventDefault();
      selectedText.innerHTML = 'Please select Student or Mentor.';
    }
  });

  document.getElementById('clearBtn').addEventListener('click', () => {
    document.querySelectorAll('input[type="radio"]').forEach(input => input.checked = false);
    selectedRole.value = '';
    updateSelectedText();
  });

  updateSelectedText();
</script>

</body>
</html>
