$(document).ready(function() {
  searchLinks();
});

function searchLinks() {
  $('#search').keyup(function() {
    var searchTerm = $('#search').val().toLowerCase();

    $('.link').each(function(index, link) {
      var title = $(link).find('h3').text().toLowerCase();
      var url = $(link).find('h4').text().toLowerCase();
      var isMatching = (title + link).indexOf(searchTerm) !== -1;
      $(link).toggle(isMatching);
    });
  });
}
