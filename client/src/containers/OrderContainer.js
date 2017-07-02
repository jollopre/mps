import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderService from '../services/OrderService';
import OrderItemService from '../services/OrderItemService';
import ProductService from '../services/ProductService';
import FeatureValueService from '../services/FeatureValueService';
import OrderShow from '../components/OrderShow';
import Create from '../components/OrderItem/Create';
import List from '../components/OrderItem/List';
import Utils from '../Utils';
import { Grid, Row, Col } from 'react-bootstrap';

export default class OrderContainer extends Component {
	constructor(props) {
		super(props);
		this.state = { order: null, products:null };
		this.addOrderItem = this.addOrderItem.bind(this);
		this.onChangeFeatureValue = Utils.debounce(this.onChangeFeatureValue.bind(this), 1000);
		this.onChangeOrderItemQuantity = Utils.debounce(this.onChangeOrderItemQuantity.bind(this), 1000);
		this.exportPdf = this.exportPdf.bind(this);
	}
	addOrderItem(product_id) {
		OrderItemService.create(this.state.order.id, product_id)
			.then((data) => {
				const order_items = JSON.parse(
					JSON.stringify(
						this.state.order.order_items));
				order_items[data.id] = data;
				this.setState({
					order: Object.assign({}, this.state.order, { order_items })
				});
			}, this.props.httpErrorHandler);
	}
	exportPdf(id) {
		OrderItemService.export(id).then(URL => {
			const link = document.createElement('a');
            link.href=URL;
            link.download=`order_item_${id}.pdf`
            link.click();
		}, this.props.httpErrorHandler);
	}
	onChangeFeatureValue(order_item_id, id, value) {
		FeatureValueService.update(id, value)
			.then(() => {
				// Deep cloning order_items to avoid mutations
				const order_items = JSON.parse(
					JSON.stringify(
						this.state.order.order_items));
				// Change value for the feature of the order_item
				order_items[order_item_id].feature_values[id].value = value;
				// Merging objects with same properties into a new object
				this.setState({
					order: Object.assign({}, this.state.order, { order_items })
				});
			}, this.props.httpErrorHandler);
	}
	onChangeOrderItemQuantity(order_item_id, quantity) {
		OrderItemService.update(order_item_id, quantity)
			.then(() => {
				const order_items = JSON.parse(
					JSON.stringify(
						this.state.order.order_items));
				order_items[order_item_id].quantity = quantity;
				this.setState({
					order: Object.assign({}, this.state.order, { order_items })
				});
			}, this.props.httpErrorHandler);
	}
	componentDidMount() {
		OrderService.show(this.props.match.params.id)
			.then(data => this.setState({ order: data }),
				this.props.httpErrorHandler);
		ProductService.index()
			.then(data => this.setState({ products: data}),
				this.props.httpErrorHandler);
	}
	componentWillUpdate(nextProps, nextState){
		//console.log('state.order: %o', this.state.order);
		//console.log('nextState.order: %o', nextState.order);
	}
	render() {
		const OrderShowDisplay = this.state.order !== null ?
			(<OrderShow order={this.state.order} />) : null;
		const CreateDisplay = this.state.products !== null ?
			(<Create add={this.addOrderItem} products={this.state.products} />) : null;
		const ListDisplay = this.state.order !== null ?
			(<List list={this.state.order.order_items}
				onChangeFeatureValue={this.onChangeFeatureValue}
				onChangeOrderItemQuantity={this.onChangeOrderItemQuantity}
				exportPdf={this.exportPdf} />) : null;
		return (
			<Grid>
				<Row>
					<Col xs={12}>
						{OrderShowDisplay}
					</Col>
				</Row>
				<Row>
					<Col xs={4} xsOffset={8}>
						{CreateDisplay}
					</Col>
				</Row>
				<Row>
					<Col xs={12}>
						{ListDisplay}
					</Col>
				</Row>
			</Grid>
		);
	}
}
OrderContainer.propTypes = {
	httpErrorHandler: PropTypes.func.isRequired,
};