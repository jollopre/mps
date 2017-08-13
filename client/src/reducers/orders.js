import { 
	GET_ORDERS,
	GET_ORDER,
	POST_ORDER } from '../actions/orders';
import { Format } from '../utils/format';

const formatDates = (order) => ({
	...order,
	created_at: Format.dateToHumanReadable(order.created_at),
	updated_at: Format.dateToHumanReadable(order.updated_at),
});

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = formatDates(value);
	return acc;
}, {});

export const orders = (state = { byId: {}, isFetching: false}, action) => {
	const { type, payload } = action;
	switch(type){
		case GET_ORDERS.PENDING:
		case GET_ORDER.PENDING:
		case POST_ORDER.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case GET_ORDERS.ERROR:
		case GET_ORDER.ERROR:
		case POST_ORDER.ERROR:
			return {
				...state,
				isFetching: false,
			};
		case GET_ORDERS.SUCCESS: 
			return {	// Removes byId map entries whenever customer changes
				...state,
				isFetching: false,
				byId: arrayToMap(payload),
				all: true,
			};
		case GET_ORDER.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: Object.assign({}, state.byId, { [payload.id]: formatDates(payload) }),
			};
		case POST_ORDER.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: Object.assign({}, state.byId, { [payload.id]: formatDates(payload) }),
			};
		default:
			return state;
	}
}