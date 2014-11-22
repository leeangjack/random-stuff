var sf_movie_data;
var map;
var markers = [];
var addresses_to_coordinates = {};

// Load the map
function init_map() {
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(37.7699298, -122.4469157), // Haight SF
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

// Remove pins from the map, with exceptions
function clear_markers(exceptions) {
	if (typeof(exceptions) === 'undefined') {
		exceptions = [];
	}
  for (var i = 0; i < markers.length; i++) {
		if ($.inArray(markers[i].title, exceptions) === -1) {
			markers[i].setMap(null);
		}
  }
}

// Add a pin to the map
function add_marker(pos, address) {
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(pos.lat, pos.lng),
		map: map,
		title: address
	});
	markers.push(marker);
}

// Plot an address on the map
function add_address_to_map(address) {
	if (typeof(addresses_to_coordinates[address]) === 'undefined') {
		search_term = encodeURIComponent(address+' san francisco, ca');
		// Geocode the address
		$.get(
			'http://maps.google.com/maps/api/geocode/json?sensor=false&address='+search_term,
			function(response) {
				pos = response.results[0].geometry.location;
				addresses_to_coordinates[address] = pos; // Cache locally
				add_marker(pos, address);
			}
		);
	} else {
		add_marker(addresses_to_coordinates[address], address);
	}
}

// Only show one pin
function highlight_address(address) {
	clear_markers([address]);
	add_address_to_map(address);
}

function display_selected_movie(title) {
  // Get locations from SF movie data
	var locations = filter_movie_data_by_title(title);

  // Clear existing state
	$('#selected-movie').html('');
	clear_markers();

  // Set locations list
	if (locations.length > 0) {
		// Display locations in sidebar and add markers
		var innerHTML = '<h3><a href="http://www.imdb.com/find?s=tt&q='+encodeURIComponent(locations[0][8])+'">'+locations[0][8]+'</a></h3>';
		innerHTML += '<h4>Film Locations</h4>';
		innerHTML += '<ul id="locations">';
		for (i in locations) {
			innerHTML += '<li>'+locations[i][10]+'</li>';
			add_address_to_map(locations[i][10]);
		}
		innerHTML += '</ul>';
		$('#selected-movie').html(innerHTML);
		$('#locations li').mouseover(function(){ highlight_address(this.innerHTML); });
		$('#locations li').mouseout(function(){ var t = title; display_selected_movie(t); });
	} else {
		var innerHTML = '<h3>'+title+'</h3>';
		innerHTML += '<p>No film locations for current search terms</p>';
		$('#selected-movie').html(innerHTML);
	}
}

// Helper function to filter through the sf movie data and
// get all locations by a single title
function filter_movie_data_by_title(title) {
	filtered_data = [];
	$(sf_movie_data).each( function(i,data){
		if (data[8] == title) {
			filtered_data.push(data);
		}
	} );
	return filtered_data;
}

$(document).ready( function() {
	// Load Google Map when the window loads
	google.maps.event.addDomListener(window, 'load', init_map);

	/*
	 * Downloaded sf_movie_data.json from sfgov to host it locally
	 * https://data.sfgov.org/api/views/yitu-d5am/rows.json?accessType=DOWNLOAD
	*/
	$.get('./images/sf_movie_data.json', function(response) {
    sf_movie_data = response.data;
		var movies = [];
		$(sf_movie_data).each( function(i,data){
			$.each( data, function(k,v){ data[k] = $.trim(v); } );
			if ($.inArray(data[8], movies) === -1 && data[10] != false) {
				movies.push(data[8]);
				//autocomplete_data.push(data[8]);
				$('#movie-list').append('<li><a href="#">'+data[8]+'</a></li>');
			}
		} );
		$("#table tbody").on("click", "a", function(event){
			var name = $(this).text();
			alert(name);
			$('#search').val(name); display_selected_movie(name); 
			$.scrollTo($('#map-canvas'), 500);
		});

    // Set autocomplete data
		$('#table_filter input').autocomplete({
			delay: 0,
			source: movies,
			select: function(evt, element) { display_selected_movie(element.item.value); }
		});
	} );
} );
