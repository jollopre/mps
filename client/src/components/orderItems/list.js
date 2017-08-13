import React, { Component } from 'react';
import PropTypes from 'prop-types';
import ListItem from './listItem';

export default class List extends Component {
	render() {
		const { orderItems, products, orderItemIdActive } = this.props;
		return (
			<div className="list-group">
				{orderItems.map(o => (<ListItem
					key={o.id}
					orderItem={o}
					product={products[o.product_id]}
					active={orderItemIdActive} />))}
			</div>
		);
	}
}

List.PropTypes = {
	orderItems: PropTypes.array.isRequired,
	products: PropTypes.object.isRequired,
	orderItemIdActive: PropTypes.number.isRequired,
};