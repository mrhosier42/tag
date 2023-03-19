$(document).ready(function() {
    // Smooth scrolling for jump buttons
    function smoothScrollTo(target) {
        $('html, body').animate({
            scrollTop: target.offset().top
        }, 1);
    }

    $('#btn-jump-to-tms').on('click', function() {
        smoothScrollTo($('#team-member-scores'));
    });

    $('#btn-jump-to-cs').on('click', function() {
        smoothScrollTo($('#client-scores'));
    });

    $('#btn-jump-to-tmr').on('click', function() {
        smoothScrollTo($('#team-member-responses'));
    });

    $('#btn-jump-to-sqq').on('click', function() {
        smoothScrollTo($('#student-qualitative-questions'));
    });

    $('#btn-jump-to-cqq').on('click', function() {
        smoothScrollTo($('#client-qualitative-questions'));
    });
});
