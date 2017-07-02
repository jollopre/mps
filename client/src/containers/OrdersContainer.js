import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderService from '../services/OrderService';
import OrderAdd from '../components/OrderAdd';
import OrderList from '../components/OrderList';
import { Grid, Row, Col } from 'react-bootstrap';
import queryString from 'query-string';

export default class OrdersContainer extends Component {
	constructor(props) {
		super(props);
		const parsed = queryString.parse(this.props.location.search);
		this.state = { list: [], customerId: parsed['customer_id'] || null };
		this.addOrder = this.addOrder.bind(this);
	}
	componentDidMount() {
		this._callServices();
	}
	componentWillReceiveProps(nextProps) {
		const parsed = queryString.parse(nextProps.location.search);
		if(parsed['customer_id'] !== this.state.customerId) {
			this.setState({ list: [], customerId: parsed['customer_id'] || null }, this._callServices);
		}
	}
	addOrder(){
		OrderService.create(this.state.customerId).then((data) => {
			this.setState({ list: this.state.list.concat(data)})
		}, this.props.httpErrorHandler);
	}
	_callServices() {
		OrderService.index(this.state.customerId).then(
			data => this.setState({ list: data }),
			this.props.httpErrorHandler);
	}
	render(){
		const { list, customerId } = this.state;
		return (
			<Grid>
				<Row>
					<Col xs={4} xsOffset={8}>
						{customerId ? <OrderAdd add={this.addOrder} /> : null}
					</Col>
				</Row>
				<Row>
					<Col xs={12}>
						<OrderList list={list} />
					</Col>
				</Row>
			</Grid>
		);
	}
}
OrdersContainer.propTypes = {
	httpErrorHandler: PropTypes.func.isRequired,
};