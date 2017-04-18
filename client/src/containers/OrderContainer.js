import React, { Component } from 'react';
import OrderService from '../services/OrderService';

export default class OrderContainer extends Component {
	constructor(props) {
		super(props);
		this.state = { order: {} };
	}
	componentDidMount() {
		OrderService.show(this.props.match.params.id)
			.then(data => this.setState({ order: data }),
				error => console.log(error.statusText));
	}
	render() {
		return (
			<div>{JSON.stringify(this.state.order)}</div>
		);
	}
}