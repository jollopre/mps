import React, { Component } from 'react';
import { BrowserRouter, Route } from 'react-router-dom';
import { Routes } from '../Routes'; 

export default class RouteConfig extends Component {
	render() {
		const routeComponents = Routes.map((r, i) => {
			return (<Route key={i} exact={r.exact} path={r.path} component={r.component} />);
		});
		return (
	  		<BrowserRouter>
	  			<div>
	  				{routeComponents}
	  			</div>
	  		</BrowserRouter>
  		);
	}
}