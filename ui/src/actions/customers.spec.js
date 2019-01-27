import {
  putCustomerCreator
} from './customers';

it('returns putCustomer action', () => {
  const action = putCustomerCreator(1, {
    email: 'wadus@nowhere.com'
  });

  expect(action).toEqual({
    type: 'API',
    payload: {
      url: '/api/customers/1',
      method: 'PUT',
      body: {
        email: 'wadus@nowhere.com'
      },
      types: [
        'PUT_CUSTOMER_PENDING',
        'PUT_CUSTOMER_SUCCESS',
        'PUT_CUSTOMER_ERROR'
      ]
    }
  });
});
