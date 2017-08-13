import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { postOrder } from '../../actions/orders';

class OrderAdd extends Component {
	constructor(props) {
		super(props);
		this.submitHandler = this.submitHandler.bind(this);
	}
	submitHandler(e) {
		e.preventDefault();
		const { postOrder, customerId } = this.props;
		postOrder(customerId);
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
	return {
		customerId: ownProps.match.params.id,
	};
};
const mapDispatchToProps = (dispatch) => {
	return {
		postOrder: (customerId) => {
			dispatch(postOrder(customerId));
		},
	};
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(OrderAdd));