import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import OrderShow from '../orders/orderShow';
import CustomerShow from '../customers/customerShow';
import New from '../orderItems/new';
import OrderItemsContainer from '../../containers/orderItemsContainer';
import { orders_path } from '../../routes';

export default class Order extends Component {
	render() {
		const { order, customer } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-12">
						<div className="pull-right" style={{ marginBottom: '10px' }}>
							<Link
								to={orders_path({ id: customer.id })}
								className="btn btn-default"
								role="button">
								Back to Orders
							</Link>
						</div>
					</div>
				</div>
				<div className="row">
					<div className="col-xs-12">
						<div className="panel panel-success">
						  <div className="panel-heading">
						    <h3 className="panel-title">{`Order ${order.id}`}</h3>
						  </div>
						  <div className="panel-body">
						    <div className="pull-left">
						    	<OrderShow order={order} />
						    </div>
						    <div className="pull-right">
						    	<CustomerShow customer={customer} />
						    </div>
						    <div className="row">
									<div className="col-xs-12">
										<div className="pull-right">
											{<New orderId={order.id} />}
										</div>
									</div>
								</div>
								<div className="row">
									<div className="col-xs-12">
										{<OrderItemsContainer />}
									</div>
								</div>
						  </div>
						</div>
					</div>
				</div>
			</div>
		);
	}
}

Order.PropTypes = {
	order: PropTypes.object.isRequired,
	customer: PropTypes.object.isRequired,
};