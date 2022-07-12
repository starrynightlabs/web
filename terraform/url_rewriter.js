function handler(event) {
  var request = event.request;
  var uri = request.uri;

  // Any physical file that Flutter builds is allowed through. Anything else is presumed to be an
  // app deep link, so we need to load index.html. Basically:
  //  /assets/**
  //  /canvaskit/**
  //  /icons/**
  //  /<any regular file in root directory with a dot in it>
  if (!(uri.startsWith('/assets/') || uri.startsWith('/canvaskit/') || uri.startsWith('/icons/') || uri.startsWith('/images/')
        || /^\/[^\/]*\.[^\/]*$/.test(uri))) {
    request.uri = '/index.html';
  }

  return request;
}
