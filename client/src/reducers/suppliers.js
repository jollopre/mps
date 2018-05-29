import { GET_SUPPLIERS } from '../actions/suppliers';

const arrayToMap = (array) => array.reduce((acc, value) => {
	acc[value.id] = value;
	return acc;
}, {});

export const suppliers = (state = { byId: {}, isFetching: false }, action) => {
  const { type, payload } = action;

  switch (type) {
    case GET_SUPPLIERS.PENDING:
      return {
        ...state,
        isFetching: true,
      };
    case GET_SUPPLIERS.SUCCESS:
      return {
        ...state,
        byId: Object.assign({}, state.byId, arrayToMap(payload)),
        isFetching: false
      };
    case GET_SUPPLIERS.ERROR:
      return {
        ...state,
        isFetching: false
      };
    default:
      return state;
  }
};
