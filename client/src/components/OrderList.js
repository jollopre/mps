import React, { Component } from 'react';
import { Table, Alert } from 'react-bootstrap';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { RoutesHelper } from '../Routes';
import Utils from '../Utils.js';

export default class OrderList extends Component {
	render() {
		const header = (
			<tr>
				<th>#</th>
				<th>Created At</th>
				<th>Updated At</th>
				<th>Actions</th>
			</tr>
		);
		const body = this.props.list.map((value) => {
			return (
				<tr key={value.id}>
					<td>{value.id}</td>
					<td>{Utils.dateToHumanReadableString(value.created_at)}</td>
					<td>{Utils.dateToHumanReadableString(value.updated_at)}</td>	
					<td>
						<Link to={RoutesHelper.order_path(`${value.id}`)}>Show</Link>
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
		    	<strong>Eeeeey!</strong> There are no orders yet.
		  	</Alert>
  		);
  		const display = this.props.list.length === 0 ? dialog : table;
		return display;
	}
}

OrderList.propTypes = {
	list: PropTypes.array.isRequired,
};