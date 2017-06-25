import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Alert } from 'react-bootstrap';

export default class WarningMessage extends Component {
	constructor(props) {
		super(props);
		this.onDismiss = this.onDismiss.bind(this);
		this.state = { 
			timeoutID: setTimeout(() => {
				this.onDismiss();
			}, 10000) 
		};
	}
	onDismiss() {
		clearTimeout(this.state.timeoutID);
		this.setState({ timeoutID: null });
		this.props.onDone(this.props.id);
	}
	render() {
		const { message, date } = this.props;
		const { timeoutID } = this.state;
		if(timeoutID !== null) {
			return (
				<Alert bsStyle="warning" onDismiss={this.onDismiss}>
					{`${message} at ${date.toString()}`}
				</Alert>
			);
		}
		return null;
	}
}

WarningMessage.propTypes = {
	id: PropTypes.number.isRequired,
	message: PropTypes.string.isRequired,
	date: PropTypes.object.isRequired,
	onDone: PropTypes.func.isRequired,
};