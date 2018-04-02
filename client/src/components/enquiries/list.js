import React, { Component } from 'react';
import PropTypes from 'prop-types';
import ListItem from './listItem';

export default class List extends Component {
	render() {
		const { enquiries, products, enquiryIdActive } = this.props;
		return (
			<div className="list-group">
				{enquiries.map(o => (<ListItem
					key={o.id}
					enquiry={o}
					product={products[o.product_id]}
					active={enquiryIdActive} />))}
			</div>
		);
	}
}

List.PropTypes = {
	enquiries: PropTypes.array.isRequired,
	products: PropTypes.object.isRequired,
	enquiryIdActive: PropTypes.number.isRequired,
};