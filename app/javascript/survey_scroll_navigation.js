// When the user scrolls down 20px from the top of the document, show the button
function scrollFunction() {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;

    document.getElementById("btn-back-to-top").style.display = scrollTop > 20 ? "block" : "none";
}

function backToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
}

function jumpToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({ behavior: "smooth" });
    }
}

function addClickListener(elementId, callback) {
    const element = document.getElementById(elementId);
    if (element) {
        element.addEventListener("click", callback);
    }
}

function setupListeners() {
    window.addEventListener("scroll", scrollFunction);
    addClickListener("btn-back-to-top", backToTop);
    addClickListener("btn-jump-to-tms", () => jumpToSection("tms"));
    addClickListener("btn-jump-to-cs", () => jumpToSection("cs"));
    addClickListener("btn-jump-to-tmr", () => jumpToSection("tmr"));
    addClickListener("btn-jump-to-sqq", () => jumpToSection("sqq"));
    addClickListener("btn-jump-to-cqq", () => jumpToSection("cqq"));
}

document.addEventListener("DOMContentLoaded", setupListeners);
