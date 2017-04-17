import React, { Component} from 'react';

export default class OrderItemContainer extends Component {
	render() {
		const message = `OrderItemContainer for order id: ${this.props.match.params.id}`
		return (
			<div>{message}</div>
		);
	}
}