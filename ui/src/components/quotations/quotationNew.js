import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { postQuotation } from '../../actions/quotations';
import { setPage, QUOTATIONS } from '../../actions/pagination';

class QuotationAdd extends Component {
	constructor(props) {
		super(props);
		this.submitHandler = this.submitHandler.bind(this);
	}
	submitHandler(e) {
		e.preventDefault();
		const { postQuotation, customerId, meta } = this.props;
		postQuotation({ customerId, meta });
		setPage({ page: meta.page, resource: meta.resource });
	}
	render() {
		return (
			<form onSubmit={this.submitHandler}>
				<input className="btn btn-success" type="submit" value="Add Quotation" />
			</form>
		);
	}
}
const mapStateToProps = (state, ownProps) => {
	const { quotations, pagination } = state;
	return {
		customerId: ownProps.match.params.id,
		meta: {
			page: pagination.quotations.currentPage,
			per_page: quotations.meta.per_page,
			resource: QUOTATIONS,
		},
	};
};
const mapDispatchToProps = (dispatch) => {
	return {
		postQuotation: (params) => {
			dispatch(postQuotation(params));
		},
	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(QuotationAdd));