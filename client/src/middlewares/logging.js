export const logging = ({ getState, dispatch} ) => next => action => {
	if (process.env.NODE_ENV === 'development' &&
			typeof action !== 'function'
			&& action.type !== 'API') {
		const r = next(action);
		console.log('action: %o, state: %o', action, getState());
		return r;
	}
	next(action);
};