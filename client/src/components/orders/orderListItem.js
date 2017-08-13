import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { order_path } from '../../routes';

export default class OrderListItem extends Component {
	render() {
		const { order } = this.props;
		return (
			<tr key={order.id}>
				<td>{order.id}</td>
				<td>{order.created_at}</td>
				<td>{order.created_at}</td>	
				<td>
					<Link to={order_path({id: order.id})}>Show</Link>
				</td>
			</tr>
		);
	}
}

OrderListItem.propTypes = {
	order: PropTypes.object.isRequired,
};