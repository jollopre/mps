import {
  GET_PRODUCTS
} from '../actions/products';

const arrayToMap = (array) => array.reduce((acc, value) => {
  acc[value.id] = value;
  return acc;
}, {});

export const products = (state = { byId: {}, isFetching: false }, action) => {
  const { type, payload } = action;
  switch (type) {
    case GET_PRODUCTS.PENDING:
      return {
        ...state,
        isFetching: true
      };
    case GET_PRODUCTS.SUCCESS:
      return {
        ...state,
        byId: arrayToMap(payload),
        isFetching: false
      };
    case GET_PRODUCTS.ERROR:
      return {
        ...state,
        isFetching: false
      };
    default: 
      return state;
  }
}