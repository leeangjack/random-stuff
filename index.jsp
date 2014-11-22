
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Test</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/tmx.css" />
   <link rel="stylesheet" href="<%=request.getContextPath()%>/images/main.css" type="text/css">
   
  <link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css">
  <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/colvis/1.1.1/css/dataTables.colVis.css" />
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.dataTables.yadcf.css" />
  
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.0/backbone-min.js"></script>
	<script src="//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
 
  <script src="<%=request.getContextPath()%>/images/main.js"></script>
  <script type='text/javascript' src="http://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.dataTables.yadcf.js"></script> 
	<script type="text/javascript" src="//cdn.datatables.net/colvis/1.1.1/js/dataTables.colVis.min.js"></script>
		<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/1.4.11/jquery.scrollTo.min.js"></script>
	
	
	
	<script>
	var table;
	
		$(document).ready(function(){
			table=$('#table').dataTable({
				// <-- your array of objects
		     "ajax": {
            "url": "<%=request.getContextPath()%>/images/sf_movie_dataTable.json",
            "type": "GET"
        },
		      
        "autoWidth": false,
			        "columns": [
			            { "data": "title" , "render": function ( data, type, row ) {
							return '<a id="chosen_movie" href="#"   tyle="text-decoration: underline" title="find out locations!">'+data+'</a>';
						}, "sWidth": "10%"},
			            { "visible":false, "data": "release_year" ,"sWidth": "10%"},
			            { "data": "locations" ,"sWidth": "10%"},
			            {"visible":false,  "data": "fun_facts" ,"sWidth": "10%"},
			            {"visible":false,  "data": "production_company" ,"sWidth": "10%"},
			            {"visible":false,  "data": "distributor","sWidth": "10%" },  
			            { "visible":false, "data": "director" ,"sWidth": "10%"},
			            {"visible":false,  "data": "writer" ,"sWidth": "10%"},
			            {"visible":false,  "data": "actor_1" ,"sWidth": "10%"},
			            {"visible":false,  "data": "actor_2" ,"sWidth": "10%"},
			            { "visible":false, "data": "actor_3" ,"sWidth": "10%"}
			        ],
			        "dom": '<"top">rt<"bottom"lpi><"clear">C',
					 
			        // Column visibility selection button
					"oColVis": {
				            "buttonText": "Show columns"	
					},
				
				
				
				
				
				
				
				
			}
              
					
					
			).yadcf([
			        {column_number : 0,
			        filter_type: "auto_complete"},
			        {column_number : 1,
			        filter_type: "range_number_slider"},
			        {column_number : 2,
			        filter_type: "auto_complete"},
			        {column_number : 4},
			        {column_number : 5},
			        {column_number : 6},
			        {column_number : 7},
			        {column_number : 8},
			        {column_number : 9},
			        {column_number : 10}]);
			
			
			
			$(window).bind('resize', function () {
			    table.fnAdjustColumnSizing();
			  } );

		
	})
	
	</script>
</head> 
<body>
	<div id="container">
		<header>
			<h1>Movies!</h1>
			<h2></h2>
		</header>
		<div id="content">
		<div id="right-column">
		
	<table class="table" id="table" border="0" cellpadding="0" cellspacing="0">
					
					<thead>
					<tr>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
	    </tr>
						<tr>
		<th>Title</th>
		<th>Release Year</th>
		<th>Locations</th>
		<th>Fun Facts</th>
		<th>Production Company</th>
		<th>Distributor</th>
		<th>Director</th>
		<th>Writer</th>
		<th>Actor1</th>
		<th>Actor2</th>
		<th>Actor3</th>
	    </tr>
					</thead>
					
        
				</table>
				</div>
			   </div>
				<h3>Locations!</h3>
			<h4></h4>
				
		<div id="sidebar">

			<div id="selected-movie">
				<h3></h3>
				<p>No film locations for current search term</p>
			</div>


		</div>
		<div id="map-canvas">
		</div>
	</div>
	
				
</body>
</html>
