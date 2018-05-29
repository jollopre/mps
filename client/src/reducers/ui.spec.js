import {
  addEnquiry,
  deleteEnquiry,
  resetEnquiries } from '../actions/ui';
import { ui } from './ui';

describe('ui reducer', () => {
  const initialState = {
    selectedEnquiries: [],
    composedEmailToSendId: null
  };

  test('addsEnquiry to array', () => {
    const state = initialState;

    const action = addEnquiry(1);
    
    const nextState = { ...initialState, selectedEnquiries: [1] };
    expect(ui(state, action)).toEqual(nextState);
  });

  test('deletesEnquiry from array', () => {
    const state = initialState;

    const action = deleteEnquiry(1);
    
    expect(ui(state, action)).toEqual(initialState);
  });

  test('resetEnquiries from array', () => {
    const state = initialState; 

    const action = resetEnquiries();

    expect(ui(state, action)).toEqual(initialState);
  });

  test('updates composedEmailToSendId', () => {
    const state = initialState; 

    const action = { type: 'POST_COMPOSED_EMAIL_SUCCESS', payload: { id: 1 } };

    const nextState = { ...initialState, composedEmailToSendId: 1 };
    expect(ui(state, action)).toEqual(nextState);
  });

  test('resets composedEmailToSendId', () => {
    const state = initialState;

    const action = { type: 'POST_COMPOSED_EMAIL_SEND_SUCCESS', payload: null };

    expect(ui(state, action)).toEqual(initialState);
  });
});


