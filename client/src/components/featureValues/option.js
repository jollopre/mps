import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Typeahead } from 'react-bootstrap-typeahead';
import { connect } from 'react-redux';
import { debounce } from '../../utils/debounce';
import { putFeatureValue } from '../../actions/featureValues';

class Option extends Component {
	constructor(props) {
		super(props);
		this.onChangeHandler = this.onChangeHandler.bind(this);
		this.deferred = debounce(this.action.bind(this), 2000);
		this.state = { options: [], value: [] };
	}
	componentDidMount() {
		const { feature, featureValue } = this.props;
		const options = Object.keys(feature.feature_options)
			.reduce((acc, key) => {
				return acc.concat(feature.feature_options[key])
			}, []);
		this.setState({
			options,
			value: featureValue.value ? [feature.feature_options[featureValue.value]] : [] });
	}
	// Invoked when selection changes
	// @selectedItems is always an array of options (e.g. [{ id: number, name: string }]
	// even if multi-selection is not enabled 
	onChangeHandler(selectedItems){
		this.setState({ value: selectedItems }, this.deferred);
	}
	action(){
		const { value } = this.state;
		const { featureValue, putFeatureValue } = this.props;
		putFeatureValue(featureValue.id, value.length > 0 ? value[0].id : null); 
	}
	componentWillReceiveProps(nextProps) {
		const { feature, featureValue } = this.props;
		if (nextProps.featureValue.id !== featureValue.id
			&& this.deferred.cancel()) {
			// Trigger action function before receiving new props since
			// action to change the value was deferred
			this.action();	
		}
		// This permits swaping JUST the typeahead selected value for a featureValue whenever the enquiry changes
		if (nextProps.featureValue.value !== this.state.value) {
			this.setState({ value: nextProps.featureValue.value ? [feature.feature_options[nextProps.featureValue.value]] : [] });
		}
	}
	render() {
		const { feature } = this.props;
		const { options, value } = this.state;
		return (
			<form>
				<div className="form-group">
    			<label htmlFor={`${feature.feature_type}${feature.id}`}>{feature.feature_label.name}</label>
    			<Typeahead
						onChange={this.onChangeHandler}
						options={options}
						placeholder="Choose an option..."
						labelKey="name"
						name={`${feature.feature_type}${feature.id}`}
						selected={value}
					/>
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

Option.propTypes = {
	feature: PropTypes.object.isRequired,
	featureValue: PropTypes.object.isRequired,
}

export default connect(null, mapDispatchToProps)(Option);