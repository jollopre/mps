import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getOrders } from '../actions/orders';
import Orders from '../components/orders';

class OrdersContainer extends Component {
	componentDidMount() {
		const { getOrders, customerId } = this.props;
		getOrders(customerId);
	}
	render(){
		const { orders } = this.props;
    return <Orders list={orders} />;
	}
}

const mapStateToProps = (state, ownProps) => {
    const { orders } = state;
    return {
    	orders: Object.keys(orders.byId).reduce((acc, id) => {
    		return acc.concat(orders.byId[id]);
    	}, []),
    	customerId: ownProps.match.params.id, 
    };
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrders: (customerId) => {
			dispatch(getOrders(customerId));
		},
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(OrdersContainer);