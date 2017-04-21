import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { FormGroup, ControlLabel, FormControl } from 'react-bootstrap';

export default class FeatureInteger extends Component {
	constructor(props) {
		super(props);
		const value = this.props.feature_value.value !== null ? this.props.feature_value.value : '';
		this.state = { value };
		this.onChange = this.onChange.bind(this);
	}
	onChange(event) {
		// TODO validate is integer value
		const value = event.target.value;
		this.setState({ value });
		this.props.onChangeFeatureValue(
			this.props.feature_value.order_item_id,
			this.props.feature_value.id,
			value*1);
	}
	render() {
		return (
			<FormGroup
				controlId={`FeatureInteger${this.props.feature.id}`}
			>
				<ControlLabel>{this.props.feature.feature_label.name}</ControlLabel>
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

FeatureInteger.propTypes = {
	feature: PropTypes.object.isRequired,
	feature_value: PropTypes.object.isRequired,
	onChangeFeatureValue: PropTypes.func.isRequired,
}