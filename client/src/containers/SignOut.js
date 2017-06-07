import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Button } from 'react-bootstrap';
import { Auth } from '../Auth';

export default class SignOut extends Component {
	constructor(props){
		super(props);
		this.signOutHandler = this.signOutHandler.bind(this);
	}
	signOutHandler() {
		Auth.signOut().then(() => {
			this.props.callback(false);
		}, this.props.httpErrorHandler);
	}
	render() {
		return (
			<Button bsStyle="danger" onClick={this.signOutHandler}>Sign Out</Button>
		);
	}
}
SignOut.propTypes = {
	callback: PropTypes.func.isRequired,
	httpErrorHandler: PropTypes.func.isRequired,
};