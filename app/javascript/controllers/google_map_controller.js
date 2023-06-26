import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="google-map"
export default class extends Controller {
  static targets = ["map", "listings"];

  connect() {
    if (window.google) {
      this.initGoogle();
    }
  }

  // this also executes when the custom event is triggered by google api callback param
  initGoogle() {
    const map = new google.maps.Map(this.mapTarget, {
      zoom: 4,
      // this lat and lng centers Canada and US in the map
      center: { lat: 44.368888, lng: -99.996246 },
    });
    this.addMarkers(map);
  }

  addMarkers(map) {
    Array.from(this.listingsTarget.children).forEach((listing) => {
      const marker = new google.maps.Marker({
        position: {
          lat: parseFloat(listing.dataset.lat),
          lng: parseFloat(listing.dataset.lon),
        },
        dog: {
          name: listing.dataset.name,
          breed: listing.dataset.breed,
        },
        map,
      });
      this.setClickableMarker(marker, map);
    });
  }

  // make the marker clickable and show an info window
  setClickableMarker(marker, map) {
    marker.addListener("click", () => {
      const infoWindow = new google.maps.InfoWindow({
        content: `
              <h3>${marker.dog.name}</h3>
              <p>${marker.dog.breed}</p>
              `,
      });
      infoWindow.open(map, marker);
    });
  }
}
