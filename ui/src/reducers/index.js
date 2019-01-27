import { combineReducers } from 'redux';
import { user } from './user';
import { customers } from './customers';
import { quotations } from './quotations';
import { enquiries } from './enquiries';
import { products } from './products';
import { suppliers } from './suppliers';
import { pagination } from './pagination';
import { ui } from './ui';

export const rootReducer = combineReducers({
  customers,
  enquiries,
  pagination,
  products,
  quotations,
  suppliers,
  ui,
  user
});
