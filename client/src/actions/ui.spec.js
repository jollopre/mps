import {
  ADD_ENQUIRY,
  DELETE_ENQUIRY,
  RESET_ENQUIRIES,
  addEnquiry,
  deleteEnquiry,
  resetEnquiries } from './ui';

it('returns addEnquiry action', () => {
  expect(addEnquiry(1)).toEqual({ type: ADD_ENQUIRY, payload: { id: 1 }});
});

it('returns deleteEnquiry action', () => {
  expect(deleteEnquiry(1)).toEqual({ type: DELETE_ENQUIRY, payload: { id: 1 }});
});

it('returns resetEnquiries action', () => {
  expect(resetEnquiries()).toEqual({ type: RESET_ENQUIRIES, payload: null });
});
