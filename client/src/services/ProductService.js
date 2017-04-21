import Fetch from './Fetch';

export default class Products {
	static index() {
		return Fetch.get('/products');
	}
}