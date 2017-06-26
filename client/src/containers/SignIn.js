import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Redirect } from 'react-router-dom';
import { Form, FormGroup, FormControl, HelpBlock, Button } from 'react-bootstrap';
import { Auth } from '../Auth';

const wrapper = {
	margin: '0 auto',
	width: '340px',
	paddingBottom: '50px',
};

export default class SignIn extends Component {
	constructor(props){
		super(props);
		this.state = {
			username: '',
			password: '',
			redirect: false,
			validationStateUsername: null,
			validationStatePassword: null
		};
		this.usernameChanged = this.usernameChanged.bind(this);
		this.passwordChanged = this.passwordChanged.bind(this);
		this.onKeyPressHandler = this.onKeyPressHandler.bind(this);
		this.signInHandler = this.signInHandler.bind(this);
	}
	usernameChanged(e){
		const value = e.target.value;
		this.setState({
			username: value,
			validationStateUsername: value !== '' ? null : 'warning'
		});
	}
	passwordChanged(e){
		const value = e.target.value;
		this.setState({
			password: value,
			validationStatePassword: value !== '' ? null : 'warning'
		});
	}
	onKeyPressHandler(e){
		if(e.charCode === 13) // Enter key
			this.signInHandler();
	}
	signInHandler(){
		const { username, password } = this.state;
		if(username === '' && password === '') {
			this.setState({
				validationStateUsername: 'warning',
				validationStatePassword: 'warning'
			});
		}
		else if(username === '') {
			this.setState({
				validationStateUsername: 'warning',
				validationStatePassword: null
			});
		}
		else if(password === '') {
			this.setState({
				validationStateUsername: null,
				validationStatePassword: 'warning'
			});
		}
		else if(username !== '' && password !== ''){
			Auth.signIn({ username, password }).then(() => {
				this.setState({ redirect: true });
				this.props.callback(true);
			}, this.props.httpErrorHandler);
		}
	}
	render() {
		const { from } = this.props.location.state || { from : { pathname: '/' }}
		const { username, password, redirect, validationStateUsername, validationStatePassword } = this.state;
		if(redirect) {
			return (
				<Redirect to={from} />
			);
		}
		return (
			<Form style={wrapper}>
				<h2>Sign In</h2>
				<FormGroup controlId="SignInUsername" validationState={validationStateUsername}>
					<FormControl
						type="text"
						value={username}
						placeholder="Email address"
						onChange={this.usernameChanged}
						onKeyPress={this.onKeyPressHandler}
					/>
					{validationStateUsername !== null ? <HelpBlock>Introduce Email address</HelpBlock> : null}
					<FormControl.Feedback />
				</FormGroup>
				<FormGroup controlId="SignInPassword" validationState={validationStatePassword}>
					<FormControl
						type="password"
						value={password}
						placeholder="Password"
						onChange={this.passwordChanged}
						onKeyPress={this.onKeyPressHandler}
					/>
					{validationStatePassword !== null ? <HelpBlock>Introduce Password</HelpBlock> : null}
					<FormControl.Feedback />
				</FormGroup>
				<Button bsStyle="success" onClick={this.signInHandler} block style={{ marginTop: '1rem'}}>Sign In</Button>
			</Form>
		);
	}
}
SignIn.propTypes = {
	callback: PropTypes.func.isRequired,
	httpErrorHandler: PropTypes.func.isRequired,
};