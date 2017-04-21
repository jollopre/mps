export default function debounce(func, wait) {
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