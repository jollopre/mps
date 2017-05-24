import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Table, Alert } from 'react-bootstrap';
import ModalDialog from '../ModalDialog';
import Edit from './Edit';
import OrderItemService from '../../services/OrderItemService';

export default class OrderItemList extends Component {
	constructor(props) {
		super(props);
		this.state = { selectedKey: null };
		this.show = this.show.bind(this);
		this.hide = this.hide.bind(this);
	}
	show(e, key) {
		e.preventDefault();
		this.setState({ selectedKey: key });
	}
	hide() {
		this.setState({ selectedKey: null });
	}
	render() {
		const modalDialog = this.state.selectedKey !== null ?
			(
				<ModalDialog hide={this.hide}
					title={`Edit Order Item ${this.state.selectedKey}`}>
					<Edit orderItem={this.props.list[this.state.selectedKey]}
						onChangeFeatureValue={this.props.onChangeFeatureValue}
						onChangeOrderItemQuantity={this.props.onChangeOrderItemQuantity} />
				</ModalDialog>
			) : null;
		const tableBody = Object.keys(this.props.list).map((key) => {
			const value = this.props.list[key];
			return (
				<tr key={key}>
					<td>{value.id}</td>
					<td>{value.quantity}</td>
					<td>{value.product.name}</td>
					<td>
						<ul className="list-inline">
							<li>
								<a href="#" onClick={(e) => { this.show(e,key); }}>Edit</a>
							</li>
							<li>
								<a href={OrderItemService.export(value.id)} target="_blank">Pdf</a>
							</li>
						</ul>
					</td>
				</tr>
			);
		});
		const table = (
			<div>
				<Table responsive hover>
					<thead>
				      <tr>
				        <th>#</th>
				        <th>Quantity</th>
				        <th>Product</th>
				        <th>Actions</th>
				      </tr>
	    			</thead>
	    			<tbody>
	    				{tableBody}
	    			</tbody>
				</Table>
				{modalDialog}
			</div>
		);
		const dialog = (
			<Alert bsStyle="info" style={{marginTop: '1em'}}>
		    	<strong>Eeeeey!</strong> There are no order items yet.
		  	</Alert>
  		);
  		const display = Object.keys(this.props.list).length === 0 ? dialog : table;
		return display;
	}
}

OrderItemList.propTypes = {
	list: PropTypes.object.isRequired,
	onChangeFeatureValue: PropTypes.func.isRequired,
	onChangeOrderItemQuantity: PropTypes.func.isRequired,
} 