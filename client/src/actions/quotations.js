import { API, asyncAction } from '../middlewares/apiMiddleware';
import { QUOTATIONS } from './pagination';

export const GET_QUOTATIONS = asyncAction('GET_QUOTATIONS');
export const GET_QUOTATION = asyncAction('GET_QUOTATION');
export const POST_QUOTATION = asyncAction('POST_QUOTATION');
export const SEARCH_QUOTATIONS = asyncAction('SEARCH_QUOTATIONS');

export const getQuotationsCreator = ({ customerId, page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/quotations?customer_id=${customerId}&page=${page}`,
		method: 'GET',
		types: [GET_QUOTATIONS.PENDING, GET_QUOTATIONS.SUCCESS, GET_QUOTATIONS.ERROR]
	},
	meta: { page, resource: QUOTATIONS },
});

export const getQuotationCreator = (id) => ({
	type: API,
	payload: {
		url: `/api/quotations/${id}`,
		method: 'GET',
		types: [GET_QUOTATION.PENDING, GET_QUOTATION.SUCCESS, GET_QUOTATION.ERROR],
	},
});

export const postQuotationCreator = ({ customerId, meta = {}} = {}) => ({
	type: API,
	payload: {
		url: '/api/quotations',
		method: 'POST',
		types: [POST_QUOTATION.PENDING, POST_QUOTATION.SUCCESS, POST_QUOTATION.ERROR],
		body: { quotation: { customer_id: customerId }},
	},
	meta
});

const searchQuotationsCreator = ({ customerId = null, term = '', page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/quotations/search/${term}?customer_id=${customerId}&page=${page}`,
		method: 'GET',
		types: [SEARCH_QUOTATIONS.PENDING, SEARCH_QUOTATIONS.SUCCESS, SEARCH_QUOTATIONS.ERROR],
	},
	meta: { page, resource: QUOTATIONS },
});

/*
 * Determines whether or not GET_CUSTOMERS request should be initiated.
 * @param state {} - Redux application state
 * @param params {} - The params object passed to getQuotations action
 * @returns true if quotations pagination sub-state for the params.page passed is not defined or
 * if the array of ids for that specific page is empty (look at src/reducers/pagination to
 * better understand the sub-state structure) or if quotations.byId object does not have an
 * quotation object whose customer_id is equals to params.customerId
*/
const shouldGetQuotationsRequest = (state, params) => {
	const { customerId, page } = params;
	const quotationsPagination = state.pagination.quotations;
	const { quotations } = state;
	return !quotationsPagination.pages[page] ||
		quotationsPagination.pages[page].ids === [] ||
		quotationsPagination.pages[page].ids.find(id => quotations.byId[id].customer_id === customerId);
};

const shouldGetQuotationRequest = (state, id) => state.quotations.byId[id] === undefined;

export const getQuotations = (params = {}) => {
	return (dispatch, getState) => {
		if (shouldGetQuotationsRequest(getState(), params)) {
			return dispatch(getQuotationsCreator(params));
		}
		return Promise.resolve();		
	};
};

export const getQuotation = (id) => {
	return (dispatch, getState) => {
		if (shouldGetQuotationRequest(getState(), id)) {
			return dispatch(getQuotationCreator(id));
		}
		return Promise.resolve();
	};
};

export const postQuotation = (params) => {
	return (dispatch) => {
		return dispatch(postQuotationCreator(params));
	};
};

export const searchQuotations = (params = {}) => {
	return (dispatch) => {
		return dispatch(searchQuotationsCreator(params));
	};
}
