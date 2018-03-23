import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, withRouter } from 'react-router';
import { getOrderItems } from '../actions/orderItems';
import { ORDER_ITEM_URI_PATTERN, quotation_order_item_match } from '../routes';
import List from '../components/orderItems/list';
import OrderItemContainer from './orderItemContainer';

class OrderItemsContainer extends Component {
	componentDidMount() {
		const { getOrderItems } = this.props;
		getOrderItems(this.props.match.params.id);
	}
	componentDidUpdate(prevProps) {
		const { getOrderItems } = this.props;
		if (this.props.match.params.id !== prevProps.match.params.id) {
			getOrderItems(this.props.match.params.id);
		}
	}
	render() {
		const { orderItems, products, orderItemIdActive } = this.props;
		if (Object.keys(products).length > 0) { // products and orderItems are loaded async separately so this check is needed
			return (
				<div>
					<div className="row">
						<div className="col-xs-4">
							<List orderItems={orderItems} products={products} orderItemIdActive={orderItemIdActive} />
						</div>
						<div className="col-xs-8">
							{<Route path={ORDER_ITEM_URI_PATTERN} exact component={OrderItemContainer} />}
						</div>
					</div>
				</div>
			);
		}
		return null;
	}
}

const mapStateToProps = (state, ownProps) => {
	const { orderItems, products } = state;
	const arrayOrderItems = Object.keys(orderItems.byId).reduce((acc, id) => {
		return acc.concat(orderItems.byId[id])
	}, []);
	const match = quotation_order_item_match(location.pathname) || ownProps.match;
	return {
		orderItems: arrayOrderItems,
		products: arrayOrderItems.reduce((acc, value) => {
			if (products.byId[value.product_id]) {
				acc[value.product_id] = products.byId[value.product_id]
			}
			return acc;
		}, {}),
		orderItemIdActive: match.params.order_item_id ? Number(match.params.order_item_id) : -1
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrderItems: (quotationId) => {
			dispatch(getOrderItems(quotationId));
		},
	}
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(OrderItemsContainer));