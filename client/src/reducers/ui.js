import {
  ADD_ENQUIRY,
  DELETE_ENQUIRY,
  RESET_ENQUIRIES
} from '../actions/ui';

import {
  POST_COMPOSED_EMAIL,
  POST_COMPOSED_EMAIL_SEND
} from '../actions/composedEmails';

export const initialState = {
  selectedEnquiries: [],
  composedEmailToSendId: null
}

export const ui = (state = initialState, action) => {

  const { type, payload } = action;

  switch (type) {
    case ADD_ENQUIRY:
      return {
        ...state,
        selectedEnquiries: state.selectedEnquiries.concat(payload.id)
      }
    case DELETE_ENQUIRY:
      const indexId = state.selectedEnquiries.indexOf(payload.id);
      if (indexId >= 0) {
        return {
          ...state,
          selectedEnquiries: [...state.selectedEnquiries.slice(0, indexId), ...state.selectedEnquiries.slice(indexId+1)]
        }
      }
      return state;
    case RESET_ENQUIRIES:
      return {
        ...state,
        selectedEnquiries: []
      };
    case POST_COMPOSED_EMAIL.SUCCESS:
      return {
        ...state,
        composedEmailToSendId: payload.id
      }
    case POST_COMPOSED_EMAIL_SEND.SUCCESS:
      return {
        ...state,
        composedEmailToSendId: null
      }
    default:
      return state;
  }
}

