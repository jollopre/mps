import { UserLocalStorage } from '../utils/userLocalStorage';
import {
	POST_SIGN_IN,
	DELETE_SIGN_OUT
} from '../actions/user';

export const user = (state = { isFetching: false, email:null, token: null }, action) => {
	const { type, payload } = action;
	switch (type) {
		case POST_SIGN_IN.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case POST_SIGN_IN.SUCCESS:
			UserLocalStorage.setEntries({ token: payload.token });
			return {
				...state,
				isFetching: false,
				token: payload.token,
			};
		case POST_SIGN_IN.ERROR:
			return {
				...state,
				isFetching: false,
			}
		case DELETE_SIGN_OUT.PENDING:
			return {
				...state,
				isFetching: true,
			};
		case DELETE_SIGN_OUT.SUCCESS:
			UserLocalStorage.removeEntries();
			return {
				isFetching: false,
				token: null,
			};
		case DELETE_SIGN_OUT.ERROR: 
			return {
				...state,
				isFetching: false,
			}
		default:
			return state;
	}
}