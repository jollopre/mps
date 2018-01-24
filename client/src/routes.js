import { matchPath } from 'react-router'; 

export const CUSTOMERS_URI_PATTERN = '/customers';
export const ORDERS_URI_PATTERN = '/customers/:id/orders';
export const ORDER_URI_PATTERN = '/orders/:id';
export const ORDER_ITEM_URI_PATTERN = `${ORDER_URI_PATTERN}/order_items/:order_item_id`;
export const SIGN_IN_URI_PATTERN = '/sign_in';

export const orders_path = ({ id }) => {
	return ORDERS_URI_PATTERN.replace(/:id/, id);
};

export const order_path = ({ id } = {}) => {
	return ORDER_URI_PATTERN.replace(/:id/, id);
};

export const order_order_item_path = ({ id, order_item_id } = {}) => {
	return ORDER_ITEM_URI_PATTERN.replace(/([^:]+)(:id)([^:]+)(:order_item_id)/, (match, p1, p2, p3, p4) => {
		return `${p1}${id}${p3}${order_item_id}`;
	});
};

/*
 * This lets you use the same matching code that <Route> uses
 * except outside of the normal render cycle. It becomes useful
 * for when parent Route wants to access to params only available
 * in child matched
 * @param location {String} - Represents where the app is now
 * @param uri_pattern {String} - One of the constants defined above (e.g. ORDER_ITEM_URI_PATTERN)
 * return match object if location matches uri_pattern, otherwise null
*/

const match_from_location = (location, uri_pattern) => {
	return matchPath(location, {
		path: uri_pattern,
		exact: true,
		strict: false,
	});
};

export const order_order_item_match = (location) => {
	return match_from_location(location, ORDER_ITEM_URI_PATTERN);
};

/* 
 * Given an URL and a paramName, this methods attemps to get the value associated
 * @param URL {String} - Represents an URL
 * @param paramName {String} - Represents the query param to look for within the URL
 * return {String} value associated to the queryParam, otherwise null
*/
export const getQueryParam = (URL, paramName) => {
	const regExp = RegExp(paramName+'=(\\d+)');
	const re = regExp.exec(URL);
	if (re !== null) {
		return re[1];
	}
	return null;
};