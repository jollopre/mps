import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
import { postSignIn } from '../actions/user';

const wrapper = {
	margin: '0 auto',
	width: '340px',
	paddingBottom: '50px',
};

class SignIn extends Component {
	constructor(props){
		super(props);
		this.state = {
			username: '',
			password: '',
			validationStateUsername: true,
			validationStatePassword: true
		};
		this.usernameChanged = this.usernameChanged.bind(this);
		this.passwordChanged = this.passwordChanged.bind(this);
		this.signInHandler = this.signInHandler.bind(this);
	}
	usernameChanged(e){
		const value = e.target.value;
		this.setState({
			username: value,
			validationStateUsername: value !== '' ? true : false
		});
	}
	passwordChanged(e){
		const value = e.target.value;
		this.setState({
			password: value,
			validationStatePassword: value !== '' ? true : false
		});
	}
	signInHandler(e){
		if (e) {
			e.preventDefault();
		}
		const { username, password } = this.state;
		const { postSignIn } = this.props;
		if(username !== '' && password !== ''){
			postSignIn({ email: username, password });
		}
		else {
			this.setState({
				validationStateUsername: username === '' ? false : true,
				validationStatePassword: password === '' ? false : true
			});
		}
	}
	conditionalDisplay(state = false) {
		if (state) {
			return { display: 'none' };
		}
		return { display: 'block' };
	}
	hasWarning(state = false) {
		return !state;
	}
	render() {
		const { from } = this.props.location.state || { from : { pathname: '/' }}
		const { shouldRedirect } = this.props;
		const { username, password, validationStateUsername, validationStatePassword } = this.state;
		if(shouldRedirect) {
			return (
				<Redirect to={from} />
			);
		}
		return (
			<form onSubmit={this.signInHandler} style={wrapper}>
				<div
					className={ this.hasWarning(validationStateUsername) ? 'form-group has-warning': 'form-group' }>
					<label htmlFor="username" className="sr-only">Username</label>
					<input
						type="text"
						id="username"
						className="form-control"
						placeholder="Email address"
						value={username}
						onChange={this.usernameChanged}
						aria-describedby="helpBlockUsername" />
					<span
						id="helpBlockUsername"
						className="help-block"
						style={this.conditionalDisplay(validationStateUsername)}>
						Introduce email address
					</span>
				</div>
				<div
					className={ this.hasWarning(validationStatePassword) ? 'form-group has-warning': 'form-group' }>
					<label htmlFor="password" className="sr-only">Password</label>
					<input
						type="password"
						id="password"
						className="form-control"
						placeholder="Password"
						value={password}
						onChange={this.passwordChanged} />
					<span
						id="helpBlockPassword"
						className="help-block"
						style={this.conditionalDisplay(validationStatePassword)}>
						Introduce password
					</span>
				</div>
				<button
					type="submit"
					className="btn btn-success btn-block"
					style={{ marginTop: '1rem'}} >
					Sign In
				</button>
			</form>
		);
	}
}

const mapStateToProps = state => ({ shouldRedirect: state.user.token !== null });

const mapDispatchToProps = (dispatch) => {
	return {
		postSignIn: ({ email = null, password = null } = {}) => {
			dispatch(postSignIn({ email, password} ));
		}
	};
};

SignIn.propTypes = {
	shouldRedirect: PropTypes.bool.isRequired,
	postSignIn: PropTypes.func.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);