import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { quotation_enquiry_path } from '../../routes';

export const QuantityBadge = ({ quantity }) => {
	if (quantity > 0) {
		return (
				<span className="badge">
					{quantity}
				</span>);
	}
	return null;
}
export default class ListItem extends Component {
	render() {
		const { enquiry, product, active } = this.props;
		return (
			<Link to={quotation_enquiry_path({
				id: enquiry.quotation_id,
				enquiry_id: enquiry.id })}
				className={`list-group-item ${active === enquiry.id ? 'active' : ''}`}>
				<ul className="list-inline">
					<li>
						{product.name}
					</li>
					<li>
						<QuantityBadge quantity={enquiry.quantity} />
					</li>
					<li>
						<QuantityBadge quantity={enquiry.quantity2} />
					</li>
					<li>
						<QuantityBadge quantity={enquiry.quantity3} />
					</li>
				</ul>
			</Link>
		); 
	}
}

ListItem.propTypes = {
	enquiry: PropTypes.object.isRequired,
	product: PropTypes.object.isRequired,
	active: PropTypes.number.isRequired,
};