import React, { Component } from 'react';
import { Route, Redirect } from 'react-router-dom';
import { Auth } from '../Auth';

export default class PrivateRoute extends Component {
	render() {
		const { component: Component, ...rest } = this.props; 
		return(
			<Route {...rest} render={ (props) => {
				return Auth.isAuthenticated() ? (<Component {...rest} {...props} />) :
				(<Redirect to={
					{ pathname: '/sign_in',
					  state: { from: props.location }
					}}
				/>);
			}} />
		);
	}
}