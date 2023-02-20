import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// google map script tag calls this method via callback param when finished loading
// this creates a custom event that is being listened to in the view to build map
// without this google-map controller JS runs before google is available and fails
window.initMap = () => {
    console.log('initMap was called');
    const event = new Event("MapLoaded", {"bubbles":true, "cancelable":false});
    window.dispatchEvent(event)
}

export { application }
