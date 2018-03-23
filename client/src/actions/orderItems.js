import { API, asyncAction } from '../middlewares/apiMiddleware';

export const GET_ORDER_ITEMS = asyncAction('GET_ORDER_ITEMS');
export const POST_ORDER_ITEM = asyncAction('POST_ORDER_ITEM');
export const PUT_ORDER_ITEM = asyncAction('PUT_ORDER_ITEM');
export const GET_EXPORT_ORDER_ITEM = asyncAction('GET_EXPORT_ORDER_ITEM');
export const CLEAR_EXPORT_ORDER_ITEM = 'CLEAR_EXPORT_ORDER_ITEM';

const getOrderItemsCreator = (quotationId) => ({
	type: API,
	payload: {
		url: `/api/quotations/${quotationId}/order_items`,
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

const postOrderItemCreator = ({ quotationId = null, productId = null, quantity = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/quotations/${quotationId}/order_items`,
		method: 'POST',
		types: [POST_ORDER_ITEM.PENDING, POST_ORDER_ITEM.SUCCESS, POST_ORDER_ITEM.ERROR],
		body: { order_item: { quotation_id: quotationId, product_id: productId, quantity } },
	}
});

const shouldGetOrderItemsRequest = (state, quotationId) => {
	const keys = state.orderItems.byId;
	if (keys.length > 0) {
		return Number(quotationId) !== state.orderItems.byId[keys[0]].quotation_id;
	}
	return true;
}

export const getOrderItems = (quotationId) => {
	return (dispatch, getState) => {
		if (shouldGetOrderItemsRequest(getState(), quotationId)) {
			return dispatch(getOrderItemsCreator(quotationId));
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

export const postOrderItem = ({ quotationId, productId, quantity }) => {
	return (dispatch) => {
		return dispatch(postOrderItemCreator({ quotationId, productId, quantity }));
	};
};

