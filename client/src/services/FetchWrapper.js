import {FetchHeaders} from './FetchHeaders';

export const FetchWrapper = (function(){
	function promiseWrapper(fetchPromise) {
		return new Promise((resolve, reject) => {
			fetchPromise.then((fetchResponse) => {
				if(fetchResponse.ok){	// status in the range 200-299
					if(fetchResponse.status === 200) {
						fetchResponse.json().then((data) => {
							resolve(data);
						}, (error) => {
							reject({
								status: fetchResponse.status,
								statusText: fetchResponse.statusText,
								detail: error.message || 'unknown error',
							});
						});
					}
					else {
						resolve(fetchResponse);
					}
				}
				else {
					fetchResponse.json().then((data) => {
						reject({
							status: fetchResponse.status,
							statusText: fetchResponse.statusText,
							detail: data.detail,
						});
					}, (error) => {
						reject({
							status: fetchResponse.status,
							statusText: fetchResponse.statusText,
							detail: error.message || 'unknown error',
						});
					});
				}
			}, (error) => {	//TypeError object
				reject({
					statusText: error.message || 'unknown error',
				});
			});
		});
	}
	return {
		/*
			@param {string} URL - The URL to get a resource
			@returns {Promise} - Representing the eventual completion (or failure) and its resulting value 
		*/
		get: function(URL){
			return promiseWrapper(
					window.fetch(URL, {
						method: 'GET',
						headers: FetchHeaders.entries(),
				}));
		},
		/*
			@param {string} URL - The URL to post a resource
			@param {object} body - An object according to the API specification for the URL passed
			@returns {Promise} - Representing the eventual completion (or failure) and its resulting value 
		*/
		post: function(URL, body){
			return promiseWrapper(
					window.fetch(URL, {
						method: 'POST',
						headers: FetchHeaders.entries(),
						body: JSON.stringify(body),
				}));
		},
		/*
			@param {string} URL - The URL to put a resource
			@param {object} body - An object according to the API specification for the URL passed
			@returns {Promise} - Representing the eventual completion (or failure) and its resulting value 
		*/
		put: function(URL, body) {
			return promiseWrapper(
					window.fetch(URL, {
						method: 'PUT',
						headers: FetchHeaders.entries(),
						body: JSON.stringify(body),
				}));
		},
		/*
			@param {string} URL - The URL to delete a resource
			@returns {Promise} - Representing the eventual completion (or failure) and its resulting value 
		*/
		delete: function(URL) {
			return promiseWrapper(
					window.fetch(URL, {
						method: 'DELETE',
						headers: FetchHeaders.entries(),
				}));
		}
	}
})();