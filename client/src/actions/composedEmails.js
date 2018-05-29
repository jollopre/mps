import { API, asyncAction } from '../middlewares/apiMiddleware';

export const POST_COMPOSED_EMAIL = asyncAction('POST_COMPOSED_EMAIL');
export const POST_COMPOSED_EMAIL_SEND = asyncAction('POST_COMPOSED_EMAIL_SEND')

export const postComposedEmailCreator = ({ subject = '', body = '', enquiryIds = [], supplierIds = [] } = {}) => ({
  type: API,
  payload: {
    url: '/api/composed_emails',
    method: 'POST',
    types: [POST_COMPOSED_EMAIL.PENDING, POST_COMPOSED_EMAIL.SUCCESS, POST_COMPOSED_EMAIL.ERROR],
    body: { composed_email: {
      subject,
      body,
      enquiry_ids: enquiryIds,
      supplier_ids: supplierIds
    }}
  }
});

export const postComposedEmailSendCreator = (id) => ({
  type: API,
  payload: {
    url: `/api/composed_emails/${id}/send_email`,
    method: 'POST',
    types: [POST_COMPOSED_EMAIL_SEND.PENDING, POST_COMPOSED_EMAIL_SEND.SUCCESS, POST_COMPOSED_EMAIL_SEND.ERROR],
    body: {}
  }
});

export const postComposedEmail = (composedEmail) => {
  return dispatch => dispatch(postComposedEmailCreator(composedEmail));
};

export const postComposedEmailSend = (id) => {
  return dispatch => dispatch(postComposedEmailSendCreator(id));
}
