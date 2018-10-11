import {
  DELETE_ENQUIRY
} from '../actions/enquiries';
import { enquiries } from './enquiries';

test('DELETE_ENQUIRY.PENDING', () => {
  const state = { byId: {}, isFetching: false };
  const action = { type: DELETE_ENQUIRY.PENDING };

  const actual = enquiries(state, action);

  expect(actual).toEqual({ byId: {}, isFetching: true });
});

test('DELETE_ENQUIRY.SUCCESS', () => {
  const state = { byId: { 1: {}, 2: {} }, isFetching: true };
  const action = { type: DELETE_ENQUIRY.SUCCESS, payload: { id: 1 } }

  const actual = enquiries(state, action);

  expect(actual).toEqual({ byId: { 2: {} }, isFetching: false });
});

test('DELETE_ENQUIRY.ERROR', () => {
  const state = { byId: { 1: {}, 2: {} }, isFetching: true };
  const action = { type: DELETE_ENQUIRY.ERROR, payload: null }

  const actual = enquiries(state, action);

  expect(actual).toEqual({ byId: { 1: {}, 2: {} }, isFetching: false });
});
