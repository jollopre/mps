import { asyncAction, API } from '../middlewares/apiMiddleware';

const shouldGetProductsRequest = state => Object.keys(state.products.byId).length === 0;

export const GET_PRODUCTS = asyncAction('GET_PRODUCTS');

const getProductsCreator = () => ({
  type: API,
  payload: {
    url: '/api/products',
    method: 'GET',
    types: [GET_PRODUCTS.PENDING, GET_PRODUCTS.SUCCESS, GET_PRODUCTS.ERROR],
  },
});

export const getProducts = () => {
  return (dispatch, getState) => {
    if (shouldGetProductsRequest(getState())) {
      return dispatch(getProductsCreator());
    }
    return Promise.resolve();
  };
};