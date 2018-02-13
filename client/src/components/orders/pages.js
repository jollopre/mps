import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { getOrders } from '../../actions/orders';
import { setPage, ORDERS } from '../../actions/pagination';
import Pagination from '../pagination';

class Pages extends Component {
	constructor(props) {
		super(props);
		this.onPageChangeHandler = this.onPageChangeHandler.bind(this);
	}
	onPageChangeHandler(currentPage) {
		const { customerId, getOrders, setPage } = this.props;
		getOrders({ customerId, page: currentPage });
		setPage({ page: currentPage, resource: ORDERS });
	}
	render() {
		const { meta, initialPage } = this.props;
		if (meta.count > 0) {
			return (
				<Pagination
					count={meta.count}
					perPage={meta.per_page}
					initialPage={initialPage}
					onPageChange={this.onPageChangeHandler} />
			);
		}
		return null;
	}
}

const mapStateToProps = (state, ownProps) => {
	const { orders, pagination } = state;
	return {
		meta: orders.meta,
		customerId: ownProps.match.params.id,
		initialPage: pagination.orders.currentPage
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getOrders: (params) => {
			dispatch(getOrders(params));
		},
		setPage: (params) => {
			dispatch(setPage(params));
		},
	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Pages));
