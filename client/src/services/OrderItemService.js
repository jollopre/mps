import { FetchWrapper } from './FetchWrapper';

export default class OrderItemService {
	/*
		Create method is used to create a new OrderItem object into the server. Since a POST
		method does not return content in its body, a new GET request is sent to the server
		with the given location header obtained from a fullfilled POST request. Note,
		that these operations (i.e. POST and GET) are chained and transparent for the
		caller of this function.
		@order_id Represents the order_id param for an order
		@product_id Represents the product for which an OrderItem will be created
		Returns a promise object that contains an OrderItem object (if fullfilled) or
		and an object such as { status: string, statusText: string } (if rejected)
	*/
	static create(order_id, product_id){
		return FetchWrapper.post(`/api/orders/${order_id}/order_items`,
			{ order_item: { product_id }})
			.then((response) => {
				if(response.headers.has('location')){
					const URL = response.headers.get('location');
					return FetchWrapper.get(URL);		
				}	
			});
	}
	static update(id, quantity){
		return FetchWrapper.put(`/api/order_items/${id}`,
			{ order_item: { quantity } });
	}
	static export(id){
		return FetchWrapper.get(`/api/order_items/${id}/export`)
			.then((data) => {
				return URL.createObjectURL(data);
			});
	}
}