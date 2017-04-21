import React, { Component } from 'react';
import { Button } from 'react-bootstrap';
import PropTypes from 'prop-types';

export default class OrderAdd extends Component {
	constructor(props) {
		super(props);
		this.add = this.add.bind(this);
	}
	add(e) {
		e.preventDefault();
		this.props.add();
	}
	render() {
		return (
			<div className="pull-right">
				<Button bsStyle="success" onClick={this.add}>Add Order</Button>
			</div>
		);
	}
}

OrderAdd.propTypes = {
	add: PropTypes.func.isRequired,
};