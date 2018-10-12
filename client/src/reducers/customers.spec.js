import {
  PUT_CUSTOMER
} from '../actions/customers';
import { customers } from './customers';

it('PUT_CUSTOMER.PENDING', () => {
  const state = { byId: {}, isFetching: false };
  const action = { type: PUT_CUSTOMER.PENDING };

  const actual = customers(state, action);

  expect(actual).toEqual({ byId: {}, isFetching: true });
});

it('PUT_CUSTOMER.SUCCESS', () => {
  const state = { byId: {
    1: { id: 1, company_name: 'Wadus' }
  }, isFetching: true };
  const action = { type: PUT_CUSTOMER.SUCCESS, payload: { id: 1, company_name: 'Wadus Modified' }};

  const actual = customers(state, action);

  expect(actual).toEqual({ byId: {
    1: { id: 1, company_name: 'Wadus Modified' }
  }, isFetching: false });
});

it('PUT_CUSTOMER.ERROR', () => {
  const state = { byId: {}, isFetching: true };
  const action = { type: PUT_CUSTOMER.ERROR };

  const actual = customers(state, action);

  expect(actual).toEqual({ byId: {}, isFetching: false });
});
