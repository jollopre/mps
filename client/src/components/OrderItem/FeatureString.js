import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { FormGroup, ControlLabel, FormControl } from 'react-bootstrap';

export default class FeatureString extends Component {
	constructor(props) {
		super(props);
		const value = this.props.feature_value.value !== null ? this.props.feature_value.value : '';
		this.state = { value };
		this.onChange = this.onChange.bind(this);
	}
	onChange(event) {
		const value = event.target.value;
		this.setState({ value });
		this.props.onChangeFeatureValue(
			this.props.feature_value.order_item_id,
			this.props.feature_value.id,
			value);
	}
	render() {
		return (
			<FormGroup
				controlId={`FeatureText${this.props.feature.id}`}
			>
				<ControlLabel>{this.props.feature.feature_label.name}</ControlLabel>
				<FormControl
					type="text"
					value={this.state.value}
					placeholder="Enter a string"
					onChange={this.onChange}
				/>
			</FormGroup>
		);
	}
}

FeatureString.propTypes = {
	feature: PropTypes.object.isRequired,
	feature_value: PropTypes.object.isRequired,
	onChangeFeatureValue: PropTypes.func.isRequired,
}