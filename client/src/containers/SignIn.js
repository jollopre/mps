import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Redirect } from 'react-router-dom';
import { FormGroup, FormControl, Button } from 'react-bootstrap';
import { Auth } from '../Auth';

const wrapper = {
	margin: '0 auto',
	width: '340px',
};

export default class SignIn extends Component {
	constructor(props){
		super(props);
		this.state = { username: '', password: '', redirect: false };
		this.usernameChanged = this.usernameChanged.bind(this);
		this.passwordChanged = this.passwordChanged.bind(this);
		this.signInHandler = this.signInHandler.bind(this);
	}
	usernameChanged(e){
		this.setState({ username: e.target.value });
	}
	passwordChanged(e){
		this.setState({ password: e.target.value });
	}
	signInHandler(){
		const { username, password } = this.state;
		if(username !== '' && password !== ''){
			Auth.signIn({ username, password }).then(() => {
				this.setState({ redirect: true });
				this.props.callback(true);
			}, this.props.httpErrorHandler);
		}
	}
	render() {
		const { from } = this.props.location.state || { from : { pathname: '/' }}
		const { redirect } = this.state;
		if(redirect) {
			return (
				<Redirect to={from} />
			);
		}
		return (
			<FormGroup controlId="SignInForm" style={wrapper}>
				<h2>Sign In</h2>
				<FormControl
					type="text"
					value={this.state.username}
					placeholder="Enter email"
					onChange={this.usernameChanged}
				/>
				<FormControl
					type="password"
					value={this.state.password}
					placeholder="Enter password"
					onChange={this.passwordChanged}
				/>
				<Button bsStyle="success" onClick={this.signInHandler} block>Sign In</Button>
			</FormGroup>
		);
	}
}
SignIn.propTypes = {
	callback: PropTypes.func.isRequired,
	httpErrorHandler: PropTypes.func.isRequired,
};