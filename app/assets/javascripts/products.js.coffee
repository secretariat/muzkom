jQuery(document).ready ->
	$('#search_field').autocomplete
  	source: $('#search_field').data('autocomplete-source')