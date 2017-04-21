import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { FormGroup, ControlLabel, FormControl } from 'react-bootstrap';

export default class Quantity extends Component {
	constructor(props) {
		super(props);
		this.state = { value: this.props.quantity };
		this.onChange = this.onChange.bind(this);
	}
	onChange(event) {
		// TODO validate is integer value
		const value = event.target.value;
		this.setState({ value });
		this.props.onChangeOrderItemQuantity(
			this.props.id,
			value*1);
	}
	render() {
		return (
			<FormGroup
				controlId={`Quantity${this.props.id}`}
			>
				<ControlLabel>Quantity</ControlLabel>
				<FormControl
					type="number"
					value={this.state.value}
					placeholder="Enter an Integer number"
					onChange={this.onChange}
				/>
			</FormGroup>
		);
	}
}

Quantity.propTypes = {
	id: PropTypes.number.isRequired,
	quantity: PropTypes.number.isRequired,
	onChangeOrderItemQuantity: PropTypes.func.isRequired,
}