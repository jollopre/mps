import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import queryString from 'query-string';
import { getCustomers, searchCustomers } from '../../actions/customers';
import { setPage, CUSTOMERS } from '../../actions/pagination';
import Pagination from '../pagination';

class Pages extends Component {
	constructor(props) {
		super(props);
		this.onPageChangeHandler = this.onPageChangeHandler.bind(this);
	}
	onPageChangeHandler(currentPage) {
		const { getCustomers, searchCustomers, setPage, term } = this.props;
		if (term) {
			searchCustomers({ term, page: currentPage });
		} else {
			getCustomers({ page: currentPage });
		}
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
}

const mapStateToProps = (state, ownProps) => {
	const { customers, pagination } = state;
	const queryObject = queryString.parse(ownProps.location.search);
	return {
		meta: customers.meta,
		initialPage: pagination.customers.currentPage,
		term: queryObject.search,
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getCustomers: (params) => {
			dispatch(getCustomers(params));
		},
		searchCustomers: (params) => {
			dispatch(searchCustomers(params));
		},
		setPage: (params) => {
			dispatch(setPage(params));
		},
 	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Pages));