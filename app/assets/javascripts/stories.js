// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $( ".task" ).draggable({ revert:"invalid" });
  $( ".status_task" ).droppable({
    drop: function( event, ui ) {
 		  $( ui.draggable )
			.css({ top:0,left:0 })
			.appendTo($( this ));

			$.ajax({ url: "tasks/" + $( ui.draggable ).attr( "id" ) + ".json",
							 type: "PUT",
							 data: { task: { status: $( this ).attr( "status" ) }},
							 dataType: "json"
				    });
  	}
  });
});
