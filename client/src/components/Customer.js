import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class Customer extends Component {
	render(){
		const customer = this.props.customer;
		return (
			<div className="pull-right">
				<dl className="dl-horizontal">
	  				<dt>Reference</dt>
	  				<dd>{customer.reference}</dd>
	  				<dt>Company Name</dt>
	  				<dd>{customer.company_name}</dd>
	  				<dt>Address</dt>
	  				<dd>{customer.address}</dd>
	  				<dt>Telephone</dt>
	  				<dd>{customer.telephone}</dd>
	  				<dt>Email</dt>
	  				<dd>{customer.email}</dd>
	  				<dt>Contact Name</dt>
	  				<dd>{customer.contact_name}</dd>
	  				<dt>Contact Surname</dt>
	  				<dd>{customer.contact_surname}</dd>
				</dl>
			</div>
		);
	}
}

Customer.propTypes = {
	customer: PropTypes.object.isRequired,
};