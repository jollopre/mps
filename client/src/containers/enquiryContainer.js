import React, { Component } from 'react';
import { connect } from 'react-redux';
import Edit from '../components/enquiries/edit';

class EnquiryContainer extends Component {
	render() {
		const { enquiry, product } = this.props;
		if (enquiry && product) {
			return (<Edit enquiry={enquiry} product={product} />);
		}
		return null;
	}
}

const mapStateToProps = (state, ownProps) => {
	const id = ownProps.match.params.enquiry_id;
	const { enquiries, products } = state;
	const enquiry = enquiries.byId[id];
	return {
		enquiry,
		product: enquiry ? products.byId[enquiry.product_id] : undefined
	};
};

export default connect(mapStateToProps, null)(EnquiryContainer);