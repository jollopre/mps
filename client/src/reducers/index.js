import { combineReducers } from 'redux';
import { user } from './user';
import { customers } from './customers';
import { orders } from './orders';
import { orderItems } from './orderItems';
import { products } from './products';
import { pagination } from './pagination';

export const rootReducer = combineReducers({
	customers,
	orders,
	orderItems,
  products,
	user,
	pagination
});
