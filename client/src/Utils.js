export default class Utils {
	static debounce(func, wait) {
		let timeout = null;
		return function() {
			const ctx = this;
			const args = arguments;
			const later = function() {
				timeout = null;
				func.apply(ctx, args);
			}
			clearTimeout(timeout);
			timeout = setTimeout(later, wait || 200);
		}
	}
	static dateToHumanReadableString(iso8601) {
		return new Date(iso8601).toString();
	}
}