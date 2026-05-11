document.addEventListener('DOMContentLoaded', function() {
  const takeTestBtn = document.getElementById('takeTestBtn');
  const testForm = document.getElementById('testForm');
  const questionsContainer = document.getElementById('questionsContainer');
  const resultBox = document.getElementById('resultBox');
  const viewCareerBtn = document.getElementById('viewCareerBtn');
  const progressText = document.getElementById('progressText');
  const progressBar = document.getElementById('progressBar');

  const questions = [
    {
      text: 'Which activity do you enjoy the most?',
      options: [
        { label: 'Solving maths, machines, or technical problems', field: 'engineering' },
        { label: 'Helping sick people and learning about the human body', field: 'medical' },
        { label: 'Managing money, business, or accounts', field: 'commerce' },
        { label: 'Drawing, writing, music, design, or creative work', field: 'arts' }
      ]
    },
    {
      text: 'Which school subject feels most interesting to you?',
      options: [
        { label: 'Physics or Mathematics', field: 'engineering' },
        { label: 'Biology', field: 'medical' },
        { label: 'Economics or Business Studies', field: 'commerce' },
        { label: 'Political Science, History, or English', field: 'law' }
      ]
    },
    {
      text: 'What kind of work environment would suit you?',
      options: [
        { label: 'Technology lab, workshop, or software office', field: 'engineering' },
        { label: 'Hospital, clinic, or healthcare center', field: 'medical' },
        { label: 'Corporate office, bank, or startup', field: 'commerce' },
        { label: 'Studio, media room, or creative agency', field: 'arts' }
      ]
    },
    {
      text: 'What type of problem do you like to solve?',
      options: [
        { label: 'Building useful products or systems', field: 'engineering' },
        { label: 'Improving health and well-being', field: 'medical' },
        { label: 'Planning budgets, sales, or business growth', field: 'commerce' },
        { label: 'Helping people learn, communicate, or improve society', field: 'social' }
      ]
    },
    {
      text: 'Which strength describes you best?',
      options: [
        { label: 'Logical and analytical', field: 'engineering' },
        { label: 'Caring and patient', field: 'medical' },
        { label: 'Confident with leadership and numbers', field: 'commerce' },
        { label: 'Expressive and imaginative', field: 'arts' }
      ]
    },
    {
      text: 'Which future role sounds most exciting?',
      options: [
        { label: 'Software engineer, civil engineer, or architect', field: 'engineering' },
        { label: 'Doctor, nurse, pharmacist, or physiotherapist', field: 'medical' },
        { label: 'Chartered accountant, manager, or entrepreneur', field: 'commerce' },
        { label: 'Lawyer, civil servant, journalist, or policy analyst', field: 'law' }
      ]
    },
    {
      text: 'How do you prefer to work?',
      options: [
        { label: 'With tools, code, data, or experiments', field: 'engineering' },
        { label: 'With patients, care plans, or health awareness', field: 'medical' },
        { label: 'With targets, clients, markets, or finance', field: 'commerce' },
        { label: 'With students, communities, or public service', field: 'social' }
      ]
    },
    {
      text: 'What would you like your career to be known for?',
      options: [
        { label: 'Innovation and practical solutions', field: 'engineering' },
        { label: 'Saving lives and supporting health', field: 'medical' },
        { label: 'Business success and financial planning', field: 'commerce' },
        { label: 'Creativity, communication, and social impact', field: 'arts' }
      ]
    }
  ];

  const fieldDetails = {
    engineering: {
      title: 'Engineering and Technology',
      summary: 'You show strong interest in logic, problem solving, building systems, and technical subjects.',
      courses: ['B.Tech / BE', 'BCA', 'BSc Computer Science', 'Diploma in Engineering'],
      careers: ['Software Engineer', 'Civil Engineer', 'Mechanical Engineer', 'Data Analyst']
    },
    medical: {
      title: 'Medical and Healthcare',
      summary: 'Your answers show care, patience, biology interest, and motivation to improve people\'s health.',
      courses: ['MBBS', 'BDS', 'B.Pharm', 'BSc Nursing', 'Physiotherapy'],
      careers: ['Doctor', 'Pharmacist', 'Nurse', 'Physiotherapist', 'Lab Technician']
    },
    commerce: {
      title: 'Commerce, Finance, and Management',
      summary: 'You seem suited for business thinking, finance, leadership, planning, and market-based careers.',
      courses: ['B.Com', 'BBA', 'CA Foundation', 'Economics Honours', 'MBA later'],
      careers: ['Chartered Accountant', 'Business Manager', 'Banker', 'Entrepreneur']
    },
    arts: {
      title: 'Arts, Design, and Media',
      summary: 'Your choices point toward creativity, expression, communication, and visual or written work.',
      courses: ['BA', 'BFA', 'Design Courses', 'Mass Communication', 'Animation'],
      careers: ['Designer', 'Writer', 'Journalist', 'Animator', 'Content Creator']
    },
    law: {
      title: 'Law, Civil Services, and Public Policy',
      summary: 'You show interest in society, reasoning, rules, leadership, and public-facing decisions.',
      courses: ['BA LLB', 'Political Science', 'Public Administration', 'History Honours'],
      careers: ['Lawyer', 'Civil Servant', 'Policy Analyst', 'Legal Advisor']
    },
    social: {
      title: 'Teaching, Psychology, and Social Work',
      summary: 'Your answers show people skills, empathy, communication, and interest in helping others grow.',
      courses: ['BA Psychology', 'B.Ed later', 'Social Work', 'Sociology', 'Counselling Courses'],
      careers: ['Teacher', 'Counsellor', 'Social Worker', 'HR Specialist']
    }
  };

  function renderQuestions() {
    questionsContainer.innerHTML = questions.map(function(question, questionIndex) {
      const options = question.options.map(function(option, optionIndex) {
        const inputId = `question-${questionIndex}-option-${optionIndex}`;

        return `
          <label class="option-card" for="${inputId}">
            <input id="${inputId}" type="radio" name="question-${questionIndex}" value="${option.field}" required>
            <span>${option.label}</span>
          </label>
        `;
      }).join('');

      return `
        <fieldset class="question-card">
          <legend>${questionIndex + 1}. ${question.text}</legend>
          <div class="options-grid">${options}</div>
        </fieldset>
      `;
    }).join('');
  }

  function updateProgress() {
    const answeredCount = new FormData(testForm).values();
    const totalAnswered = Array.from(answeredCount).length;
    const progressPercent = Math.round((totalAnswered / questions.length) * 100);

    progressText.textContent = `${totalAnswered} of ${questions.length} answered`;
    progressBar.style.width = `${progressPercent}%`;
  }

  function calculateScores(formData) {
    const scores = Object.keys(fieldDetails).reduce(function(total, field) {
      total[field] = 0;
      return total;
    }, {});

    for (const value of formData.values()) {
      scores[value] += 1;
    }

    return scores;
  }

  function getTopFields(scores) {
    return Object.keys(scores)
      .sort(function(firstField, secondField) {
        return scores[secondField] - scores[firstField];
      })
      .filter(function(field) {
        return scores[field] > 0;
      });
  }

  function renderResult(scores) {
    const topFields = getTopFields(scores);
    const bestField = topFields[0];
    const secondaryField = topFields[1];
    const bestDetails = fieldDetails[bestField];
    const secondaryDetails = secondaryField ? fieldDetails[secondaryField] : null;

    const result = {
      bestField,
      secondaryField,
      scores,
      title: bestDetails.title,
      summary: bestDetails.summary,
      courses: bestDetails.courses,
      careers: bestDetails.careers
    };

    sessionStorage.setItem('testTaken', 'true');
    sessionStorage.setItem('psychometricResult', JSON.stringify(result));

    const scoreRows = topFields.map(function(field) {
      const percent = Math.round((scores[field] / questions.length) * 100);
      return `
        <div class="score-row">
          <header>
            <span>${fieldDetails[field].title}</span>
            <small>${scores[field]} answer${scores[field] === 1 ? '' : 's'} match</small>
          </header>
          <div class="score-meter"><span style="width: ${percent}%"></span></div>
        </div>
      `;
    }).join('');

    resultBox.innerHTML = `
      <div class="result-summary">
        <h2>Your Suggested Field: ${bestDetails.title}</h2>
        <p>${bestDetails.summary}</p>
      </div>
      ${secondaryDetails ? `<p class="secondary-match">Second match: ${secondaryDetails.title}</p>` : ''}
      <div class="score-board">${scoreRows}</div>
      <div class="result-tabs" role="tablist" aria-label="Result details">
        <button class="result-tab active" type="button" data-panel="coursesPanel">Courses</button>
        <button class="result-tab" type="button" data-panel="careersPanel">Careers</button>
        <button class="result-tab" type="button" data-panel="stepsPanel">Next Steps</button>
      </div>
      <section id="coursesPanel" class="result-panel active">
        <h3>Courses You Can Take</h3>
        <ul>${bestDetails.courses.map(function(course) { return `<li>${course}</li>`; }).join('')}</ul>
      </section>
      <section id="careersPanel" class="result-panel">
        <h3>Future Career Options</h3>
        <ul>${bestDetails.careers.map(function(career) { return `<li>${career}</li>`; }).join('')}</ul>
      </section>
      <section id="stepsPanel" class="result-panel">
        <h3>Make Your Result Useful</h3>
        <div class="next-steps">
          <label><input type="checkbox"> Shortlist two courses from this result</label>
          <label><input type="checkbox"> Compare eligibility and entrance exams</label>
          <label><input type="checkbox"> Open the career path page for more suggestions</label>
        </div>
      </section>
    `;

    resultBox.classList.add('show');
    viewCareerBtn.classList.add('show');
    resultBox.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  renderQuestions();
  updateProgress();

  takeTestBtn.addEventListener('click', function() {
    testForm.classList.add('show');
    takeTestBtn.style.display = 'none';
    window.scrollTo({
      top: Math.max(testForm.getBoundingClientRect().top + window.pageYOffset - 18, 0),
      behavior: 'smooth'
    });
  });

  testForm.addEventListener('submit', function(event) {
    event.preventDefault();

    const formData = new FormData(testForm);

    if (Array.from(formData.values()).length < questions.length) {
      alert('Please answer all questions before calculating your result.');
      return;
    }

    renderResult(calculateScores(formData));
  });

  questionsContainer.addEventListener('change', updateProgress);

  resultBox.addEventListener('click', function(event) {
    if (!event.target.classList.contains('result-tab')) {
      return;
    }

    const panelId = event.target.dataset.panel;

    resultBox.querySelectorAll('.result-tab').forEach(function(tab) {
      tab.classList.toggle('active', tab === event.target);
    });

    resultBox.querySelectorAll('.result-panel').forEach(function(panel) {
      panel.classList.toggle('active', panel.id === panelId);
    });
  });

  viewCareerBtn.addEventListener('click', function() {
    if (sessionStorage.getItem('testTaken') === 'true') {
      window.location.href = 'suggestion.jsp';
    } else {
      alert('Please complete the psychometric test first.');
    }
  });
});
