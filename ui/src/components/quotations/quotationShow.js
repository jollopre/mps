import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class QuotationShow extends Component {
	render() {
		const { quotation } = this.props;
		return (
			<dl className="dl-horizontal">
				<dt>Created At</dt>
			  	<dd>{quotation.created_at}</dd>
			  	<dt>Updated At</dt>
			  	<dd>{quotation.updated_at}</dd>
			</dl>
		);
	}
}

QuotationShow.propTypes = {
	quotation: PropTypes.object.isRequired,
};