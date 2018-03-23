import { combineReducers } from 'redux';
import { user } from './user';
import { customers } from './customers';
import { quotations } from './quotations';
import { orderItems } from './orderItems';
import { products } from './products';
import { pagination } from './pagination';

export const rootReducer = combineReducers({
	customers,
	quotations,
	orderItems,
  products,
	user,
	pagination
});
