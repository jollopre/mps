import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { debounce } from '../../utils/debounce';
import { putEnquiry } from '../../actions/enquiries';

class Quantity extends Component {
	constructor(props) {
		super(props);
		this.onChangeHandler = this.onChangeHandler.bind(this);
		this.deferred = debounce(this.action.bind(this), 2000);
		this.state = { value: this.props.value };
	}
	action() {
		const { id, name, putEnquiry } = this.props;
		if (this.state.value >= 0) {
			putEnquiry(id, { [name]: this.state.value*1 } );
		}
	}
	onChangeHandler(e) {
		const value = e.target.value;
		this.setState({ value }, this.deferred);
	}
	componentWillReceiveProps(nextProps) {
		if (nextProps.id !== this.props.id && this.deferred.cancel()) {
			// Trigger action function before receiving new props since
			// action to change the value was deferred
			this.action();	
		}
		if (nextProps.value !== this.props.value) {
			this.setState({ value: nextProps.value });
		}
	}
	render() {
		const { id } = this.props;
		const { value } = this.state;
		return (
			<form>
				<div className="form-group">
    			<label htmlFor={`quantity${id}`}>Quantity</label>
    			<input
    				type="number"
    				className="form-control"
    				id={`quantity${id}`}
    				value={value}
    				placeholder="Enter an Integer number"
    				onChange={this.onChangeHandler} />
  			</div>
			</form>
		);
	}
}

const mapDispatchToProps = (dispatch) => {
	return {
		putEnquiry: (id, params) => {
			dispatch(putEnquiry(id, params));
		},
	};
};

Quantity.propTypes = {
	id: PropTypes.number.isRequired,
	name: PropTypes.string.isRequired,
	value: PropTypes.number.isRequired,
};

export default connect(null, mapDispatchToProps)(Quantity);