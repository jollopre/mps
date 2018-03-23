import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import queryString from 'query-string';
import { getQuotations, searchQuotations } from '../../actions/quotations';
import { setPage, QUOTATIONS } from '../../actions/pagination';
import Pagination from '../pagination';

class Pages extends Component {
	constructor(props) {
		super(props);
		this.onPageChangeHandler = this.onPageChangeHandler.bind(this);
	}
	onPageChangeHandler(currentPage) {
		const { customerId, getQuotations, searchQuotations, setPage, term } = this.props;
		if (term) {
			searchQuotations({ customerId, term, page: currentPage });
		} else {
			getQuotations({ customerId, page: currentPage });
		}
		setPage({ page: currentPage, resource: QUOTATIONS });
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
	const { quotations, pagination } = state;
	const queryObject = queryString.parse(ownProps.location.search);
	return {
		meta: quotations.meta,
		customerId: ownProps.match.params.id,
		initialPage: pagination.quotations.currentPage,
		term: queryObject.search,
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getQuotations: (params) => {
			dispatch(getQuotations(params));
		},
		searchQuotations: (params) => {
			dispatch(searchQuotations(params));
		},
		setPage: (params) => {
			dispatch(setPage(params));
		},
	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Pages));
