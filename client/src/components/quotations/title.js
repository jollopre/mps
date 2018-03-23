import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { getCustomer } from '../../actions/customers';

class Title extends Component {
	componentDidMount() {
		const { customerId, getCustomer } = this.props;
		getCustomer(customerId);
	}
	render() {
		const { customer } = this.props;
		return (
			<h2>{`${customer.reference ? customer.reference : '...'}'s Quotations`}</h2>
		);
	}
}

const mapStateToProps = (state, ownProps) => {
	const { customers } = state;
	const customerId = ownProps.match.params.id;
	return {
		customerId,
		customer: customers.byId[customerId] ? customers.byId[customerId] : {},
	};
};
const mapDispatchToProps = (dispatch) => {
	return {
		getCustomer: (id) => {
			dispatch(getCustomer(id));
		},
	};
};

Title.propTypes = {
	customerId: PropTypes.string.isRequired,
	customer: PropTypes.object.isRequired,
	getCustomer: PropTypes.func.isRequired,
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Title));
