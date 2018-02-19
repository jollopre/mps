import { 
	GET_ORDERS,
	GET_ORDER,
	POST_ORDER } from '../actions/orders';
import { Format } from '../utils/format';

const formatDates = (order) => ({
	...order,
	created_at: Format.db(order.created_at),
	updated_at: Format.db(order.updated_at),
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
			return {
				...state,
				isFetching: false,
				meta: payload.meta,
				byId: Object.assign({}, state.byId, arrayToMap(payload.data)),
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
				meta: Object.assign({}, state.meta, { count: state.meta.count + 1 }),
				byId: Object.assign({}, state.byId, { [payload.id]: formatDates(payload) }),
			};
		default:
			return state;
	}
}