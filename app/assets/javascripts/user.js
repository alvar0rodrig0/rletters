// ---------------------------------------------------------------------------
// AJAX list of library links from the libraries controller

function checkLibraryList() {
  var libraryList = $('div.ui-page-active').find('div.librarylist');
  
  // If there's a library list at all, we want to refresh its contents (e.g.,
  // after the user closes the "add new library" dialog box)
  if (libraryList.length == 0)
    return;
  
  var ajax_url = libraryList.attr('data-fetch-url');
  
  $.ajax({
    url: ajax_url,
    type: 'get',
    dataType: 'html',
    cache: false,
    success: function(data) {
      var libraryList = $('div.ui-page-active').find('div.librarylist')
      libraryList.html(data);
      libraryList.find('ul').listview();
    }
  });
}

$('div[data-role=page]').live('pageshow', function (event, ui) { checkLibraryList(); });
