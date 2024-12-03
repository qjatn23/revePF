document.getElementById('reviewTab').addEventListener('click', function() {
    document.getElementById('contentFrame').src = 'review_page.html'; // replace with actual URL
});

document.getElementById('qaTab').addEventListener('click', function() {
    document.getElementById('contentFrame').src = '/qna/list.do'; // replace with actual URL
});

document.getElementById('returnTab').addEventListener('click', function() {
    document.getElementById('contentFrame').src = 'return_delivery_page.html'; // replace with actual URL
});


function setActiveTab(tabId, iframeSrc) {
    // Remove 'active' class from all tabs
    document.querySelectorAll('.tab').forEach(tab => {
        tab.classList.remove('active');
    });

    // Add 'active' class to the clicked tab
    document.getElementById(tabId).classList.add('active');

    // Update iframe source
    document.getElementById('contentFrame').src = '/qna/list.do';
}