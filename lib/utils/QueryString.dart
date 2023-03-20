const queryString = {
  'placePhoto': {
    'uri': 'https://api.foursquare.com/v3/places/',
    'photo': '/photos',
    'header': {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    }
  },
  'nearbyPlace': {
    'uri': 'https://api.foursquare.com/v3/places/nearby?ll=',
    ',': '%2C',
    'header': {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    }
  },
  'placeDetails': {
    'uri': 'https://api.foursquare.com/v3/places/',
    'header': {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    }
  },
  'tip': {
    'uri': 'https://api.foursquare.com/v3/places/',
    'tip': '/tips',
    'sort': '?sort=NEWEST',
    'header': {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    }
  },
  'searchPlace': {
    'uri': 'https://api.foursquare.com/v3/places/search?query=',
    'll': '&ll=',
    ',': '%2C',
    'radius': '&radius=10000',
    'header': {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    }
  },
};
