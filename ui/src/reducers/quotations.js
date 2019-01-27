import { 
	GET_QUOTATIONS,
	GET_QUOTATION,
	POST_QUOTATION,
	SEARCH_QUOTATIONS } from '../actions/quotations';
import { Format } from '../utils/format';

const formatDates = (quotation) => ({
	...quotation,
	created_at: Format.db(quotation.created_at),
	updated_at: Format.db(quotation.updated_at),
});

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = formatDates(value);
	return acc;
}, {});

export const quotations = (state = { byId: {}, isFetching: false}, action) => {
	const { type, payload } = action;
	switch(type){
		case GET_QUOTATIONS.PENDING:
		case GET_QUOTATION.PENDING:
		case POST_QUOTATION.PENDING:
		case SEARCH_QUOTATIONS.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case GET_QUOTATIONS.ERROR:
		case GET_QUOTATION.ERROR:
		case POST_QUOTATION.ERROR:
		case SEARCH_QUOTATIONS.ERROR:
			return {
				...state,
				isFetching: false,
			};
		case GET_QUOTATIONS.SUCCESS:
		case SEARCH_QUOTATIONS.SUCCESS:
			return {
				...state,
				isFetching: false,
				meta: payload.meta,
				byId: Object.assign({}, state.byId, arrayToMap(payload.data)),
			};
		case GET_QUOTATION.SUCCESS:
			return {
				...state,
				isFetching: false,
				byId: Object.assign({}, state.byId, { [payload.id]: formatDates(payload) }),
			};
		case POST_QUOTATION.SUCCESS:
			return {
				...state,
				isFetching: false,
				meta: Object.assign({}, state.meta, { count: state.meta.count + 1 }),
				byId: Object.assign({}, state.byId, { [payload.id]: formatDates(payload) }),
			};
		default:
			return state;
	}
}