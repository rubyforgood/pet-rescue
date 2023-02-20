import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="google-map"
export default class extends Controller {
  static targets = ["map", "listings"]
  
  connect() {
    if(window.google) {
      this.initGoogle();
    }
  }

  initGoogle() {
    const map = new google.maps.Map(this.mapTarget, {
      zoom: 4,
      center: { lat: 44.368888, lng: -99.996246 }
    });
    this.addMarkers(map)
  }

  addMarkers(map) {
    Array.from(this.listingsTarget.children).forEach((listing) => {
      new google.maps.Marker({
        position: {
          lat: parseFloat(listing.dataset.lat),
          lng: parseFloat(listing.dataset.lon),
        },
        map,
        title: listing.dataset.name
      });
    })
  }
}
