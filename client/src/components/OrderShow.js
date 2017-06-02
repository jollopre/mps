import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Customer from './Customer';
import Utils from '../Utils.js';
import { Row, Col } from 'react-bootstrap';
import { Panel } from 'react-bootstrap';

export default class OrderShow extends Component {
	render() {
		const title = (<h3>Order {this.props.order.id}</h3>);
		const order = this.props.order;
		return (
			<Panel header={title} bsStyle="success">
				<Row>
					<Col xs={6}>
						<dl className="dl-horizontal">
			  				<dt>Created At</dt>
			  				<dd>{Utils.dateToHumanReadableString(order.created_at)}</dd>
			  				<dt>Updated At</dt>
			  				<dd>{Utils.dateToHumanReadableString(order.updated_at)}</dd>
						</dl>
					</Col>
					<Col xs={6}>
						<Customer customer={this.props.order.customer} />
					</Col>
				</Row>
    		</Panel>
		);
	}
}

OrderShow.propTypes = {
	order: PropTypes.object.isRequired,
};