//= require arctic_admin/base
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input

$(document).ready(function() {
	let allCities = JSON.parse($('#all_cities').val());
	let countryId =  document.getElementById("country_select").value;
	let citySelect = $('#city_select');

	citySelect.empty();
	
	let filteredCities = allCities.filter(function(city) {
			return city.country_id == countryId;
	});

	filteredCities.forEach(function(city) {
		citySelect.append('<option value="' + city.id + '">' + city.name + '</option>');
	});

	$('#country_select').on('change', function() {
		countryId = $(this).val();
		citySelect = $('#city_select');

		citySelect.empty();
		citySelect.append('<option>Select City</option>');

		filteredCities = allCities.filter(function(city) {
			return city.country_id == countryId;
		});

		filteredCities.forEach(function(city) {
			citySelect.append('<option value="' + city.id + '">' + city.name + '</option>');
		});
	});
});

$(document).ready(function() {
  if ($('body').hasClass('admin_prompt_version_managers')) {
    const editLinks = $('.edit_link');

    editLinks.each(function(index) {
      if (index !== 0) {
        $(this).hide();
      }
    });
  }
});