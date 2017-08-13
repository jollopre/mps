import { API, asyncAction } from '../middlewares/apiMiddleware';

export const GET_ORDERS = asyncAction('GET_ORDERS');
export const GET_ORDER = asyncAction('GET_ORDER');
export const POST_ORDER = asyncAction('POST_ORDER');

export const getOrdersCreator = (customerId) => ({
	type: API,
	payload: {
		url: `/api/orders?customer_id=${customerId}`,
		method: 'GET',
		types: [GET_ORDERS.PENDING, GET_ORDERS.SUCCESS, GET_ORDERS.ERROR],
	},
});

export const getOrderCreator = (id) => ({
	type: API,
	payload: {
		url: `/api/orders/${id}`,
		method: 'GET',
		types: [GET_ORDER.PENDING, GET_ORDER.SUCCESS, GET_ORDER.ERROR],
	},
});

export const postOrderCreator = (customerId) => ({
	type: API,
	payload: {
		url: '/api/orders',
		method: 'POST',
		types: [POST_ORDER.PENDING, POST_ORDER.SUCCESS, POST_ORDER.ERROR],
		body: { order: { customer_id: customerId }},
	},
});

const shouldGetOrdersRequest = (state) => !state.orders.all;

const shouldGetOrderRequest = (state, id) => state.orders.byId[id] === undefined;

export const getOrders = (customerId) => {
	return (dispatch, getState) => {
		if (shouldGetOrdersRequest(getState())) {
			return dispatch(getOrdersCreator(customerId));
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

export const postOrder = (customerId) => {
	return (dispatch) => {
		return dispatch(postOrderCreator(customerId));
	};
};
