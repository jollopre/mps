import React, { Component } from 'react';
import { BrowserRouter, Redirect, Switch, Route } from 'react-router-dom';
import {
	CUSTOMERS_URI_PATTERN,
	QUOTATIONS_URI_PATTERN,
	QUOTATION_URI_PATTERN,
	SIGN_IN_URI_PATTERN,
} from './routes';
import PrivateRoute from './containers/privateRoute';
import SignIn from './containers/signIn';
import SignOut from './containers/signOut';
import CustomersContainer from './containers/customersContainer';
import QuotationsContainer from './containers/quotationsContainer';
import QuotationContainer from './containers/quotationContainer';
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
	  				<div className="container" style={{paddingBottom: '50px'}}>
		  				<Switch>
		  					<PrivateRoute
		  						path={CUSTOMERS_URI_PATTERN}
		  						exact
		  						component={CustomersContainer}
		  					/>
			  				<PrivateRoute
			  					path={QUOTATIONS_URI_PATTERN}
			  					exact
			  					component={QuotationsContainer}
			  				/>
			  				<PrivateRoute
			  					path={QUOTATION_URI_PATTERN}
			  					component={QuotationContainer}
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
