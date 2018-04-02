import { combineReducers } from 'redux';
import { user } from './user';
import { customers } from './customers';
import { quotations } from './quotations';
import { enquiries } from './enquiries';
import { products } from './products';
import { pagination } from './pagination';

export const rootReducer = combineReducers({
	customers,
	quotations,
	enquiries,
  products,
	user,
	pagination
});
