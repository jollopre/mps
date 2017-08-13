import { API, asyncAction } from '../middlewares/apiMiddleware';

const shouldPostSignInRequest = state => state.user.token === null;
const shouldDeleteSignOutRequest = state => !shouldPostSignInRequest(state);

export const POST_SIGN_IN = asyncAction('POST_SIGN_IN');
export const DELETE_SIGN_OUT = asyncAction('DELETE_SIGN_OUT');

export const postSignInCreator = ({ email = null, password = null} = {}) => ({
	type: API,
	payload: {
		url: '/api/sign-in',
		method: 'POST',
		types: [POST_SIGN_IN.PENDING, POST_SIGN_IN.SUCCESS, POST_SIGN_IN.ERROR],
		body: { user: { email, password }},
	},
});

export const deleteSignOutCreator = () => ({
	type: API,
	payload: {
		url: '/api/sign-out',
		method: 'DELETE',
		types: [DELETE_SIGN_OUT.PENDING, DELETE_SIGN_OUT.SUCCESS, DELETE_SIGN_OUT.ERROR],
	}
});

export const postSignIn = ({ email = null, password = null} = {}) => {
	return (dispatch, getState) => {
		if (shouldPostSignInRequest(getState())) {
			dispatch(postSignInCreator({ email, password }));
		}
		return Promise.resolve();
	};
};

export const deleteSignOut = () => {
	return (dispatch, getState) => {
		if (shouldDeleteSignOutRequest(getState())) {
			dispatch(deleteSignOutCreator());
		}	
		return Promise.resolve();
	}
}