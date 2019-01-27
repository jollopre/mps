import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { deleteSignOut } from '../actions/user';

class SignOut extends Component {
	constructor(props){
		super(props);
		this.signOutHandler = this.signOutHandler.bind(this);
	}
	signOutHandler() {
		const { deleteSignOut } = this.props;
		deleteSignOut();
	}
	render() {
		const { shouldDisplay } = this.props;
		if (shouldDisplay) {
			return (
				<button
					type="button"
					className="btn btn-danger"
					onClick={this.signOutHandler}>
					Sign Out
				</button>
			);
		}
		return null;
	}
}

const mapStateToProps = state => ({ shouldDisplay: state.user.token !== null });

const mapDispatchToProps = (dispatch) => {
	return {
		deleteSignOut: () => {
			dispatch(deleteSignOut());
		}
	}
}

SignOut.propTypes = {
	shouldDisplay: PropTypes.bool.isRequired,
	deleteSignOut: PropTypes.func.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignOut);