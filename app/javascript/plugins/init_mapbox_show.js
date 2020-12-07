import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'mapa',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkerToMap = (mapa, marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';

    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(mapa);
};

const fitMapToMarker = (mapa, marker) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ marker.lng, marker.lat ]);
  mapa.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapboxShow = () => {
  const mapElement = document.getElementById('mapa');
  if (mapElement) { // only build a map if there's a div#map to inject into
    const mapa = buildMap(mapElement);
    const marker = JSON.parse(mapElement.dataset.marker);
    addMarkerToMap(mapa, marker);
    fitMapToMarker(mapa, marker);
  }
};

export { initMapboxShow };
