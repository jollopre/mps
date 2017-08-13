import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderListItem from './orderListItem';

export default class OrderList extends Component {
	render() {
		const { list } = this.props;
		return (
			<div className="table-responsive">
				<table className="table table-hover">
					<thead>
						<tr>
							<th>#</th>
							<th>Created At</th>
							<th>Updated At</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						{list.map(order => (<OrderListItem key={order.id} order={order} />))}
					</tbody>
				</table>
			</div>
		);
	}
}

OrderList.propTypes = {
	list: PropTypes.array.isRequired,
};