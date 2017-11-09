  $( document ).on('turbolinks:load', function() {

    albumSelected = function ()
    {
      // $('#album_form').show();
      window.location.href = "/albums/1";
      $('#album_codes').show();
    }


    $('#album_form').hide();
    $('#album_search').on('keyup', function (event) {

      if (event.keyCode == 13) {
    $('#album_results').html('')
        $('#allAlbums').hide();

        $.ajax({
          url: '/albums/?searchPhrase=' + $(event.target).val(),
          data: {
            format: 'json'
          },
          error: function() {
            $('#album_list').append('error');

          },
          dataType: 'json',

          success: function(data) {

            $('#album_list tbody').html('');

            $.each(data.rows, function(index, row) {

              var albumRow =
              '<div class="col-xl-2 col-lg-3 col-sm-4 col-6">' +
                '<a href="" class="contacts__img"></a>' +
                '<div class="contacts__item">' +
                  '<a href="" class="contacts__img">' +
                    '<img src="/assets/record.jpeg" alt="1">' +
                    '<br><br>' +
                    '<div class="contacts__info">' +
                      '<strong>' + row.name + '</strong>' +
                    '</div>' +
                  '</a>' +
                '</div>' +
              '</div>'

              $('#album_results').append(albumRow);          });

            $('#album_results').show();

          },
          type: 'GET'
        });

      }

    });
  });



