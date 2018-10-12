import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { customer_path, quotations_path } from '../../routes';

export default class ListItem extends Component {
  render() {
    const { item } = this.props;
    return (
      <tr>
        <td>{item.reference}</td>
        <td>{item.company_name}</td>
        <td>{item.telephone}</td>
        <td>{item.email}</td>
        <td>{item.contact_name}</td>
        <td>{item.contact_surname}</td>
        <td>
          <ul className="list-inline">
            <li>
              <Link to={customer_path({ id: item.id })}>Edit</Link>
            </li>
            <li>
              <Link to={quotations_path({ id: item.id })}>
                Quotations
              </Link>
            </li>
          </ul>
        </td>
      </tr>
    );
  }
}

ListItem.propTypes = {
  item: PropTypes.shape({
    id: PropTypes.number.isRequired,
    reference: PropTypes.string.isRequired,
    company_name: PropTypes.string.isRequired,
    //telephone: PropTypes.string.isRequired,
    //email: PropTypes.string.isRequired,
    contact_name: PropTypes.string.isRequired,
    //contact_surname: PropTypes.string.isRequired,
  }).isRequired,
};
