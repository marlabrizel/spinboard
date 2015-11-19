$(document).ready(function() {
  listenForRead();
  listenForUnread();
  searchLinks();
  filterStatus("all");
  filterStatus("read");
  filterStatus("unread");
  sortAlphabetically();
});

function listenForRead() {
  $('.mark-read').click(function(e) {
    e.preventDefault();
    var link = $(e.target).closest('.link')
    updateLink(link, true);
    link.addClass('read')
    link.removeClass('unread')
  });
}

function listenForUnread() {
  $('.mark-unread').click(function(e) {
    e.preventDefault();
    var link = $(e.target).closest('.link')
    updateLink(link, false);
    link.addClass('unread')
    link.removeClass('read')
  });
}

function updateLink(link, status) {
  $.ajax({
    type: "PUT",
    dataType: "json",
    url: "/api/v1/links/" + link.attr('data-id') + ".json",
    data: { link: { read_status: status } },
    error: function() {
      alert("Something went wrong, please try again");
    }
  });
}

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
    var $link = $('.link',$links);

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
