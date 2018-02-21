import React, { Component } from 'react';
import { connect } from 'react-redux';
import queryString from 'query-string';
import { getOrders, searchOrders } from '../actions/orders';
import Orders from '../components/orders';
import { setPage, ORDERS } from '../actions/pagination';

class OrdersContainer extends Component {
	componentDidMount() {
		const { getOrders, customerId, searchOrders, term } = this.props;
        if (term) {
            searchOrders({ customerId, term });
        } else {
		  getOrders({ customerId });
        }
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
    componentWillUnmount() {
        const { setPage } = this.props;
        setPage({ resource: ORDERS });
    }
}

const mapStateToProps = (state, ownProps) => {
    const { orders, pagination } = state;
    const currentPage = pagination.orders.currentPage;
    const ids = pagination.orders.pages[currentPage] ?
        pagination.orders.pages[currentPage].ids : null;
    const queryObject = queryString.parse(ownProps.location.search);
    const ordersFilter = ids ? ids.reduce((acc, id) => {
        return acc.concat(orders.byId[id]);
    }, []) : null;
    return {
    	...orders,
    	orders: ordersFilter,
    	customerId: ownProps.match.params.id,
        term: queryObject.search,
    };
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrders: (params) => {
			dispatch(getOrders(params));
		},
        searchOrders: (params) => {
            dispatch(searchOrders(params));
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(OrdersContainer);