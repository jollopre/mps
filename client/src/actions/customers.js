import { asyncAction, API } from '../middlewares/apiMiddleware';

const shouldGetCustomersRequest = state => Object.keys(state.customers.byId).length === 0;

export const GET_CUSTOMERS = asyncAction('GET_CUSTOMERS');
export const GET_CUSTOMER = asyncAction('GET_CUSTOMER');

export const getCustomersCreator = () => ({
	type: API,
	payload: {
		url: '/api/customers',
		method: 'GET',
		types: [GET_CUSTOMERS.PENDING, GET_CUSTOMERS.SUCCESS, GET_CUSTOMERS.ERROR],
	},
});

export const getCustomerCreator = (id) => ({
	type: API,
	payload: {
		url: `/api/customers/${id}`,
		method: 'GET',
		types: [GET_CUSTOMER.PENDING, GET_CUSTOMER.SUCCESS, GET_CUSTOMER.ERROR],
	}
});

export const getCustomers = () => {
	return (dispatch, getState) => {
		if (shouldGetCustomersRequest(getState())) {
			return dispatch(getCustomersCreator());
		}
		return Promise.resolve();		
	}
};

export const getCustomer = (id) => {
	return (dispatch) => {
		return dispatch(getCustomerCreator(id));
	}
};