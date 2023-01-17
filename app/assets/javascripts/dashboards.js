$(document).ready(function() {
        enableAccordion("company-vacant-jobs-accordion");

        $('#conference_date').mask('00/00/0000', { plaeholder: '__/__/____'});
        $('#conference_horary').mask('00:00', { plaeholder: '__:__'});
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
