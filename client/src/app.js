import React, { Component } from 'react';
import { BrowserRouter, Redirect, Switch, Route } from 'react-router-dom';
import {
	CUSTOMERS_URI_PATTERN,
	ORDERS_URI_PATTERN,
	ORDER_URI_PATTERN,
	SIGN_IN_URI_PATTERN,
} from './routes';
import PrivateRoute from './containers/privateRoute';
import SignIn from './containers/signIn';
import SignOut from './containers/signOut';
import CustomersContainer from './containers/customersContainer';
import OrdersContainer from './containers/ordersContainer';
import OrderContainer from './containers/orderContainer';
import Header from './components/header';
import { Footer } from './components/footer';

export default class App extends Component {
	render() {
		return (
	  		<BrowserRouter>
	  			<div style={{position: 'relative', minHeight: '100%'}}>
	  				<Header>
			  			<SignOut />
			  		</Header>
	  				{ /*<ErrorStack error={error} /> */}
	  				<div className="container" style={{paddingBottom: '50px'}}>
		  				<Switch>
		  					<PrivateRoute
		  						path={CUSTOMERS_URI_PATTERN}
		  						exact
		  						component={CustomersContainer}
		  					/>
			  				<PrivateRoute
			  					path={ORDERS_URI_PATTERN}
			  					exact
			  					component={OrdersContainer}
			  				/>
			  				<PrivateRoute
			  					path={ORDER_URI_PATTERN}
			  					component={OrderContainer}
			  				/>
			  				<Route
			  					path={SIGN_IN_URI_PATTERN}
			  					exact
			  					component={SignIn}
			  				/>
			  				<Redirect from="/" to={CUSTOMERS_URI_PATTERN} />
		  				</Switch>
	  				</div>
	  				<Footer />
	  			</div>
	  		</BrowserRouter>
  		);
	}
}
