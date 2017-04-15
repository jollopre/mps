import React, { Component } from 'react';
import { Row, Col } from 'react-bootstrap';
import PropTypes from 'prop-types';

export default class OrderList extends Component {
	constructor(props){
		super(props);
		this.show = this.show.bind(this);
	}
	show(e, id) {
		e.preventDefault();
		this.props.show(id);
	}
	render() {
		const header = (
			<Row>
				<Col xs={2}><strong>#</strong></Col>
				<Col xs={3}><strong>Created At</strong></Col>
				<Col xs={3}><strong>Updated At</strong></Col>
				<Col xs={2}><strong>Actions</strong></Col>
			</Row>
		);
		const body = this.props.list.map((value) => {
			return (
				<Row key={value.id}>
					<Col xs={2}>{value.id}</Col>
					<Col xs={3}>{value.created_at}</Col>
					<Col xs={3}>{value.updated_at}</Col>	
					<Col xs={2}>
						<a href="#" onClick={e => this.show(e, value.id)}>Show</a>
					</Col>
				</Row>
			);
		});
		return (
			<div>
				{header}
				{body}
			</div>
		);
	}
}

OrderList.propTypes = {
	list: PropTypes.array.isRequired,
	show: PropTypes.func.isRequired,
};