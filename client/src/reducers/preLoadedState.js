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
		quotations: {
			byId: {},
			isFetching: false,
		},
		enquiries: {
			byId: {},
			isFetching: false,
			objectURL: null, // Represents the URL of the latest pdf exported
		},
		products: {
			byId: {},
			isFetching: false,
		},
		pagination: {
			quotations: {
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