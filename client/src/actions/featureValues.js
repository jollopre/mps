import { asyncAction, API } from '../middlewares/apiMiddleware';

export const PUT_FEATURE_VALUE = asyncAction('PUT_FEATURE_VALUE');

const putFeatureValueCreator = (id, value) => ({
  type: API,
  payload: {
    url: `/api/feature_values/${id}`,
    method: 'PUT',
    types: [PUT_FEATURE_VALUE.PENDING, PUT_FEATURE_VALUE.SUCCESS, PUT_FEATURE_VALUE.ERROR],
    body: { feature_value: { value }}
  },
});

export const putFeatureValue = ({ id = null, value = null } = {}) => {
  return (dispatch, getState) => {
      return dispatch(putFeatureValueCreator(id, value));
  };
};