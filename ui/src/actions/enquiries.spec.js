import { deleteEnquiryCreator } from './enquiries';

test('returns delete action', () => {
  const action = deleteEnquiryCreator('foo')

  expect(action).toEqual({
    type: 'API',
    payload: {
      url: '/api/enquiries/foo',
      method: 'DELETE',
      types: ['DELETE_ENQUIRY_PENDING', 'DELETE_ENQUIRY_SUCCESS', 'DELETE_ENQUIRY_ERROR']
    }
  });
});
