import React, { Component } from 'react';
import { BrowserRouter, Route } from 'react-router-dom';
import OrderContainer from './containers/OrderContainer';
import OrderItemContainer from './containers/OrderItemContainer';

export default class App extends Component {
  render() {
  	return (
  		<BrowserRouter>
  			<div>
	  			<Route exact path="/order" component={OrderContainer} />
	  			<Route path="/order/:id" component={OrderItemContainer} />
  			</div>
  		</BrowserRouter>
  	);
  }
}
