import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

window.initMap = () => {
    console.log('initMap was called');
    const event = new Event("MapLoaded", {"bubbles":true, "cancelable":false});
    window.dispatchEvent(event)
}

export { application }
