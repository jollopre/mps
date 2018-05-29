import {
  getSuppliersCreator
} from './suppliers';

it('returns getSuppliers action', () => {
  const action = getSuppliersCreator();

  expect(action).toEqual({
    type: 'API',
    payload: {
      url: '/api/suppliers',
      method: 'GET',
      types: ['GET_SUPPLIERS_PENDING',
      'GET_SUPPLIERS_SUCCESS',
      'GET_SUPPLIERS_ERROR']
    }
  });
});

