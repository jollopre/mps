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
		pagination: {
			orders: {
				pages: {},
				currentPage: 1,
			},
			customers: {
				pages: {},
				currentPage: 1,
			},
		},
	};
};