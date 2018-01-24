import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getCustomers } from '../../actions/customers';
import { setPage, CUSTOMERS } from '../../actions/pagination';
import Pagination from '../pagination';

class Pages extends Component {
	constructor(props) {
		super(props);
		this.onPageChangeHandler = this.onPageChangeHandler.bind(this);
	}
	onPageChangeHandler(currentPage) {
		const { getCustomers, setPage } = this.props;
		getCustomers({ page: currentPage });
		setPage({ page: currentPage, resource: CUSTOMERS });
	}
	render() {
		const { meta, initialPage } = this.props;
		return (
			<Pagination
				count={meta.count}
				perPage={meta.per_page}
				initialPage={initialPage}
				onPageChange={this.onPageChangeHandler} />
		);
	}
	componentWillUnmount() {
		// Following code it's commented since we want to preserve
		// the customers currentPage in case she clickes Back to Orders
		// when viewing a specific order
		/*
		const { setPage } = this.props;
		setPage({ resource: CUSTOMERS }); // resets currentPage to its default value
		*/
	}
}

const mapStateToProps = (state, ownProps) => {
	const { customers, pagination } = state;
	return {
		meta: customers.meta,
		initialPage: pagination.customers.currentPage
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getCustomers: (params) => {
			dispatch(getCustomers(params));
		},
		setPage: (params) => {
			dispatch(setPage(params));
		},
 	};
};

export default connect(mapStateToProps, mapDispatchToProps)(Pages);