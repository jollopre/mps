import { API, asyncAction } from '../middlewares/apiMiddleware';

export const GET_ENQUIRIES = asyncAction('GET_ENQUIRIES');
export const POST_ENQUIRY = asyncAction('POST_ENQUIRY');
export const PUT_ENQUIRY = asyncAction('PUT_ENQUIRY');
export const GET_EXPORT_ENQUIRY = asyncAction('GET_EXPORT_ENQUIRY');
export const CLEAR_EXPORT_ENQUIRY = 'CLEAR_EXPORT_ENQUIRY';

const getEnquiriesCreator = (quotationId) => ({
	type: API,
	payload: {
		url: `/api/quotations/${quotationId}/enquiries`,
		method: 'GET',
		types: [GET_ENQUIRIES.PENDING, GET_ENQUIRIES.SUCCESS, GET_ENQUIRIES.ERROR],
	}
});

const getExportEnquiryCreator = (enquiryId) => ({
	type: API,
	payload: {
		url: `/api/enquiries/${enquiryId}/export`,
		method: 'GET',
		types: [GET_EXPORT_ENQUIRY.PENDING, GET_EXPORT_ENQUIRY.SUCCESS, GET_EXPORT_ENQUIRY.ERROR],
	}
});

const putEnquiryCreator = (enquiryId, quantity) => ({
	type: API,
	payload: {
		url: `/api/enquiries/${enquiryId}`,
		method: 'PUT',
		types: [PUT_ENQUIRY.PENDING, PUT_ENQUIRY.SUCCESS, PUT_ENQUIRY.ERROR],
		body: { enquiry: { quantity }},
	}
});

const postEnquiryCreator = ({ quotationId = null, productId = null, quantity = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/quotations/${quotationId}/enquiries`,
		method: 'POST',
		types: [POST_ENQUIRY.PENDING, POST_ENQUIRY.SUCCESS, POST_ENQUIRY.ERROR],
		body: { enquiry: { quotation_id: quotationId, product_id: productId, quantity } },
	}
});

const shouldGetEnquiriesRequest = (state, quotationId) => {
	const keys = state.enquiries.byId;
	if (keys.length > 0) {
		return Number(quotationId) !== state.enquiries.byId[keys[0]].quotation_id;
	}
	return true;
}

export const getEnquiries = (quotationId) => {
	return (dispatch, getState) => {
		if (shouldGetEnquiriesRequest(getState(), quotationId)) {
			return dispatch(getEnquiriesCreator(quotationId));
		}
		return Promise.resolve();
	};
};

export const getExportEnquiry = (enquiryId) => {
	return (dispatch, getState) => {
		return dispatch(getExportEnquiryCreator(enquiryId));
	}
}

export const clearExportEnquiry = () => ({
	type: CLEAR_EXPORT_ENQUIRY
});

export const putEnquiry = (enquiryId, quantity) => {
	return (dispatch) => {
		return dispatch(putEnquiryCreator(enquiryId, quantity));
	};
};

export const postEnquiry = ({ quotationId, productId, quantity }) => {
	return (dispatch) => {
		return dispatch(postEnquiryCreator({ quotationId, productId, quantity }));
	};
};

