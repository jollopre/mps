import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { debounce } from '../../utils/debounce';
import { putFeatureValue } from '../../actions/featureValues';

class NonOption extends Component {
	constructor(props) {
		super(props);
		this.onChangeHandler = this.onChangeHandler.bind(this);
		this.deferred = debounce(this.action.bind(this), 2000);
		const { featureValue } = this.props;
		const value = featureValue.value !== null ? featureValue.value : '';
		this.state = { value };
	}
	action() {
		const { feature, featureValue, putFeatureValue } = this.props;
		const { value } = this.state;
		if (feature.feature_type === "string"){
			putFeatureValue(featureValue.id, value);
		} else if (feature.feature_type === "integer") {
			putFeatureValue(featureValue.id, Math.ceil(value*1));
		} else if (feature.feature_type === "float") {
			putFeatureValue(featureValue.id, value*1);
		}
	}
	onChangeHandler(e) {
		const value = e.target.value;
		this.setState({ value }, this.deferred);
	}
	getType() {
		const { feature } = this.props;
		if (feature.feature_type === "integer" ||
			feature.feature_type === "float") {
			return "number";
		}
		return "string";
	}
	componentWillReceiveProps(nextProps) {
		if (nextProps.featureValue.id !== this.props.featureValue.id
			&& this.deferred.cancel()) {
			// Trigger action function before receiving new props since
			// action to change the value was deferred
			this.action();	
		}
		// This permits swaping JUST the input value for a featureValue whenever the enquiry changes
		if (nextProps.featureValue.value !== this.state.value) {
			this.setState({ value: nextProps.featureValue.value !== null ? nextProps.featureValue.value : '' });
		}
	}
	render() {
		const { feature } = this.props;
		const { value } = this.state;
		return (
			<form>
				<div className="form-group">
    			<label htmlFor={`${feature.feature_type}${feature.id}`}>{feature.feature_label.name}</label>
    			<input
    				type={this.getType()}
    				className="form-control"
    				id={`${feature.feature_type}${feature.id}`}
    				value={value}
    				placeholder={`Enter a ${feature.feature_type}`}
    				onChange={this.onChangeHandler} />
  			</div>
			</form>
		);
	}
}
const mapDispatchToProps = (dispatch) => {
	return {
		putFeatureValue: (id, value) => {
			dispatch(putFeatureValue({ id, value }));
		},
	};
};

NonOption.propTypes = {
	feature: PropTypes.object.isRequired,
	featureValue: PropTypes.object.isRequired,
}

export default connect(null, mapDispatchToProps)(NonOption);