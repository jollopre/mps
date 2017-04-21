import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Typeahead } from 'react-bootstrap-typeahead';

export default class FeatureOption extends Component {
	constructor(props) {
		super(props);
		const value = this.props.feature_value.value !== null ? 
			[this.props.feature.feature_options[this.props.feature_value.value]] :
			[];
		this.state = { value }; 
		this.onChange = this.onChange.bind(this);
		this.feature_options = Object.keys(this.props.feature.feature_options)
			.reduce((acc, key) => {
				return acc.concat(this.props.feature.feature_options[key])
			}, []);
	}
	/*
		Invoked when selection changes
		@selectedItems is always an array of selections, even if multi-selection is not enabled
	*/
	onChange(selectedItems){
		this.setState({ value: selectedItems });
		const selected = selectedItems[0];	// { id: number, name: string }
		this.props.onChangeFeatureValue(
			this.props.feature_value.order_item_id,
			this.props.feature_value.id,
			selected.id);
	}
	render() {
		return (
			<div className="form-group">
				<label>{this.props.feature.feature_label.name}</label>
				<Typeahead
					onChange={this.onChange}
					options={this.feature_options}
					placeholder="Choose an option..."
					labelKey="name"
					name={`FeatureOption${this.props.feature.id}`}
					selected={this.state.value}
				/>
			</div>
		);	
	}
}

FeatureOption.propTypes = {
	feature: PropTypes.object.isRequired,
	feature_value: PropTypes.object.isRequired,
	onChangeFeatureValue: PropTypes.func.isRequired,
}