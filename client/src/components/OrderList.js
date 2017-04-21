import React, { Component } from 'react';
import { Table } from 'react-bootstrap';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { RoutesHelper } from '../Routes';

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
					<td>{value.created_at}</td>
					<td>{value.updated_at}</td>	
					<td>
						<Link to={RoutesHelper.order_path(`${value.id}`)}>Show</Link>
					</td>
				</tr>
			);
		});
		return (
			<Table responsive hover>
				<thead>{header}</thead>
				<tbody>{body}</tbody>
			</Table>
		);
	}
}

OrderList.propTypes = {
	list: PropTypes.array.isRequired,
};