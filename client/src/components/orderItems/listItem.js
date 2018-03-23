import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { quotation_order_item_path } from '../../routes';

export default class ListItem extends Component {
	render() {
		const { orderItem, product, active } = this.props;
		return (
			<Link to={quotation_order_item_path({
				id: orderItem.quotation_id,
				order_item_id: orderItem.id })}
				className={`list-group-item ${active === orderItem.id ? 'active' : ''}`}>
				<span className="badge">
					{orderItem.quantity}
				</span>
				{product.name}
			</Link>
		); 
	}
}

ListItem.propTypes = {
	orderItem: PropTypes.object.isRequired,
	product: PropTypes.object.isRequired,
	active: PropTypes.number.isRequired,
};