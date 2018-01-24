export const SET_PAGE = 'SET_PAGE';
export const ORDERS = 'ORDERS';
export const CUSTOMERS = 'CUSTOMERS';

export const setPage = ({ page = 1, resource = '' } = {}) => ({
	type: SET_PAGE,
	payload: null,
	meta: { page, resource },
});