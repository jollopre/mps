import { FetchWrapper } from './services/FetchWrapper';
import { FetchHeaders } from './services/FetchHeaders';

export const Auth = (function(){
	const isStorageAvailable = (function(){
		try {
			window.localStorage.setItem('__storage_test__', 'test string');
			window.localStorage.removeItem('__storage_test__');
			return true;
		}
		catch (e) {
			return false;
		}
	})();
	function updatePersistedToken(token) {
		if(isStorageAvailable){
			window.localStorage.setItem('auth_token', token);
		}
	}
	function removePersistedToken(){
		if(isStorageAvailable){
			window.localStorage.removeItem('auth_token');
		}
	}
	function init(){
		if(isStorageAvailable){
			const auth_token = window.localStorage.getItem('auth_token');
			if(auth_token !== null){
				FetchHeaders.set('Authorization', `Token token=${auth_token}`);
			}
			return auth_token;
		}
		return null;
	}
	let auth_token = init();
	return {
		getToken: function() {
			return auth_token;
		},
		invalidateToken: function() {
			auth_token = null;
			FetchHeaders.delete('Authorization');
			removePersistedToken();
		},
		isAuthenticated: function() {
			return auth_token !== null;
		},
		signIn: function({ username = '', password = '' } = {}) {
			return FetchWrapper.post('/api/sign-in',
				{ user: { email: username, password: password }})
					.then((response) => {
						return response.json();
					})
					.then((data) => {
						auth_token = data.token;
						FetchHeaders.set('Authorization', `Token token=${auth_token}`);
						updatePersistedToken(data.token);
					});
		},
		signOut: function() {
			return FetchWrapper.delete('/api/sign-out')
				.then(() => {
					auth_token = null;
					FetchHeaders.delete('Authorization');
					removePersistedToken();
				});
		}
	};
})();