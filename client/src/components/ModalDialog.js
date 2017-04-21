import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'react-bootstrap';

export default class ModalDialog extends Component {
	render() {
		return (
			<div className="static-modal">
				<Modal show keyboard onHide={this.props.hide}>
					<Modal.Header closeButton>
						<Modal.Title>{this.props.title}</Modal.Title>
					</Modal.Header>
					<Modal.Body>
						{this.props.children}
					</Modal.Body>
				</Modal>
			</div>
		);
	}
}

ModalDialog.propTypes = {
	hide:PropTypes.func.isRequired,
	title: PropTypes.string.isRequired,
	children: PropTypes.element.isRequired,
}