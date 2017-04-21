import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'react-bootstrap';
import { Panel } from 'react-bootstrap';

export default class OrderShow extends Component {
	render() {
		const title = (<h3>Order {this.props.order.id}</h3>);
		const order = this.props.order;
		const customer = this.props.order.customer;
		return (
			<Panel header={title} bsStyle="success">
				<Row>
					<Col xs={6}>
						<dl className="dl-horizontal">
			  				<dt>Created At:</dt>
			  				<dd>{order.created_at}</dd>
			  				<dt>Updated At:</dt>
			  				<dd>{order.updated_at}</dd>
						</dl>
					</Col>
					<Col xs={6}>
						<Row>
							<Col xs={12}>
								<h3 className="pull-right">Customer</h3>
							</Col>
						</Row>
						<Row>
							<Col xs={12}>
								<div className="pull-right">
									<dl className="dl-horizontal">
			  							<dt>Reference</dt>
			  							<dd>{customer.reference}</dd>
									</dl>
								</div>
							</Col>
						</Row>
					</Col>
				</Row>
    		</Panel>
		);
	}
}

OrderShow.propTypes = {
	order: PropTypes.object.isRequired,
};