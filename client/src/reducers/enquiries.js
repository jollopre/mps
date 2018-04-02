import {
	GET_ENQUIRIES,
	GET_EXPORT_ENQUIRY,
	CLEAR_EXPORT_ENQUIRY,
	PUT_ENQUIRY,
	POST_ENQUIRY
} from '../actions/enquiries';

import { PUT_FEATURE_VALUE } from '../actions/featureValues';

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = value
	return acc;
}, {});

export const enquiries = (state = { byId: {}, isFetching: false, objectURL: null }, action) => {
	const { type, payload } = action;
	switch(type) {
		case GET_ENQUIRIES.PENDING:
		case GET_EXPORT_ENQUIRY.PENDING:
		case PUT_ENQUIRY.PENDING:
		case POST_ENQUIRY.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case GET_ENQUIRIES.ERROR:
		case GET_EXPORT_ENQUIRY.ERROR:
		case PUT_ENQUIRY.ERROR:
		case POST_ENQUIRY.ERROR:
			return {
				...state,
				isFetching: false,
			};
		case GET_ENQUIRIES.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: arrayToMap(payload),	// TODO only override byId object with new enquiries for an order without overriding everything
			};
		case GET_EXPORT_ENQUIRY.SUCCESS:
			return {
				...state,
				isFetching: false,
				objectURL: URL.createObjectURL(payload),
			}
		case CLEAR_EXPORT_ENQUIRY:
			if (state.objectURL) {
				URL.revokeObjectURL(state.objectURL);
			}
			return {
				...state,
				objectURL: null
			};
		case PUT_ENQUIRY.SUCCESS:
		case POST_ENQUIRY.SUCCESS: 
			return {
				...state,
				isFetching: false,
				byId: Object.assign(
					{},
					state.byId,
					{ [payload.id]: payload })
			};
		case PUT_FEATURE_VALUE.SUCCESS:
			const featureValues = Object.assign({}, state.byId[payload.enquiry_id].feature_values, { [payload.id]: payload });
			const enquiry = Object.assign({}, state.byId[payload.enquiry_id], { feature_values: featureValues });
			return {
				...state,
				byId: Object.assign(
					{},
					state.byId,
					{ [payload.enquiry_id]: enquiry } )
			};
		default:
			return state;
	}
};