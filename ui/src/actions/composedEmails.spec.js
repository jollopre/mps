import {
  postComposedEmailCreator,
  postComposedEmailSendCreator
} from './composedEmails';

it('returns postComposedEmail action', () => {
  const action = postComposedEmailCreator();

  expect(action).toEqual({
    type: 'API',
    payload: {
      url: '/api/composed_emails',
      method: 'POST',
      types: ['POST_COMPOSED_EMAIL_PENDING', 'POST_COMPOSED_EMAIL_SUCCESS', 'POST_COMPOSED_EMAIL_ERROR'],
      body: {
        composed_email: {
          subject: '',
          body: '',
          enquiry_ids: [],
          supplier_ids: []
        }
      }
    }
  });
});

it('returns postComposedEmailSend', () => {
  const action = postComposedEmailSendCreator(1);

  expect(action).toEqual({
    type: 'API',
    payload: {
      url: '/api/composed_emails/1/send_email',
      method: 'POST',
      types: ['POST_COMPOSED_EMAIL_SEND_PENDING', 'POST_COMPOSED_EMAIL_SEND_SUCCESS', 'POST_COMPOSED_EMAIL_SEND_ERROR'],
      body: {}
    }
  });
});

