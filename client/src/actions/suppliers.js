import { asyncAction, API } from '../middlewares/apiMiddleware';

export const GET_SUPPLIERS = asyncAction('GET_SUPPLIERS');

export const getSuppliersCreator = () => ({
  type: API,
  payload: {
    url: '/api/suppliers',
    method: 'GET',
    types: [GET_SUPPLIERS.PENDING, GET_SUPPLIERS.SUCCESS, GET_SUPPLIERS.ERROR]
  }
});

const shouldGetSuppliers = state => true ;

export const getSuppliers = () => {
  return (dispatch, getState) => {
    if (shouldGetSuppliers(getState())) {
      return dispatch(getSuppliersCreator());
    }
    return Promise.resolve();
  }
}
