import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderService from '../services/OrderService';
import OrderAdd from '../components/OrderAdd';
import OrderList from '../components/OrderList';
import { Grid, Row, Col } from 'react-bootstrap';

export default class OrdersContainer extends Component {
	constructor(props) {
		super(props);
		this.state = { list: [] };
		this.addOrder = this.addOrder.bind(this);
	}
	componentDidMount() {
		OrderService.index().then(
			data => this.setState({ list: data }),
			this.props.httpErrorHandler);
	}
	addOrder(){
		OrderService.create().then((data) => {
			this.setState({ list: this.state.list.concat(data)})
		}, this.props.httpErrorHandler);
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
OrdersContainer.propTypes = {
	httpErrorHandler: PropTypes.func.isRequired,
};