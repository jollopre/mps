import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { quotation_path } from '../../routes';

export default class QuotationListItem extends Component {
	render() {
		const { quotation } = this.props;
		return (
			<tr key={quotation.id}>
				<td>{quotation.id}</td>
				<td>{quotation.created_at}</td>
				<td>{quotation.created_at}</td>	
				<td>
					<Link to={quotation_path({id: quotation.id})}>Show</Link>
				</td>
			</tr>
		);
	}
}

QuotationListItem.propTypes = {
	quotation: PropTypes.object.isRequired,
};