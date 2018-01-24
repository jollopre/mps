import {
	GET_CUSTOMERS,
	GET_CUSTOMER
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
			return {
				...state,
				isFetching: true
			};
		case GET_CUSTOMERS.SUCCESS:
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
			return {
				...state,
				isFetching: false
			}
		default:
			return state;
	}
};