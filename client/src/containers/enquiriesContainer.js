import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, withRouter } from 'react-router';
import { getEnquiries } from '../actions/enquiries';
import { ENQUIRY_URI_PATTERN, quotation_enquiry_match } from '../routes';
import List from '../components/enquiries/list';
import EnquiryContainer from './enquiryContainer';

class EnquiriesContainer extends Component {
	componentDidMount() {
		const { getEnquiries } = this.props;
		getEnquiries(this.props.match.params.id);
	}
	componentDidUpdate(prevProps) {
		const { getEnquiries } = this.props;
		if (this.props.match.params.id !== prevProps.match.params.id) {
			getEnquiries(this.props.match.params.id);
		}
	}
	render() {
		const { enquiries, products, enquiryIdActive } = this.props;
		if (Object.keys(products).length > 0) { // products and enquiries are loaded async separately so this check is needed
			return (
				<div>
					<div className="row">
						<div className="col-xs-4">
							<List enquiries={enquiries} products={products} enquiryIdActive={enquiryIdActive} />
						</div>
						<div className="col-xs-8">
							{<Route path={ENQUIRY_URI_PATTERN} exact component={EnquiryContainer} />}
						</div>
					</div>
				</div>
			);
		}
		return null;
	}
}

const mapStateToProps = (state, ownProps) => {
	const { enquiries, products } = state;
  const { location } = ownProps;
	const arrayEnquiries = Object.keys(enquiries.byId).reduce((acc, id) => {
		return acc.concat(enquiries.byId[id])
	}, []);
	const match = quotation_enquiry_match(location.pathname) || ownProps.match;
	return {
		enquiries: arrayEnquiries,
		products: arrayEnquiries.reduce((acc, value) => {
			if (products.byId[value.product_id]) {
				acc[value.product_id] = products.byId[value.product_id]
			}
			return acc;
		}, {}),
		enquiryIdActive: match.params.enquiry_id ? Number(match.params.enquiry_id) : -1
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		getEnquiries: (quotationId) => {
			dispatch(getEnquiries(quotationId));
		},
	}
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(EnquiriesContainer));
