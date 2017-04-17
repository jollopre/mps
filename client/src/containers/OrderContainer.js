import React, { Component } from 'react';
import OrderService from '../services/OrderService';
import OrderAdd from '../components/OrderAdd';
import OrderList from '../components/OrderList';
import { Grid, Row, Col } from 'react-bootstrap';

export default class OrderContainer extends Component {
	constructor(props) {
		super(props);
		this.state = { list: [] };
		this.addOrder = this.addOrder.bind(this);
	}
	componentDidMount() {
		OrderService.index().then(
			data => this.setState({ list: data }),
			error => console.log(error.statusText));
	}
	addOrder(){
		OrderService.create(1).then(() => {
			// TODO use Array.prototype.concat instead of calling server again
			OrderService.index().then(
				data => this.setState({ list: data }),
				error => console.log(error.statusText));
		}, error => console.log(error.statusText));
	}
	render(){
		return (
			<Grid>
				<Row>
					<Col xs={4} xsOffset={8}>
						<OrderAdd add={this.addOrder} />
					</Col>
				</Row>
				<Row>
					<Col xs={12}>
						<OrderList list={this.state.list} />
					</Col>
				</Row>
			</Grid>
		);
	}
}