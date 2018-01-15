import {
	GET_ORDER_ITEMS,
	GET_EXPORT_ORDER_ITEM,
	CLEAR_EXPORT_ORDER_ITEM,
	PUT_ORDER_ITEM,
	POST_ORDER_ITEM
} from '../actions/orderItems';

import { PUT_FEATURE_VALUE } from '../actions/featureValues';

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = value
	return acc;
}, {});

export const orderItems = (state = { byId: {}, isFetching: false, objectURL: null }, action) => {
	const { type, payload } = action;
	switch(type) {
		case GET_ORDER_ITEMS.PENDING:
		case GET_EXPORT_ORDER_ITEM.PENDING:
		case PUT_ORDER_ITEM.PENDING:
		case POST_ORDER_ITEM.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case GET_ORDER_ITEMS.ERROR:
		case GET_EXPORT_ORDER_ITEM.ERROR:
		case PUT_ORDER_ITEM.ERROR:
		case POST_ORDER_ITEM.ERROR:
			return {
				...state,
				isFetching: false,
			};
		case GET_ORDER_ITEMS.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: arrayToMap(payload),	// TODO only override byId object with new orderItems for an order without overriding everything
			};
		case GET_EXPORT_ORDER_ITEM.SUCCESS:
			return {
				...state,
				isFetching: false,
				objectURL: URL.createObjectURL(payload),
			}
		case CLEAR_EXPORT_ORDER_ITEM:
			if (state.objectURL) {
				URL.revokeObjectURL(state.objectURL);
			}
			return {
				...state,
				objectURL: null
			};
		case PUT_ORDER_ITEM.SUCCESS:
		case POST_ORDER_ITEM.SUCCESS: 
			return {
				...state,
				isFetching: false,
				byId: Object.assign(
					{},
					state.byId,
					{ [payload.id]: payload })
			};
		case PUT_FEATURE_VALUE.SUCCESS:
			const featureValues = Object.assign({}, state.byId[payload.order_item_id].feature_values, { [payload.id]: payload });
			const orderItem = Object.assign({}, state.byId[payload.order_item_id], { feature_values: featureValues });
			return {
				...state,
				byId: Object.assign(
					{},
					state.byId,
					{ [payload.order_item_id]: orderItem } )
			};
		default:
			return state;
	}
};