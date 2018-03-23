export const SET_PAGE = 'SET_PAGE';
export const QUOTATIONS = 'QUOTATIONS';
export const CUSTOMERS = 'CUSTOMERS';

export const setPage = ({ page = 1, resource = '' } = {}) => ({
	type: SET_PAGE,
	payload: null,
	meta: { page, resource },
});