import { API, asyncAction } from '../middlewares/apiMiddleware';

export const GET_ORDER_ITEMS = asyncAction('GET_ORDER_ITEMS');
export const POST_ORDER_ITEM = asyncAction('POST_ORDER_ITEM');
export const PUT_ORDER_ITEM = asyncAction('PUT_ORDER_ITEM');
export const GET_EXPORT_ORDER_ITEM = asyncAction('GET_EXPORT_ORDER_ITEM');
export const CLEAR_EXPORT_ORDER_ITEM = 'CLEAR_EXPORT_ORDER_ITEM';

const getOrderItemsCreator = (orderId) => ({
	type: API,
	payload: {
		url: `/api/orders/${orderId}/order_items`,
		method: 'GET',
		types: [GET_ORDER_ITEMS.PENDING, GET_ORDER_ITEMS.SUCCESS, GET_ORDER_ITEMS.ERROR],
	}
});

const getExportOrderItemCreator = (orderItemId) => ({
	type: API,
	payload: {
		url: `/api/order_items/${orderItemId}/export`,
		method: 'GET',
		types: [GET_EXPORT_ORDER_ITEM.PENDING, GET_EXPORT_ORDER_ITEM.SUCCESS, GET_EXPORT_ORDER_ITEM.ERROR],
	}
});

const putOrderItemCreator = (orderItemId, quantity) => ({
	type: API,
	payload: {
		url: `/api/order_items/${orderItemId}`,
		method: 'PUT',
		types: [PUT_ORDER_ITEM.PENDING, PUT_ORDER_ITEM.SUCCESS, PUT_ORDER_ITEM.ERROR],
		body: { order_item: { quantity }},
	}
});

const postOrderItemCreator = ({ orderId = null, productId = null, quantity = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/orders/${orderId}/order_items`,
		method: 'POST',
		types: [POST_ORDER_ITEM.PENDING, POST_ORDER_ITEM.SUCCESS, POST_ORDER_ITEM.ERROR],
		body: { order_item: { order_id: orderId, product_id: productId, quantity } },
	}
});

const shouldGetOrderItemsRequest = (state, orderId) => {
	const keys = state.orderItems.byId;
	if (keys.length > 0) {
		return Number(orderId) !== state.orderItems.byId[keys[0]].order_id;
	}
	return true;
}

export const getOrderItems = (orderId) => {
	return (dispatch, getState) => {
		if (shouldGetOrderItemsRequest(getState(), orderId)) {
			return dispatch(getOrderItemsCreator(orderId));
		}
		return Promise.resolve();
	};
};

export const getExportOrderItem = (orderItemId) => {
	return (dispatch, getState) => {
		return dispatch(getExportOrderItemCreator(orderItemId));
	}
}

export const clearExportOrderItem = () => ({
	type: CLEAR_EXPORT_ORDER_ITEM
});

export const putOrderItem = (orderItemId, quantity) => {
	return (dispatch) => {
		return dispatch(putOrderItemCreator(orderItemId, quantity));
	};
};

export const postOrderItem = ({ orderId, productId, quantity }) => {
	return (dispatch) => {
		return dispatch(postOrderItemCreator({ orderId, productId, quantity }));
	};
};

