import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class OrderShow extends Component {
	render() {
		const { order } = this.props;
		return (
			<dl className="dl-horizontal">
				<dt>Created At</dt>
			  	<dd>{order.created_at}</dd>
			  	<dt>Updated At</dt>
			  	<dd>{order.updated_at}</dd>
			</dl>
		);
	}
}

OrderShow.propTypes = {
	order: PropTypes.object.isRequired,
};