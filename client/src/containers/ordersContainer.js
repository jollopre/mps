import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getOrders } from '../actions/orders';
import Orders from '../components/orders';

class OrdersContainer extends Component {
	componentDidMount() {
		const { getOrders, customerId } = this.props;
		getOrders({ customerId });
	}
	render(){
		const { orders, isFetching } = this.props;
        if (isFetching) {
    	   return (<p>Fetching orders...</p>);
        }
        else if (orders) {
            return (<Orders list={orders} />);
        }
        return null;    // isFetching is false and orders is null 
	}
}

const mapStateToProps = (state, ownProps) => {
    const { orders, pagination } = state;
    const currentPage = pagination.orders.currentPage;
    const ids = pagination.orders.pages[currentPage] ?
        pagination.orders.pages[currentPage].ids : null;
    const ordersFilter = ids ? ids.reduce((acc, id) => {
        return acc.concat(orders.byId[id]);
    }, []) : null;
    return {
    	...orders,
    	orders: ordersFilter,
    	customerId: ownProps.match.params.id,
    };
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrders: (params) => {
			dispatch(getOrders(params));
		},
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(OrdersContainer);