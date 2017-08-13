import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getOrder } from '../actions/orders';
import { getCustomer } from '../actions/customers';
import Order from '../components/order';

class OrderContainer extends Component {
	componentDidMount() {
		const { getOrder, getCustomer, orderId, order, customer } = this.props;
		getOrder(orderId);
		if (order && !customer) {
			getCustomer(order.customer_id);
		}
	}
	componentDidUpdate(prevProps) {
		const { getOrder, getCustomer, orderId, order, customer } = this.props;
		if (orderId !== prevProps.orderId) {
			getOrder(orderId);
		}
		if (order && !customer) {
			getCustomer(order.customer_id);
		}
	}
	render() {
		const { order, customer } = this.props;
		if (order && customer) {
			return (<Order order={order} customer={customer} />);
		}
		return (<p>Fetching order</p>);
	}
}

const mapStateToProps = (state, ownProps) => {
	const { orders, customers } = state;
	const { match } = ownProps;
	const order = orders.byId[match.params.id]
	return {
		orderId: match.params.id,
		order,
		customer: order ? customers.byId[order.customer_id] : undefined,
	}
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrder: (id) => {
			dispatch(getOrder(id));
		},
		getCustomer: (id) => {
			dispatch(getCustomer(id));
		},
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(OrderContainer);