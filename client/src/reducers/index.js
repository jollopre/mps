import { combineReducers } from 'redux';
import { user } from './user';
import { customers } from './customers';
import { orders } from './orders';
import { orderItems } from './orderItems';
import { products } from './products';

export const rootReducer = combineReducers({
	customers,
	orders,
	orderItems,
  products,
	user
});
