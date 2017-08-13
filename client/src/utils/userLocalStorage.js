export const UserLocalStorage = (function(){
	const isAvailable = (function(){
		try {
			window.localStorage.setItem('__storage_test__', 'test string');
			window.localStorage.removeItem('__storage_test__');
			return true;
		}
		catch (e) {
			return false;
		}
	})();
	return {
		getEntries: function() {
			if(isAvailable){
				return {
					token: window.localStorage.getItem('token'),
				};
			}
			return { token: null };
		},
		removeEntries: function() {
			if(isAvailable){
				window.localStorage.clear();
			}
		},
		setEntries: function({ token = null } = {}) {
			if(isAvailable){
				window.localStorage.setItem('token', token);
			}
		}
	}
})();