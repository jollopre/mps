import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Route, Redirect } from 'react-router-dom';
import { connect } from 'react-redux';

class PrivateRoute extends Component {
	render() {
		const { component: Component, shouldRedirect, ...rest } = this.props;
		return(
			<Route {...rest} render={ (props) => {
				return shouldRedirect ?
					(<Redirect to={{ pathname: '/sign_in', state: { from: props.location }}} />) :
					(<Component {...rest} {...props} />);
			}} />
		);
	}
}

const mapStateToProps = state => ({ shouldRedirect: state.user.token === null });

PrivateRoute.propTypes = {
	shouldRedirect: PropTypes.bool.isRequired,
};

export default connect(mapStateToProps)(PrivateRoute);