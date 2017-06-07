import React, { Component } from 'react';
import { Route } from 'react-router-dom';

export default class RouteWithProps extends Component {
	render() {
		const { component: Component, ...rest } = this.props;
		return (
			<Route render={ (props) => {
					return (<Component {...rest} {...props} />)
				}} 
			/>
		);
	}
}