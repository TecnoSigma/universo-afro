$(document).ready(function() {
        enableAccordion("company-vacant-jobs-accordion");
});

function enableAccordion(accordionClass) {
        let accordion = document.getElementsByClassName(accordionClass);
        let length;

        for (length = 0; length < accordion.length; length++) {
                accordion[length].addEventListener("click", function() {
                        this.classList.toggle("active-accordion");

                        let panel = this.nextElementSibling;

                        panel.style.maxHeight = (panel.style.maxHeight ? null : panel.scrollHeight + "px");
                });
        }
}
