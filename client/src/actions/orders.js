import { API, asyncAction } from '../middlewares/apiMiddleware';
import { ORDERS } from './pagination';

export const GET_ORDERS = asyncAction('GET_ORDERS');
export const GET_ORDER = asyncAction('GET_ORDER');
export const POST_ORDER = asyncAction('POST_ORDER');
export const SEARCH_ORDERS = asyncAction('SEARCH_ORDERS');

export const getOrdersCreator = ({ customerId, page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/orders?customer_id=${customerId}&page=${page}`,
		method: 'GET',
		types: [GET_ORDERS.PENDING, GET_ORDERS.SUCCESS, GET_ORDERS.ERROR]
	},
	meta: { page, resource: ORDERS },
});

export const getOrderCreator = (id) => ({
	type: API,
	payload: {
		url: `/api/orders/${id}`,
		method: 'GET',
		types: [GET_ORDER.PENDING, GET_ORDER.SUCCESS, GET_ORDER.ERROR],
	},
});

export const postOrderCreator = ({ customerId, meta = {}} = {}) => ({
	type: API,
	payload: {
		url: '/api/orders',
		method: 'POST',
		types: [POST_ORDER.PENDING, POST_ORDER.SUCCESS, POST_ORDER.ERROR],
		body: { order: { customer_id: customerId }},
	},
	meta
});

const searchOrdersCreator = ({ customerId = null, term = '', page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/orders/search/${term}?customer_id=${customerId}&page=${page}`,
		method: 'GET',
		types: [SEARCH_ORDERS.PENDING, SEARCH_ORDERS.SUCCESS, SEARCH_ORDERS.ERROR],
	},
	meta: { page, resource: ORDERS },
});

/*
 * Determines whether or not GET_CUSTOMERS request should be initiated.
 * @param state {} - Redux application state
 * @param params {} - The params object passed to getOrders action
 * @returns true if orders pagination sub-state for the params.page passed is not defined or
 * if the array of ids for that specific page is empty (look at src/reducers/pagination to
 * better understand the sub-state structure) or if orders.byId object does not have an
 * order object whose customer_id is equals to params.customerId
*/
const shouldGetOrdersRequest = (state, params) => {
	const { customerId, page } = params;
	const ordersPagination = state.pagination.orders;
	const { orders } = state;
	return !ordersPagination.pages[page] ||
		ordersPagination.pages[page].ids === [] ||
		ordersPagination.pages[page].ids.find(id => orders.byId[id].customer_id === customerId);
};

const shouldGetOrderRequest = (state, id) => state.orders.byId[id] === undefined;

export const getOrders = (params = {}) => {
	return (dispatch, getState) => {
		if (shouldGetOrdersRequest(getState(), params)) {
			return dispatch(getOrdersCreator(params));
		}
		return Promise.resolve();		
	};
};

export const getOrder = (id) => {
	return (dispatch, getState) => {
		if (shouldGetOrderRequest(getState(), id)) {
			return dispatch(getOrderCreator(id));
		}
		return Promise.resolve();
	};
};

export const postOrder = (params) => {
	return (dispatch) => {
		return dispatch(postOrderCreator(params));
	};
};

export const searchOrders = (params = {}) => {
	return (dispatch) => {
		return dispatch(searchOrdersCreator(params));
	};
}
