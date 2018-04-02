import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { quotation_enquiry_path } from '../../routes';

export default class ListItem extends Component {
	render() {
		const { enquiry, product, active } = this.props;
		return (
			<Link to={quotation_enquiry_path({
				id: enquiry.quotation_id,
				enquiry_id: enquiry.id })}
				className={`list-group-item ${active === enquiry.id ? 'active' : ''}`}>
				<span className="badge">
					{enquiry.quantity}
				</span>
				{product.name}
			</Link>
		); 
	}
}

ListItem.propTypes = {
	enquiry: PropTypes.object.isRequired,
	product: PropTypes.object.isRequired,
	active: PropTypes.number.isRequired,
};