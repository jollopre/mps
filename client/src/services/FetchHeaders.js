export const FetchHeaders = (function(){
	let headers = {
		'Accept-Charset': 'utf-8',
		'Content-Type': 'application/json',
	};
	return {
		/*
			Deletes the HTTP header passed
			@param {string} name - The name of the HTTP header
			@returns {boolean} true if delete operation was carried out successfully or false otherwise
		*/
		delete: function(name){
			if(typeof name === 'string'){
				if(headers[name]){
					const { [name]: toDelete, ...rest } = headers;
					headers = Object.assign({}, rest);
					return true;
				}
				return false;
			}
			return false;
		},
		/*
			Returns the value for a given HTTP header name
			@param {string} name - The name of the HTTP header
			@returns {string} the HTTP header value or null if does not exist
		*/
		get: function(name) {
			if(typeof name === 'string'){
				return headers[name] ? headers[name] : null;
			}
			return null;
		},
		/*
			Returns true if the given HTTP header exists or false otherwise
			@param {string} name - The name of the HTTP header
			@returns {boolean}
		*/
		has: function(name) {
			if(typeof name === 'string'){
				return headers[name] ? true : false;
			}
			return false;
		},
		/*
			Returns the headers object conforming to key/value pairs
		*/
		entries: function() {
			return headers;
		},
		/*
			Adds or overrides the HTTP header passed
			@param {string} name - The name of the HTTP header
			@param {string} value - The new value you want to set
			@return {boolean} true if set operation was carried out successfully or false otherwise
		*/
		set: function(name, value) {
			if (typeof name === 'string' &&
				typeof value === 'string'){
				headers = Object.assign({}, headers, { [name]: value });
				return true;
			}
			return false;
		}
	}
})();