import { asyncAction, API } from '../middlewares/apiMiddleware';
import { CUSTOMERS } from './pagination';
/*
 * Determines whether or not GET_CUSTOMERS request should be initiated.
 * @param state {} - Redux application state
 * @param params {} - The params object passed to getCustomers action
 * @returns true if customer pagination sub-state for the params.page passed is not defined or
 * if the array of ids for that specific page is empty (look at src/reducers/pagination to
 * better understand the sub-state structure)
*/
const shouldGetCustomersRequest = (state, params) => {
	const { page } = params;
	const customersPagination = state.pagination.customers;
	return !customersPagination.pages[page] || customersPagination.pages[page].ids === [];
};
const shouldGetCustomerRequest = (state, id) => state.customers.byId[id] === undefined;

export const GET_CUSTOMERS = asyncAction('GET_CUSTOMERS');
export const GET_CUSTOMER = asyncAction('GET_CUSTOMER');
export const SEARCH_CUSTOMERS = asyncAction('SEARCH_CUSTOMERS');

const getCustomersCreator = ({ page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/customers?page=${page}`,
		method: 'GET',
		types: [GET_CUSTOMERS.PENDING, GET_CUSTOMERS.SUCCESS, GET_CUSTOMERS.ERROR]
	},
	meta: { page, resource: CUSTOMERS },
});

const getCustomerCreator = (id) => ({
	type: API,
	payload: {
		url: `/api/customers/${id}`,
		method: 'GET',
		types: [GET_CUSTOMER.PENDING, GET_CUSTOMER.SUCCESS, GET_CUSTOMER.ERROR],
	}
});

const searchCustomersCreator = ({ term = '', page = 1 } = {}) => ({
	type: API,
	payload: {
		url: `/api/customers/search/${term}?page=${page}`,
		method: 'GET',
		types: [SEARCH_CUSTOMERS.PENDING, SEARCH_CUSTOMERS.SUCCESS, SEARCH_CUSTOMERS.ERROR],
	},
	meta: { page, resource: CUSTOMERS },
});

export const getCustomers = (params = {}) => {
	return (dispatch, getState) => {
		if (shouldGetCustomersRequest(getState(), params)) {
			return dispatch(getCustomersCreator(params));
		}
		return Promise.resolve();		
	}
};

export const getCustomer = (id) => {
	return (dispatch, getState) => {
		if (shouldGetCustomerRequest(getState(), id)) {
			return dispatch(getCustomerCreator(id));
		}
		return Promise.resolve();
	}
};

export const searchCustomers = (params = {}) => {
	return (dispatch) => {
		return dispatch(searchCustomersCreator(params));
	};
}

