import { matchPath } from 'react-router'; 

export const CUSTOMERS_URI_PATTERN = '/customers';
export const CUSTOMER_URI_PATTERN = `${CUSTOMERS_URI_PATTERN}/:id/edit`;
export const QUOTATIONS_URI_PATTERN = '/customers/:id/quotations';
export const QUOTATION_URI_PATTERN = '/quotations/:id';
export const ENQUIRY_URI_PATTERN = `${QUOTATION_URI_PATTERN}/enquiries/:enquiry_id`;
export const SIGN_IN_URI_PATTERN = '/sign_in';

export const customersPath = () => {
  return CUSTOMERS_URI_PATTERN;
};
export const customer_path = ({ id }) => {
  return CUSTOMER_URI_PATTERN.replace(/:id/, id);
};

export const quotations_path = ({ id }) => {
  return QUOTATIONS_URI_PATTERN.replace(/:id/, id);
};

export const quotation_path = ({ id } = {}) => {
  return QUOTATION_URI_PATTERN.replace(/:id/, id);
};

export const quotation_enquiry_path = ({ id, enquiry_id } = {}) => {
  return ENQUIRY_URI_PATTERN.replace(/([^:]+)(:id)([^:]+)(:enquiry_id)/, (match, p1, p2, p3, p4) => {
    return `${p1}${id}${p3}${enquiry_id}`;
  });
};

/*
 * This lets you use the same matching code that <Route> uses
 * except outside of the normal render cycle. It becomes useful
 * for when parent Route wants to access to params only available
 * in child matched
 * @param location {String} - Represents where the app is now
 * @param uri_pattern {String} - One of the constants defined above (e.g. ENQUIRY_URI_PATTERN)
 * return match object if location matches uri_pattern, otherwise null
 */

const match_from_location = (location, uri_pattern) => {
  return matchPath(location, {
    path: uri_pattern,
    exact: true,
    strict: false,
  });
};

export const quotation_enquiry_match = (location) => {
  return match_from_location(location, ENQUIRY_URI_PATTERN);
};

/* 
 * Given an URL and a paramName, this methods attemps to get the value associated
 * @param URL {String} - Represents an URL
 * @param paramName {String} - Represents the query param to look for within the URL
 * return {String} value associated to the queryParam, otherwise null
 */
export const getQueryParam = (URL, paramName) => {
  const regExp = RegExp(paramName+'=(\\d+)');
  const re = regExp.exec(URL);
  if (re !== null) {
    return re[1];
  }
  return null;
};
