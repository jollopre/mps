import React, { Component } from 'react';
import { BrowserRouter, Redirect, Switch } from 'react-router-dom';
import OrdersContainer from './containers/OrdersContainer';
import OrderContainer from './containers/OrderContainer';
import SignIn from './containers/SignIn';
import SignOut from './containers/SignOut';
import ErrorStack from './containers/ErrorStack';
import PrivateRoute from './components/PrivateRoute';
import RouteWithProps from './components/RouteWithProps';
import { Auth } from './Auth';

export default class App extends Component {
	constructor(props){
		super(props);
		this.state = { isAuthenticated: Auth.isAuthenticated(), error: null };
		this.setIsAuthenticated = this.setIsAuthenticated.bind(this);
		this.httpErrorHandler = this.httpErrorHandler.bind(this);
	}
	setIsAuthenticated(value) {
		this.setState({ isAuthenticated: value });
	}
	httpErrorHandler(error){
		if(error.status === 401) {	// Unauthorized
			if(this.state.isAuthenticated){
				Auth.invalidateToken();
				this.setState({ isAuthenticated: false, error });
			}
		}
		else{
			this.setState({ error });
		}
	}
	render() {
		const { isAuthenticated, error } = this.state;
		return (
	  		<BrowserRouter>
	  			<div>
	  				<div className="pull-right">
	  					{
	  						isAuthenticated ? 
	  							<SignOut 
	  								callback={this.setIsAuthenticated}
	  								httpErrorHandler={this.httpErrorHandler} 
	  							/> : 
	  							null
	  					}
	  				</div>
	  				<ErrorStack error={error} />
	  				<Switch>
		  				<PrivateRoute
		  					path="/orders"
		  					exact
		  					component={OrdersContainer}
		  					httpErrorHandler={this.httpErrorHandler} 
		  				/>
		  				<PrivateRoute
		  					path="/orders/:id"
		  					exact
		  					component={OrderContainer}
		  					httpErrorHandler={this.httpErrorHandler}
		  				/>
		  				{
		  					isAuthenticated ? 
			  					null : 
				  				<RouteWithProps 
				  					path="/sign_in"
				  					exact
				  					component={SignIn}
				  					callback={this.setIsAuthenticated}
				  					httpErrorHandler={this.httpErrorHandler} 
				  				/>
		  				}
		  				<Redirect from="/" to="/orders" />
	  				</Switch>
	  			</div>
	  		</BrowserRouter>
  		);
	}
}
