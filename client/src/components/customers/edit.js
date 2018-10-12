import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import InputText from './inputText';
import { customersPath } from '../../routes';

export default class Edit extends Component {
  update = (param) => {
    const { putCustomer, customer } = this.props;
    putCustomer(customer.id, param);
  }
  render() {
    const { customer } = this.props;

    return (
      <div>
        <div className="col-xs-12">
          <h2>{`Edit ${customer.reference}'s Customer`}</h2>
        </div>
        <div className="col-xs-6 col-xs-offset-3">
          <form>
            <InputText
              label="Reference"
              id="reference"
              value={customer.reference}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Company Name"
              id="company_name"
              value={customer.company_name}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Address"
              id="address"
              value={customer.address}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Telephone"
              id="telephone"
              value={customer.telephone}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Email"
              id="email"
              value={customer.email}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Contact Name"
              id="contact_name"
              value={customer.contact_name}
              onChange={this.update}>
            </InputText>
            <InputText
              label="Contact Surname"
              id="contact_surname"
              value={customer.contact_surname}
              onChange={this.update}>
            </InputText>
          </form>
        </div>
        <div className="col-xs-6 col-xs-offset-3">
          <div className="pull-right">
            <Link
              to={customersPath()}
              className="btn btn-success"
              role="button"  
              style={{ marginBottom: "15px" }}>
              Save
            </Link>
          </div>
        </div>
      </div>
    );
  }
}

Edit.propTypes = {
  customer: PropTypes.object.isRequired,
  putCustomer: PropTypes.func.isRequired,
};
