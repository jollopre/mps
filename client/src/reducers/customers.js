import {
	GET_CUSTOMERS,
	GET_CUSTOMER,
	SEARCH_CUSTOMERS
} from '../actions/customers';

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = value;
	return acc;
}, {});

export const customers = (state = { byId: {}, isFetching: false }, action) => {
	const { type, payload } = action;
	switch (type) {
		case GET_CUSTOMERS.PENDING:
		case GET_CUSTOMER.PENDING:
		case SEARCH_CUSTOMERS.PENDING:
			return {
				...state,
				isFetching: true
			};
		case GET_CUSTOMERS.SUCCESS:
		case SEARCH_CUSTOMERS.SUCCESS:
			return {
				...state,
				meta: payload.meta,
				byId: Object.assign({}, state.byId, arrayToMap(payload.data)),
				isFetching: false
			}
		case GET_CUSTOMER.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: Object.assign({}, state.byId, { [payload.id]: payload }),
			};
		case GET_CUSTOMERS.ERROR:
		case GET_CUSTOMER.ERROR:
		case SEARCH_CUSTOMERS.ERROR: 
			return {
				...state,
				isFetching: false
			}
		default:
			return state;
	}
};