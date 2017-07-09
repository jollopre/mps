import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Table, Alert } from 'react-bootstrap';
import { Link } from 'react-router-dom';

export default class CustomerList extends Component {
	render() {
		const header= (
			<tr>
				<th>REF</th>
				<th>Company Name</th>
				<th>Telephone</th>
				<th>Email</th>
				<th>Contact Name</th>
				<th>Contact Surname</th>
				<th>Actions</th>
			</tr>
		);
		const body = this.props.list.map((value) => {
			return (
				<tr key={value.id}>
					<td>{value.reference}</td>
					<td>{value.company_name}</td>
					<td>{value.telephone}</td>
					<td>{value.email}</td>
					<td>{value.contact_name}</td>
					<td>{value.contact_surname}</td>
					<td>
						<Link to={`/orders?customer_id=${value.id}`}>Orders</Link>
					</td>
				</tr>
			);
		});
		const table = (
			<Table responsive hover>
				<thead>{header}</thead>
				<tbody>{body}</tbody>
			</Table>
		);
		const dialog = (
			<Alert bsStyle="info" style={{marginTop: '1em'}}>
		    	<strong>Eeeeey!</strong> There are no customers yet.
		  	</Alert>
  		);
  		const display = this.props.list.length === 0 ? dialog : table;
		return display;
	}
}

CustomerList.propTypes = {
	list: PropTypes.array.isRequired,
};