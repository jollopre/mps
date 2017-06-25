import { FetchWrapper } from './FetchWrapper';

export default class Products {
	static index() {
		return FetchWrapper.get('/api/products');
	}
}