import {
  GET_SUPPLIERS
} from '../actions/suppliers';
import { suppliers } from './suppliers';

it('GET_SUPPLIERS.PENDING', () => {
  const state = { byId: {}, isFetching: false };
  const action = { type: GET_SUPPLIERS.PENDING };

  const actual = suppliers(state, action);

  expect(actual).toEqual({ byId: {}, isFetching: true });
});

it('GET_SUPPLIERS.SUCCESS', () => {
  const state = { byId: {}, isFetching: false };
  const action = { type: GET_SUPPLIERS.SUCCESS, payload: [{ id: 1 }] };

  const actual = suppliers(state, action);

  expect(actual).toEqual({ byId: { 1: { id: 1} }, isFetching: false });
});

it('GET_SUPPLIERS.ERROR', () => {
  const state = { byId: {}, isFetching: true };
  const action = { type: GET_SUPPLIERS.ERROR };

  const actual = suppliers(state, action);

  expect(actual).toEqual({ byId: {}, isFetching: false });
});

