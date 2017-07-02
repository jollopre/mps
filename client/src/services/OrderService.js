import { FetchWrapper } from './FetchWrapper';

export default class OrderService {
	static index(customerId){
		if(customerId !== null) {
			return FetchWrapper.get(`/api/orders?customer_id=${customerId}`);
		}
		return FetchWrapper.get('/api/orders');
	}
	static show(id=1) {
		return FetchWrapper.get('/api/orders/'+id);
	}
	/*
		Create method is used to create a new Order object into the server. Since a POST
		method does not return content in its body, a new GET request is sent to the server
		with the given location header obtained from a fullfilled POST request. Note,
		that these operations (i.e. POST and GET) are chained and transparent for the
		caller of this function.
		@customerId Represents the id for a customer
		Returns a promise object that contains an Order object (if fullfilled) or
		and an object such as { status: string, statusText: string } (if rejected)
	*/
	static create(customerId) {
		return FetchWrapper.post('/api/orders', { order: { customer_id: customerId }})
			.then((response) => {
				if(response.headers.has('location')){
					const URL = response.headers.get('location');
					return FetchWrapper.get(URL);		
				}	
			});
	}
}