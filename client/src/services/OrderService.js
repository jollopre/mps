import Fetch from './Fetch';
export default class OrderService {
	static index(customer_id = 1){
		return Fetch.get('/orders');
	}
	static show(id=1) {
		return Fetch.get('/orders/'+id);
	}
	static create(customer_id = 1) {
		return Fetch.post('/orders', { order: { customer_id }});
	}
}