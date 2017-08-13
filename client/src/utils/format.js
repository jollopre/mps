export const Format = {
	dateToHumanReadable: iso8601 => {
		if(typeof iso8601 === 'string'){
			// TODO https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Date
			return new Date(iso8601).toString();
		}
		return null;
	}
};