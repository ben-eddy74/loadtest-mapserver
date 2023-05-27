import './style.css';
import Map from 'ol/Map.js';
import ImageLayer from 'ol/layer/Image.js';
import ImageWMS from 'ol/source/ImageWMS.js';
import View from 'ol/View.js';
import {boundingExtent} from 'ol/extent';

// Get bounding box from URL parameters
let w = -180;let s = -90;let e = 180;let n = 90;
const params = new URL(document.location).searchParams;
if(params.has("w")) { w = params.get("w"); }
if(params.has("s")) { s = params.get("s"); }
if(params.has("e")) { e = params.get("e"); }
if(params.has("n")) { n = params.get("n"); }

const geoserverLayer = new ImageLayer({
  source: new ImageWMS({
    url: 'https://ahocevar.com/geoserver/wms',
    params: {'LAYERS': 'topp:states'},
    ratio: 1,
    serverType: 'geoserver'
  })
});

const map = new Map({
  target: 'map',
  layers: [ geoserverLayer ],
  view: new View({
    center: [0, 0],
    zoom: 2,
  }),
});