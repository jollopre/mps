export const Format = {
	dateToHumanReadable: iso8601 => {
		if(typeof iso8601 === 'string'){
			return new Date(iso8601).toString();
		}
		return null;
	},
	/*
	 * Formats an iso8601 date into YYYY-MM-DD HH:MM:SS UTC time.
	*/
	db: iso8601 => {
		// Given a number passed, increases by one its value (if increment true) and prepends zero
		// if the resulting number is less than 10
		const prependZero = (number, increment = false) => {
			const nbr = increment ? number + 1 : number;
			return nbr < 10 ? `0${nbr}` : nbr;
		}
		const date = new Date(iso8601);
		return `${date.getUTCFullYear()}-${prependZero(date.getUTCMonth(), true)}-${date.getUTCDate()} \
			${prependZero(date.getUTCHours())}:${prependZero(date.getUTCMinutes())}:${prependZero(date.getUTCSeconds())}`;
	}
};