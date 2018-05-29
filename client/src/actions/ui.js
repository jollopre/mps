export const ADD_ENQUIRY = 'ADD_ENQUIRY';
export const DELETE_ENQUIRY = 'DELETE_ENQUIRY';
export const RESET_ENQUIRIES = 'RESET_ENQUIRIES';

export const addEnquiry = (id) => ({
  type: ADD_ENQUIRY,
  payload: { id }
});

export const deleteEnquiry = (id) => ({
  type: DELETE_ENQUIRY,
  payload: { id }
});

export const resetEnquiries = () => ({
  type: RESET_ENQUIRIES,
  payload: null
});
