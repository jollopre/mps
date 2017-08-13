import React, { Component } from 'react';
import { connect } from 'react-redux';
import Edit from '../components/orderItems/edit';

class OrderItemContainer extends Component {
	render() {
		const { orderItem, product } = this.props;
		if (orderItem && product) {
			return (<Edit orderItem={orderItem} product={product} />);
		}
		return null;
	}
}

const mapStateToProps = (state, ownProps) => {
	const id = ownProps.match.params.order_item_id;
	const { orderItems, products } = state;
	const orderItem = orderItems.byId[id];
	return {
		orderItem,
		product: orderItem ? products.byId[orderItem.product_id] : undefined
	};
};

export default connect(mapStateToProps, null)(OrderItemContainer);