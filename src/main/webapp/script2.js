document.addEventListener("DOMContentLoaded", () => {
    const cards = document.querySelectorAll(".card");
    const engineeringInfoPanel = document.getElementById("engineeringInfoPanel");
    const engineeringDetails = {
      cse: {
        title: "Computer Science Engineering",
        summary: "Computer Science Engineering focuses on programming, software development, artificial intelligence, data science, cybersecurity, and modern digital systems.",
        bestFor: ["Students who enjoy coding and logical thinking.", "Students interested in apps, websites, AI, and data."],
        careers: ["Software Engineer", "Data Analyst", "Cybersecurity Analyst"],
        skills: ["Programming", "Problem solving", "Database and web basics"],
        roadmap: ["Learn one programming language well.", "Build small web or app projects.", "Practice data structures and problem solving.", "Try internships, hackathons, or open-source work."],
        meters: [{ name: "Coding", value: 90 }, { name: "Math and logic", value: 78 }, { name: "Project building", value: 84 }]
      },
      mechanical: {
        title: "Mechanical Engineering",
        summary: "Mechanical Engineering deals with machines, engines, manufacturing, robotics, product design, thermal systems, and industrial processes.",
        bestFor: ["Students who like machines and practical design.", "Students interested in automobiles, manufacturing, and robotics."],
        careers: ["Mechanical Design Engineer", "Production Engineer", "Automobile Engineer"],
        skills: ["Mechanics", "CAD design", "Thermodynamics basics"],
        roadmap: ["Strengthen mechanics and physics basics.", "Learn CAD tools and technical drawing.", "Work on mini models or machine projects.", "Explore manufacturing, robotics, or automobile internships."],
        meters: [{ name: "Mechanics", value: 88 }, { name: "Design thinking", value: 80 }, { name: "Workshop practice", value: 76 }]
      },
      civil: {
        title: "Civil Engineering",
        summary: "Civil Engineering focuses on infrastructure such as buildings, roads, bridges, dams, transportation systems, and smart city planning.",
        bestFor: ["Students interested in construction and public infrastructure.", "Students who enjoy planning, drawing, and field work."],
        careers: ["Site Engineer", "Structural Engineer", "Town Planner"],
        skills: ["Surveying", "Structural basics", "Project management"],
        roadmap: ["Learn drawing, surveying, and construction basics.", "Understand materials and structural concepts.", "Visit construction sites when possible.", "Practice planning, estimation, and project tracking."],
        meters: [{ name: "Structural concepts", value: 84 }, { name: "Field work", value: 86 }, { name: "Planning", value: 78 }]
      },
      electrical: {
        title: "Electrical Engineering",
        summary: "Electrical Engineering covers power generation, circuits, machines, renewable energy, control systems, and electrical safety.",
        bestFor: ["Students who enjoy circuits and power systems.", "Students interested in energy, automation, and electrical machines."],
        careers: ["Electrical Engineer", "Power Systems Engineer", "Control Engineer"],
        skills: ["Circuit theory", "Power systems", "Electrical safety"],
        roadmap: ["Master circuit theory and electrical machines.", "Practice lab safety and measurements.", "Explore renewable energy and automation.", "Build simple circuit or control projects."],
        meters: [{ name: "Circuit theory", value: 88 }, { name: "Power systems", value: 82 }, { name: "Safety discipline", value: 92 }]
      },
      ece: {
        title: "Electronics and Communication Engineering",
        summary: "Electronics and Communication Engineering works with communication networks, embedded systems, IoT, VLSI, signal processing, and devices.",
        bestFor: ["Students interested in hardware and communication.", "Students who like electronics, sensors, and connected devices."],
        careers: ["Embedded Engineer", "Network Engineer", "VLSI Engineer"],
        skills: ["Electronics basics", "Communication systems", "Embedded programming"],
        roadmap: ["Learn electronics components and circuit design.", "Practice microcontroller or Arduino projects.", "Study signals, networks, and communication basics.", "Explore IoT, VLSI, or embedded systems projects."],
        meters: [{ name: "Electronics", value: 86 }, { name: "Communication", value: 80 }, { name: "Embedded systems", value: 78 }]
      },
      it: {
        title: "Information Technology",
        summary: "Information Technology focuses on software systems, networks, databases, cloud services, cybersecurity, and business technology support.",
        bestFor: ["Students who want practical technology careers.", "Students interested in networks, systems, and digital services."],
        careers: ["IT Engineer", "Cloud Support Engineer", "Network Administrator"],
        skills: ["Networking", "Cloud basics", "System administration"],
        roadmap: ["Learn computer networks and operating systems.", "Practice database and web fundamentals.", "Explore cloud tools and cybersecurity basics.", "Build IT support, network, or deployment projects."],
        meters: [{ name: "Networking", value: 86 }, { name: "Cloud basics", value: 75 }, { name: "Troubleshooting", value: 88 }]
      }
    };

    function listItems(items) {
      return items.map(item => `<li>${item}</li>`).join("");
    }

    function renderEngineeringDetails(field) {
      const details = engineeringDetails[field];

      engineeringInfoPanel.innerHTML = `
        <span>Selected Engineering Field</span>
        <h3>${details.title}</h3>
        <p>${details.summary}</p>
        <div class="engineering-tabs" role="tablist">
          <button class="engineering-tab active" type="button" data-tab="overview" onclick="switchEngineeringTab('overview', this)">Overview</button>
          <button class="engineering-tab" type="button" data-tab="roadmap" onclick="switchEngineeringTab('roadmap', this)">Roadmap</button>
          <button class="engineering-tab" type="button" data-tab="careers" onclick="switchEngineeringTab('careers', this)">Careers</button>
          <button class="engineering-tab" type="button" data-tab="skills" onclick="switchEngineeringTab('skills', this)">Skills</button>
        </div>
        <div class="engineering-tab-panel active" data-panel="overview">
          <div class="engineering-info-grid">
            <div>
              <h4>Best For</h4>
              <ul>${listItems(details.bestFor)}</ul>
            </div>
            <div>
              <h4>First Step</h4>
              <ul><li>${details.roadmap[0]}</li><li>${details.roadmap[1]}</li></ul>
            </div>
          </div>
        </div>
        <div class="engineering-tab-panel" data-panel="roadmap">
          <div class="engineering-checklist">
            ${details.roadmap.map(step => `<label><input type="checkbox"> ${step}</label>`).join("")}
          </div>
        </div>
        <div class="engineering-tab-panel" data-panel="careers">
          <div class="engineering-info-grid">
            ${details.careers.map(career => `<div><h4>${career}</h4><p>Build the right academic base, projects, and internships to move toward this role.</p></div>`).join("")}
          </div>
        </div>
        <div class="engineering-tab-panel" data-panel="skills">
          ${details.meters.map(meter => `
            <div class="engineering-meter">
              <header><strong>${meter.name}</strong><small>${meter.value}% focus</small></header>
              <div class="meter-track"><span style="width:${meter.value}%"></span></div>
            </div>
          `).join("")}
          <div class="engineering-info-grid">
            <div>
              <h4>Skills To Build</h4>
              <ul>${listItems(details.skills)}</ul>
            </div>
          </div>
        </div>
        <div class="engineering-action-row">
          <a href="exam-details.jsp">Open Resources</a>
          <a href="mentorlist.jsp">Find Mentor</a>
          <button type="button" class="copy-field-btn" data-title="${details.title}">Copy Field Name</button>
        </div>
      `;

      engineeringInfoPanel.classList.add("active");
      engineeringInfoPanel.scrollIntoView({ behavior: "smooth", block: "center" });
    }
  
    cards.forEach(card => {
      card.addEventListener("mouseenter", () => {
        card.style.backgroundColor = "#f0f8ff"; // Light blue background on hover
      });
  
      card.addEventListener("mouseleave", () => {
        card.style.backgroundColor = "white"; // Reset to white
      });
    });

    document.querySelectorAll(".engineering-detail-btn").forEach(button => {
      button.addEventListener("click", () => {
        renderEngineeringDetails(button.dataset.field);
      });
    });

    engineeringInfoPanel.addEventListener("click", event => {
      if (event.target.classList.contains("engineering-tab")) {
        switchEngineeringTab(event.target.dataset.tab, event.target);
      }

      if (event.target.classList.contains("copy-field-btn")) {
        const fieldName = event.target.dataset.title;

        if (navigator.clipboard) {
          navigator.clipboard.writeText(fieldName);
        }

        event.target.textContent = "Copied!";
        setTimeout(() => {
          event.target.textContent = "Copy Field Name";
        }, 1200);
      }
    });
  });

function switchEngineeringTab(targetTab, clickedButton) {
  const engineeringInfoPanel = document.getElementById("engineeringInfoPanel");

  if (!engineeringInfoPanel) {
    return;
  }

  engineeringInfoPanel.querySelectorAll(".engineering-tab").forEach(tab => {
    tab.classList.toggle("active", tab === clickedButton);
  });

  engineeringInfoPanel.querySelectorAll(".engineering-tab-panel").forEach(panel => {
    panel.classList.toggle("active", panel.dataset.panel === targetTab);
  });
}
  
  ///TypeWrite logic
  const textArray = ["Engineering Career Path", "Explore Your Future Shape Your Dreams"];
  let typingDelay = 100;
  let erasingDelay = 50;
  let newTextDelay = 2000;
  let textArrayIndex = 0;
  let charIndex = 0;
  
  const typedText = document.getElementById("typewriter");
  
  function type() {
    if (charIndex < textArray[textArrayIndex].length) {
      typedText.textContent += textArray[textArrayIndex].charAt(charIndex);
      charIndex++;
      setTimeout(type, typingDelay);
    } else {
      setTimeout(erase, newTextDelay);
    }
  }
  
  function erase() {
    if (charIndex > 0) {
      typedText.textContent = textArray[textArrayIndex].substring(0, charIndex - 1);
      charIndex--;
      setTimeout(erase, erasingDelay);
    } else {
      textArrayIndex++;
      if (textArrayIndex >= textArray.length) textArrayIndex = 0;
      setTimeout(type, typingDelay);
    }
  }
  
  document.addEventListener("DOMContentLoaded", function() {
    if (typedText && textArray.length) {
      typedText.textContent = ""; // important: clear existing text
      setTimeout(type, newTextDelay);
    }
  });
  
// Search button logic
function searchFunction() {
  var input = document.getElementById("searchInput").value.toLowerCase().trim();

  if (input === "uttaranchal university") {
    window.open("https://www.uttaranchaluniversity.ac.in/", "_blank");
  } else if (input === "dit university" || input === "dit") {
    window.open("https://www.dituniversity.edu.in/", "_blank");
  } else if (input === "graphic era university" || input === "graphic era") {
    window.open("https://geu.ac.in/", "_blank");
  } else if (input === "upes dehradun" || input === "upes") {
    window.open("https://www.upes.ac.in/", "_blank");
  } else if (input === "ims unison university" || input === "ims") {
    window.open("https://www.iuu.ac/", "_blank");
  } else if (input === "swami rama himalayan university" || input === "himalayan university") {
    window.open("https://srhu.edu.in/", "_blank");
  } else if (input === "himgiri zee university" || input === "himgiri university") {
    window.open("https://www.hzu.edu.in/", "_blank");
  } else if (input === "doon university") {
    window.open("https://doonuniversity.ac.in/", "_blank");
  } else if (input === "uttarakhand technical university" || input === "utu") {
    window.open("https://www.uktech.ac.in/", "_blank");
  } else if (input === "dev bhoomi uttarakhand university" || input === "dbuu") {
    window.open("https://www.dbuu.ac.in/", "_blank");
  } else {
    alert("No matching university or college found. Please check your spelling!");
  }
}
// Navbar logic
function searchNavbar() {
  var input = document.getElementById("searchInput").value.toLowerCase().trim();

  if (input.includes("home")) {
    window.location.href = "#";
  } else if (input.includes("career exploration")) {
    window.location.href = "#";
  } else if (input.includes("crack exam")) {
    window.location.href = "#";
  } else if (input.includes("mentorship") || input.includes("1:1 mentorship")) {
    window.location.href = "#";
  } else {
    alert("No match found. Please try Home, Career Exploration, Crack Exam, or 1:1 Mentorship.");
  }
}

function showScholarship() {
  // Open the scholarship page in a new tab
  window.open("scholarship.jsp", "_blank"); // Replace with your scholarship details page
}

function stayHere() {
  alert("Okay! Feel free to explore other sections.");
}
