document.addEventListener('DOMContentLoaded', function() {
  const careerCards = document.getElementById('careerCards');
  const detailPanel = document.getElementById('detailPanel');
  const savedResult = sessionStorage.getItem('psychometricResult');

  const infoLibrary = {
    'Engineering and Technology': {
      intro: 'This field focuses on solving practical problems using maths, science, design, computers, machines, and systems.',
      points: ['Build strong Physics, Mathematics, and logical reasoning basics.', 'Explore coding, electronics, design, or core engineering projects.', 'Check entrance exams, college branches, and internship opportunities.']
    },
    'Medical and Healthcare': {
      intro: 'This field is about improving health through diagnosis, treatment, care, research, medicine, and patient support.',
      points: ['Build Biology, Chemistry, and patient-care awareness.', 'Compare paths like MBBS, BDS, Nursing, Pharmacy, and Physiotherapy.', 'Understand entrance exams, eligibility, and long-term study commitment.']
    },
    'Commerce, Finance, and Management': {
      intro: 'This field suits students interested in business, accounting, finance, management, entrepreneurship, and markets.',
      points: ['Strengthen accounts, economics, business studies, and communication.', 'Explore CA, B.Com, BBA, banking, analytics, and startup paths.', 'Practice decision-making with case studies, budgets, and market examples.']
    },
    'Arts, Design, and Media': {
      intro: 'This field is for creative, communication-driven, visual, writing, media, and design-oriented careers.',
      points: ['Create a portfolio with writing, designs, videos, art, or campaigns.', 'Explore BA, BFA, design, journalism, animation, or mass communication.', 'Build presentation, storytelling, research, and software skills.']
    },
    'Law, Civil Services, and Public Policy': {
      intro: 'This field focuses on rules, justice, governance, public decisions, debate, and social systems.',
      points: ['Develop reading, reasoning, current affairs, and communication skills.', 'Explore BA LLB, Political Science, Public Administration, and History.', 'Practice debates, writing, mock tests, and policy case studies.']
    },
    'Teaching, Psychology, and Social Work': {
      intro: 'This field is about helping people learn, grow, solve personal challenges, and improve communities.',
      points: ['Build communication, empathy, patience, and observation skills.', 'Explore Psychology, Sociology, Education, Social Work, and Counselling.', 'Volunteer, mentor juniors, or join community projects to gain exposure.']
    },
    'B.Tech / BE': {
      intro: 'B.Tech or BE is a professional engineering degree for students who want technical careers.',
      points: ['Choose a branch such as CSE, Mechanical, Civil, ECE, Electrical, or IT.', 'Focus on entrance exams, projects, internships, and practical labs.', 'Good for engineering, software, product, and technical management careers.']
    },
    'BCA': {
      intro: 'BCA is a computer applications degree focused on programming, software, databases, and IT skills.',
      points: ['Learn programming languages, web development, databases, and problem solving.', 'Build small apps and projects while studying.', 'Can lead to software, IT support, testing, data, and MCA options.']
    },
    'BSc Computer Science': {
      intro: 'BSc Computer Science gives a strong base in computing concepts, programming, maths, and systems.',
      points: ['Study algorithms, data structures, databases, operating systems, and networks.', 'Create projects to show practical skill.', 'Useful for software, data, research, and higher studies.']
    },
    'Diploma in Engineering': {
      intro: 'A Diploma in Engineering is a practical technical course that can start after school.',
      points: ['It is skill-based and branch-specific.', 'You can work in technical roles or continue into degree engineering later.', 'Good for students who want hands-on technical learning.']
    },
    'MBBS': {
      intro: 'MBBS is the main degree for becoming a doctor.',
      points: ['It requires strong Biology and Chemistry preparation.', 'Admission usually depends on medical entrance exam performance.', 'The path is demanding but opens clinical and specialization careers.']
    },
    'BDS': {
      intro: 'BDS is the professional degree for dentistry.',
      points: ['It focuses on oral health, dental surgery, diagnosis, and patient care.', 'Requires medical entrance preparation and practical clinical training.', 'Can lead to dentist, specialist, clinic, or hospital roles.']
    },
    'B.Pharm': {
      intro: 'B.Pharm focuses on medicines, drug development, pharmacy practice, and healthcare products.',
      points: ['Study chemistry, biology, pharmacology, and drug safety.', 'Career options include pharmacist, pharma industry, research, and quality control.', 'Good for students interested in healthcare and medicines.']
    },
    'BSc Nursing': {
      intro: 'BSc Nursing prepares students for professional patient care and healthcare support.',
      points: ['You learn clinical care, health science, communication, and hospital practice.', 'It suits caring, patient, responsible students.', 'Career options include hospitals, clinics, public health, and higher nursing studies.']
    },
    'Physiotherapy': {
      intro: 'Physiotherapy focuses on movement, injury recovery, rehabilitation, and physical wellness.',
      points: ['Study anatomy, exercise therapy, rehabilitation, and patient assessment.', 'Work can happen in hospitals, sports centers, clinics, and rehab centers.', 'Good for students interested in healthcare and active recovery.']
    },
    'B.Com': {
      intro: 'B.Com builds a foundation in accounts, business, economics, taxation, and finance.',
      points: ['Useful for finance, banking, CA, accounting, and management paths.', 'Add skills like Excel, communication, taxation, and analytics.', 'Good for students who enjoy numbers and business systems.']
    },
    'BBA': {
      intro: 'BBA focuses on business administration, management, marketing, HR, finance, and entrepreneurship.',
      points: ['Good for leadership, business planning, and corporate careers.', 'Build presentation, teamwork, and problem-solving skills.', 'Can lead to MBA, management roles, startups, and business development.']
    },
    'CA Foundation': {
      intro: 'CA Foundation is the first level for the Chartered Accountancy path.',
      points: ['It needs discipline in accounting, law, economics, and quantitative aptitude.', 'The CA path is challenging and highly respected in finance.', 'Useful for audit, taxation, accounting, and corporate finance careers.']
    },
    'Economics Honours': {
      intro: 'Economics Honours studies markets, policies, data, finance, and decision-making.',
      points: ['Strong maths, statistics, and analytical thinking help a lot.', 'Career paths include research, analytics, finance, policy, and consulting.', 'Good preparation for masters, government exams, and business roles.']
    },
    'MBA later': {
      intro: 'MBA is usually done after graduation to build advanced management and business skills.',
      points: ['It can specialize in finance, marketing, HR, operations, analytics, or strategy.', 'Work experience and entrance exam preparation can improve opportunities.', 'Useful for leadership, management, consulting, and business roles.']
    },
    'BA': {
      intro: 'BA offers study in humanities, social sciences, languages, communication, and society.',
      points: ['Choose subjects that match your interest, such as English, Psychology, History, or Political Science.', 'Build writing, research, communication, and critical thinking.', 'Can lead to teaching, media, public service, law, and higher studies.']
    },
    'BFA': {
      intro: 'BFA is a fine arts degree for visual art, painting, sculpture, applied art, and creative practice.',
      points: ['Create a strong portfolio of original work.', 'Practice drawing, design basics, art history, and presentation.', 'Career options include artist, illustrator, designer, educator, and creative studio roles.']
    },
    'Design Courses': {
      intro: 'Design courses train students in visual problem-solving, user needs, products, spaces, or communication.',
      points: ['Build a portfolio and learn design software.', 'Explore graphic, UI/UX, fashion, product, interior, or animation design.', 'Good for creative students who also enjoy solving practical problems.']
    },
    'Mass Communication': {
      intro: 'Mass Communication focuses on journalism, media, advertising, public relations, and digital content.',
      points: ['Build writing, speaking, editing, research, and storytelling skills.', 'Create videos, articles, campaigns, or podcasts for a portfolio.', 'Career options include journalism, PR, content, advertising, and media production.']
    },
    'Animation': {
      intro: 'Animation combines art, storytelling, movement, software, and visual production.',
      points: ['Practice drawing, motion, character design, and animation tools.', 'Build a showreel with short animated clips.', 'Career options include animator, motion designer, game artist, and VFX roles.']
    },
    'BA LLB': {
      intro: 'BA LLB is an integrated law degree combining humanities and legal studies.',
      points: ['Develop reading, writing, reasoning, and debate skills.', 'Explore courts, corporate law, civil services, policy, and legal advisory work.', 'Internships and moot courts are important for growth.']
    },
    'Political Science': {
      intro: 'Political Science studies government, power, public policy, political ideas, and institutions.',
      points: ['Read current affairs and learn how public systems work.', 'Useful for civil services, policy, law, research, journalism, and teaching.', 'Build writing, analysis, and debating skills.']
    },
    'Public Administration': {
      intro: 'Public Administration focuses on government work, policy implementation, management, and public services.',
      points: ['Good for students interested in governance and civil services.', 'Study administration, policy, ethics, and public institutions.', 'Build analytical writing and current affairs knowledge.']
    },
    'History Honours': {
      intro: 'History Honours studies past societies, events, cultures, and change over time.',
      points: ['Develop research, reading, evidence analysis, and writing skills.', 'Useful for teaching, civil services, research, museums, journalism, and law.', 'Connect historical understanding with current society and politics.']
    },
    'BA Psychology': {
      intro: 'BA Psychology studies human behavior, emotions, thinking, personality, and mental health basics.',
      points: ['Good for students who observe people carefully and want to help others.', 'Can lead to counselling, HR, research, education, and higher psychology studies.', 'Professional counselling roles usually need further study and training.']
    },
    'B.Ed later': {
      intro: 'B.Ed is a teaching qualification usually done after graduation.',
      points: ['It prepares you for school teaching methods and classroom practice.', 'Choose your graduation subject carefully if you want to teach it later.', 'Good for students who enjoy explaining, mentoring, and guiding learners.']
    },
    'Social Work': {
      intro: 'Social Work focuses on helping communities, families, children, and vulnerable groups.',
      points: ['Build empathy, communication, fieldwork, and problem-solving skills.', 'Work can include NGOs, public health, education, welfare, and community programs.', 'Practical field exposure is very important.']
    },
    'Sociology': {
      intro: 'Sociology studies society, groups, culture, inequality, family, education, and social change.',
      points: ['Useful for research, social work, policy, HR, teaching, and civil services.', 'Build observation, reading, writing, and analysis skills.', 'Connect classroom topics with real social issues around you.']
    },
    'Counselling Courses': {
      intro: 'Counselling courses teach helping skills, listening, guidance methods, and mental wellness basics.',
      points: ['Start with basic certified courses, then pursue deeper degrees if serious.', 'Build patience, ethics, listening, and communication skills.', 'Professional counselling requires proper qualifications and supervised training.']
    }
  };

  const genericInfo = {
    course: ['Check eligibility, duration, fees, and entrance requirements.', 'Compare colleges and course subjects before choosing.', 'Talk to seniors, teachers, or mentors to understand real study load.'],
    career: ['Learn the required qualification and skills for this role.', 'Search for beginner projects, internships, or shadowing opportunities.', 'Check salary range, work environment, and growth path before deciding.'],
    field: ['Explore related courses, exams, and beginner projects.', 'Compare this result with your strongest subjects and interests.', 'Discuss the path with a mentor or teacher before finalizing.']
  };

  const fallbackSuggestions = [
    {
      title: 'Complete the Psychometric Test',
      description: 'Answer the questions first so this page can show career suggestions based on your interests.'
    }
  ];

  function getCardInfo(title, type, description) {
    if (infoLibrary[title]) {
      return infoLibrary[title];
    }

    const lowerType = type.toLowerCase();
    const key = lowerType.includes('course') ? 'course' : lowerType.includes('career') ? 'career' : 'field';

    return {
      intro: description,
      points: genericInfo[key]
    };
  }

  function showDetails(title, description, type) {
    const info = getCardInfo(title, type, description);

    detailPanel.innerHTML = `
      <span>${type}</span>
      <h2>${title}</h2>
      <p>${info.intro}</p>
      <ul>${info.points.map(function(point) { return `<li>${point}</li>`; }).join('')}</ul>
    `;

    detailPanel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  function createCard(title, description, type) {
    const card = document.createElement('div');
    card.className = 'card';
    card.setAttribute('role', 'button');
    card.setAttribute('tabindex', '0');
    card.innerHTML = `
      <h3>${title}</h3>
      <p>${description}</p>
      <small>${type}</small>
    `;

    function activateCard() {
      careerCards.querySelectorAll('.card').forEach(function(item) {
        item.classList.remove('active');
      });
      card.classList.add('active');
      showDetails(title, description, type);
    }

    card.addEventListener('click', activateCard);
    card.addEventListener('keydown', function(event) {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        activateCard();
      }
    });

    careerCards.appendChild(card);
  }

  if (savedResult) {
    const result = JSON.parse(savedResult);

    createCard(
      result.title,
      result.summary,
      'Best match'
    );

    result.courses.forEach(function(course) {
      createCard(course, 'Recommended course option for your selected interest pattern.', 'Course option');
    });

    result.careers.forEach(function(career) {
      createCard(career, 'Possible future career path after building the right skills and qualification.', 'Career path');
    });
  } else {
    fallbackSuggestions.forEach(function(career) {
      createCard(career.title, career.description, 'Action needed');
    });
  }

  document.getElementById('backButton').addEventListener('click', function() {
    window.location.href = 'career-exploration.jsp';
  });

  document.getElementById('retakeButton').addEventListener('click', function() {
    sessionStorage.removeItem('testTaken');
    sessionStorage.removeItem('psychometricResult');
    window.location.href = 'career-exploration.jsp';
  });
});
