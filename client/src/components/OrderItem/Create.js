import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { DropdownButton, MenuItem } from 'react-bootstrap';

export default class Create extends Component {
	constructor(props) {
		super(props);
		this.add = this.add.bind(this);
	}
	add(e, id) {
		e.preventDefault();
		this.props.add(id);
	}
	render() {
		const menuItems = this.props.products.map((value, i) => {
			return (
				<MenuItem key={value.id} eventKey={value.id} onClick={(e) => { this.add(e, value.id)}}>
					{value.name}
				</MenuItem>
			);
		});
		return (
			<div className="pull-right">
				<DropdownButton
					bsStyle="success"
					title="Add Order Item"
					id="dropdown-products">
					{menuItems}
				</DropdownButton>
			</div>
		);
	}
}

Create.propTypes = {
	add: PropTypes.func.isRequired,
	products: PropTypes.array.isRequired,
}