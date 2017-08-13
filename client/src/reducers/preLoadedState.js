import { UserLocalStorage } from '../utils/userLocalStorage';

export const preLoadedState = () => {
	const User = UserLocalStorage.getEntries();
	return { 
		user: {
			token: User.token,
			isFetching: false,
		},
		customers: {
			byId: {},
			isFetching: false,
		},
		orders: {
			byId: {},
			isFetching: false,
			all: false,	// Flag to determine whether or not all the orders have been retrieved
		},
		orderItems: {
			byId: {},
			isFetching: false,
			objectURL: null, // Represents the URL of the latest pdf exported
		},
		products: {
			byId: {},
			isFetching: false,
		},
	};
};