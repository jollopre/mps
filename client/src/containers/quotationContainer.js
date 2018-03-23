import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getQuotation } from '../actions/quotations';
import { getCustomer } from '../actions/customers';
import Quotation from '../components/quotation';

class QuotationContainer extends Component {
	componentDidMount() {
		const { getQuotation, getCustomer, quotationId, quotation, customer } = this.props;
		getQuotation(quotationId);
		if (quotation && !customer) {
			getCustomer(quotation.customer_id);
		}
	}
	componentDidUpdate(prevProps) {
		const { getQuotation, getCustomer, quotationId, quotation, customer } = this.props;
		if (quotationId !== prevProps.quotationId) {
			getQuotation(quotationId);
		}
		if (quotation && !customer) {
			getCustomer(quotation.customer_id);
		}
	}
	render() {
		const { quotation, customer } = this.props;
		if (quotation && customer) {
			return (<Quotation quotation={quotation} customer={customer} />);
		}
		return (<p>Fetching quotation</p>);
	}
}

const mapStateToProps = (state, ownProps) => {
	const { quotations, customers } = state;
	const { match } = ownProps;
	const quotation = quotations.byId[match.params.id]
	return {
		quotationId: match.params.id,
		quotation,
		customer: quotation ? customers.byId[quotation.customer_id] : undefined,
	}
};

const mapDispatchToProps = (dispatch) => {
	return {
		getQuotation: (id) => {
			dispatch(getQuotation(id));
		},
		getCustomer: (id) => {
			dispatch(getCustomer(id));
		},
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(QuotationContainer);