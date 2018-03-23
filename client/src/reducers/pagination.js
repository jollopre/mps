import { combineReducers } from 'redux';
import { GET_QUOTATIONS, POST_QUOTATION, SEARCH_QUOTATIONS } from '../actions/quotations';
import { GET_CUSTOMERS, SEARCH_CUSTOMERS } from '../actions/customers';
import {
	SET_PAGE,
	QUOTATIONS,
	CUSTOMERS } from '../actions/pagination';

// Factory reducer to create a paginable reducer for resource actions (GET, POST, DELETE).
// An example of paginable state could be:
//
// { pages: {
//	 	1: { ids: [1,2,3,4], isFetching: false },
//		2: { ids: [5,6,7,8], isFetching: false},
//	 },
//   currentPage: 1 
// }
// which states that two distinct pages of records have been retrieved from the server (e.g. 1 and 2) and the
// currentPage for that resource should be the first of the two retrieved

const reducerFactory = () => {
	const pages = (state = {}, action) => {
		const { type, payload, meta } = action;
		switch (type) {
			case GET_QUOTATIONS.PENDING:
			case GET_CUSTOMERS.PENDING:
			case GET_QUOTATIONS.ERROR:
			case GET_CUSTOMERS.ERROR:
			case SEARCH_CUSTOMERS.ERROR:
			case SEARCH_QUOTATIONS.ERROR:
				return {
					...state,
					[meta.page] : { 
						ids: [],
						isFetching: true,
				}
			};
			case GET_QUOTATIONS.SUCCESS:
			case GET_CUSTOMERS.SUCCESS:
			case SEARCH_CUSTOMERS.SUCCESS:
			case SEARCH_QUOTATIONS.SUCCESS:
				return {
					...state,
					[meta.page] : {
						ids: payload.data.map(record => record.id),
						fetching: false,
					}
				};
			case POST_QUOTATION.SUCCESS:
				if (state[meta.page] && state[meta.page].ids.length < meta.per_page) {
					return {
						...state,
						[meta.page] : {
							ids: state[meta.page].ids.concat(payload.id),
							fetching: false,
						}
					}
				}
				return state;
			default:
				return state;
		}
	};
	const currentPage = (state = 1, action) => {
		const { type, meta } = action;
		return type === SET_PAGE ? meta.page : state;
	};
	return combineReducers({
		pages,
		currentPage
	});
}

const quotations = reducerFactory();
const customers = reducerFactory();

export const pagination = (state = { quotations: {}, customers: {}}, action) => {
	const { meta } = action;
	if (meta) {
		const { resource } = meta;
		switch (resource) {
			case QUOTATIONS:
				return {
					...state, 
					quotations: quotations(state.quotations, action)
				};
			case CUSTOMERS:
				return {
					...state,
					customers: customers(state.customers, action)
				};
			default:
				return state;
		}
	}
	return state;
}