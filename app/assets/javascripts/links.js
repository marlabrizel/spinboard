$(document).ready(function() {
  searchLinks();
  filterStatus("all");
  filterStatus("true");
  filterStatus("false");
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

function filterStatus(name) {
  $('#' + name + '-filter').click(function() {
    $('.link').each(function(index, link) {
      var $link = $(link);
      if($link.hasClass(name)) {
        $link.show();
      } else {
        $link.hide();
      }
    })
  });
}
