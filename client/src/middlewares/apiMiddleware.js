const authorization = token => ({ 'Authorization': `Token token=${token}` });

const fetchWrapper = ({ url, method, body, token }) => {
	return fetch(url, {
		method,
		headers: Object.assign(
					{},
					{ 'Accept': 'application/json' },
					{ 'Accept-Charset': 'utf-8' },
					{ 'Content-Type': 'application/json' },
					authorization(token)),
		body: body ? JSON.stringify(body) : undefined,
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
		const { payload } = action;
		const onRejectionHandler = (onRejection) => {
			// ERROR
			dispatch({ type: payload.types[2], payload: { detail: onRejection }});
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
								dispatch({ type: payload.types[1], payload: onFulfillment });
							}).catch(onRejectionHandler);
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
							dispatch({ type: payload.types[1], payload: null });
						}
						break;
					// no_content
					case 204:
					default:
						// SUCCESS
						dispatch({ type: payload.types[1], payload: null });
						break;
				}
			}
			else { // ERROR
				const { status, statusText } = onFulfillment;
				dispatch({ type: payload.types[2], payload: { status, statusText }});
			}
		};
		// PENDING
		dispatch({ type: payload.types[0], payload: null });
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
			types: ['PENDING', 'SUCCESS', 'ERROR']
		},
	}
	Spect output object
	{
		type: // value is one of the types passed ['PENDING', 'SUCCESS', 'ERROR'],
		payload: // value is one of null, object, { status, statusText, detail }
	}
*/

