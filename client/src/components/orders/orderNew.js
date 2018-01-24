import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { postOrder } from '../../actions/orders';
import { setPage, ORDERS } from '../../actions/pagination';

class OrderAdd extends Component {
	constructor(props) {
		super(props);
		this.submitHandler = this.submitHandler.bind(this);
	}
	submitHandler(e) {
		e.preventDefault();
		const { postOrder, customerId, meta } = this.props;
		postOrder({ customerId, meta });
		setPage({ page: meta.page, resource: meta.resource });
	}
	render() {
		return (
			<form onSubmit={this.submitHandler}>
				<input className="btn btn-success" type="submit" value="Add Order" />
			</form>
		);
	}
}
const mapStateToProps = (state, ownProps) => {
	const { orders, pagination } = state;
	return {
		customerId: ownProps.match.params.id,
		meta: {
			page: pagination.orders.currentPage,
			per_page: orders.meta.per_page,
			resource: ORDERS,
		},
	};
};
const mapDispatchToProps = (dispatch) => {
	return {
		postOrder: (params) => {
			dispatch(postOrder(params));
		},
	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(OrderAdd));