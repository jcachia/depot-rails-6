// Bootstrap React component.

import React            from 'react' // Import the main React library.
import ReactDOM         from 'react-dom' // Bring in RenderDOM object - has the 'render' function.
import PayTypeSelector  from 'PayTypeSelector' // Import the component we are using for the form.

document.addEventListener('turbolinks:load', function() {
  var element = document.getElementById("pay-type-component");
  ReactDOM.render(<PayTypeSelector />, element);
});

// using addEventListener over DOMContentLoaded b/c turbolinks doesnt fire DOMContentLoaded every time the page is loaded.  using 'turbolinks:load' ensures that react is set up everyt ime the page is rendered.

