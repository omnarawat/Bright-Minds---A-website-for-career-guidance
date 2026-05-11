const feedbackForm = document.getElementById("feedback-form");
const feedbackTextarea = document.getElementById("feedback");
const feedbackCount = document.getElementById("feedback-count");
const messageBox = document.getElementById("message");
const submitButton = document.getElementById("submitFeedbackBtn");

function showMessage(text, type) {
    messageBox.textContent = text;
    messageBox.className = `message ${type}`;
}

function updateFeedbackCount() {
    feedbackCount.textContent = `${feedbackTextarea.value.length} / 1000 characters`;
}

function getTrimmedValue(id) {
    return document.getElementById(id).value.trim();
}

function getFeedbackPayload() {
    return {
        name: getTrimmedValue("name"),
        email: getTrimmedValue("email"),
        feedback: getTrimmedValue("feedback")
    };
}

function validateFields() {
    const payload = getFeedbackPayload();

    if (!payload.name) {
        showMessage("Please enter your name.", "error");
        document.getElementById("name").focus();
        return false;
    }

    if (!payload.email) {
        showMessage("Please enter your email.", "error");
        document.getElementById("email").focus();
        return false;
    }

    if (!payload.feedback) {
        showMessage("Please write your feedback message.", "error");
        feedbackTextarea.focus();
        return false;
    }

    return true;
}

feedbackTextarea.addEventListener("input", updateFeedbackCount);
updateFeedbackCount();

feedbackForm.addEventListener("submit", function(event) {
    event.preventDefault();

    if (!feedbackForm.checkValidity()) {
        feedbackForm.reportValidity();
        return;
    }

    if (!validateFields()) {
        return;
    }

    submitButton.disabled = true;
    submitButton.textContent = "Saving...";
    showMessage("Saving your feedback...", "success");
    const payload = getFeedbackPayload();
    const requestBody = new URLSearchParams();
    requestBody.append("name", payload.name);
    requestBody.append("email", payload.email);
    requestBody.append("feedback", payload.feedback);

    fetch(feedbackForm.action, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        },
        body: requestBody.toString()
    })
        .then(function(response) {
            const contentType = response.headers.get("content-type") || "";

            if (!contentType.includes("application/json")) {
                throw new Error("Feedback servlet is not available yet. Restart or republish the Tomcat server, then try again.");
            }

            return response.json().then(function(data) {
                if (!response.ok || !data.success) {
                    throw new Error(data.message || "Could not save feedback.");
                }
                return data;
            });
        })
        .then(function(data) {
            showMessage(data.message, "success");
            feedbackForm.reset();
            updateFeedbackCount();
        })
        .catch(function(error) {
            showMessage(error.message, "error");
        })
        .finally(function() {
            submitButton.disabled = false;
            submitButton.textContent = "Submit Feedback";
        });
});
