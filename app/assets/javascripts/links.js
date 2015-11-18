$(document).ready(function() {
  // listenForMarkRead();
  // updateLink();
  searchLinks();
  filterStatus("all");
  filterStatus("true");
  filterStatus("false");
  sortAlphabetically();
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

function sortAlphabetically() {
  $('.sort-links').click(function(e) {
    var $sort = this;
    var $links = $('#links-list');
    var $link = $('li',$links);

    $link.sort(function(a, b) {
      var keyA = $(a).find('h3').text();
      var keyB = $(b).find('h3').text();
      if($($sort).hasClass('asc')) {
          return (keyA > keyB) ? 1 : 0;
      } else {
          return (keyA < keyB) ? 1 : 0;
      }
    });
    $.each($link, function(index, element) {
      $links.append(element);
    })
    e.preventDefault();
  });
}
