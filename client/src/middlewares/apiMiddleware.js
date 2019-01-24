const fetchWrapper = ({ url, method, body, token }, delay = 0) => {
  const delayedFetch = () => {
    return fetch(url, {
      method,
      headers: Object.assign(
        {},
        { 'Accept': 'application/json' },
        { 'Accept-Charset': 'utf-8' },
        { 'Content-Type': 'application/json' },
        { 'Authorization': `Token token=${token}` }),
      body: body ? JSON.stringify(body) : undefined,
    });
  };
  return new Promise((resolve) => {
    setTimeout(resolve, delay);
  }).then(() => {
    return delayedFetch();
  });
};

const responseHandler = ({ contentType, body }) => {
  if (contentType.includes('application/json')) {
    return body.json();
  } else if (contentType.includes('application/pdf')) {
    return body.blob();
  } else {
    return null;
  }
};

export const API = 'API';

export const asyncAction = (type) => ({
  PENDING: `${type}_PENDING`,
  SUCCESS: `${type}_SUCCESS`,
  ERROR: `${type}_ERROR`,
});

export const apiMiddleware = ({ getState, dispatch }) => next => action => {
  if (action.type !== API) {
    return next(action);
  }
  else {
    const { payload, meta } = action;
    const onRejectionHandler = (onRejection) => {
      // ERROR
      dispatch({ type: payload.types[2], payload: { detail: onRejection }, meta: meta || {} });
    };
    const onFulfillmentHandler = (onFulfillment) => {
      if (onFulfillment.ok) {
        switch(onFulfillment.status) {
            // ok
          case 200:
            const body = responseHandler({
              contentType: onFulfillment.headers.get('Content-Type'),
              body: onFulfillment
            });
            if (body) {
              body.then((onFulfillment) => {
                // SUCCESS
                dispatch({
                  type: payload.types[1],
                  payload: onFulfillment,
                  meta: meta || {}
                });
              });
            }
            break;
            // created
          case 201:
            const location = onFulfillment.headers.get('Location');
            if (location) {
              return fetchWrapper({
                url: location,
                method: 'GET',
                token: getState().user.token,
              }).then(onFulfillmentHandler).catch(onRejectionHandler);
            } else {
              // SUCCESS
              dispatch({ type: payload.types[1], payload: null, meta: meta || {} });
            }
            break;
            // no_content
          case 204:
          default:
            // SUCCESS
            dispatch({ type: payload.types[1], payload: null, meta: meta || {} });
            break;
        }
      }
      else { // ERROR
        const { status, statusText } = onFulfillment;
        dispatch({ type: payload.types[2], payload: { status, statusText }, meta: meta || {} });
      }
    };
    // PENDING generates an action with type PENDING, null payload and meta object passed to the
    // API action type that this middleware handles
    dispatch({
      type: payload.types[0],
      payload: null,
      meta: meta || {}
    });
    return fetchWrapper({
      url: payload.url,
      method: payload.method,
      body: payload.body,
      token: getState().user.token,
    }).then(onFulfillmentHandler).catch(onRejectionHandler);
  }
};
/*
        Spec input object
        {
                type: 'API',
                payload: {
                        url: String,
                        method: GET | POST | PUT | DELETE,
                        body: // check value https://developer.mozilla.org/en-US/docs/Web/API/Body,
                        headers: A Headers object,
                        types: ['PENDING', 'SUCCESS', 'ERROR'],
                        meta: { page: Number} // Only if model has pagination
                },
        }
        Spect output object
        {
                type: // value is one of the types passed ['PENDING', 'SUCCESS', 'ERROR'],
                payload: // value is one of null, object, { status, statusText, detail }
        }
        */

