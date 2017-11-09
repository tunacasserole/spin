/*
  Grid Toggler
*/

// Register a handler to the toggle event of grid toggles
function registerGridToggle(name) {
  $(name + ' .toggle-switch > input.grid-toggle').on('click', function() {
    notify("Toggle successfully updated", "inverse");
  })
};

function gridToDateTime(value) {
  var result = moment(value).format("llll");
  if (value === null) {
    result = "";
  }
  return result;
}


function gridToYesNo(value) {
  var result = "Yes";
  if (value === '0' || value === false) {
    result = 'No';
  }
  return result;
}

function gridToAvatar(value) {
  return "<img class='avatar-sm' src='" + value + "' />";
}

