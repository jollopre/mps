import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'react-bootstrap';
import { Typeahead } from 'react-bootstrap-typeahead';
import 'react-bootstrap-typeahead/css/Typeahead.css';

export class ComposeModal extends Component {
  constructor(props) {
    super(props);
    this.state = { selectedSuppliers: [], subject: '', body: '' };
  }
  onHideHandler = () => {
    const { onHideHandler: hide } = this.props;

    hide();
  }
  onChangeHandler = (selectedSuppliers) => {
    this.setState({ selectedSuppliers });
  }
  onChangeSubject = (event) => {
    const { target: { value: subject } } = event;
    this.setState({ subject });
  }
  onChangeBody = (event) => {
    const { target: { value: body }} = event;
    this.setState({ body });
  }
  sendable = () => {
    const { subject, body, selectedSuppliers } = this.state;

    return subject.length > 0 && body.length > 0 && selectedSuppliers.length > 0;
  }
  create = () => {
    const { onComposed, enquiryIds } = this.props;
    const { subject, body, selectedSuppliers } = this.state;
    const supplierIds = selectedSuppliers.map(s => s.id);

    onComposed({
      subject,
      body,
      enquiryIds,
      supplierIds
    });
  }
  componentDidUpdate(prevProps) {
    const { composedEmailToSendId: id, postComposedEmailSend } = this.props;
    if (id !== prevProps.composedEmailToSendId && id) {
      postComposedEmailSend(id)
      this.onHideHandler();
    }
  }
  render() {
    const { show } = this.props;
    const { selectedSuppliers, subject, body } = this.state;
    const { suppliers } = this.props;

    return (
      <Modal show={show} onHide={this.onHideHandler}>
        <Modal.Header closeButton>
          <Modal.Title>
            Compose an email
          </Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form>
            <div className="form-group">
              <Typeahead
                clearButton
                onChange={this.onChangeHandler}
                labelKey="reference"
                options={suppliers}
                selected={selectedSuppliers}
                multiple
                placeholder="To"
              />
            </div>
            <div className="form-group">
              <input
                type="text"
                className="form-control"
                placeholder="Subject"
                onChange={this.onChangeSubject}
                value={subject}
              />
            </div>
            <div className="form-group">
              <textarea
                className="form-control"
                rows="5"
                onChange={this.onChangeBody}
                value={body}
              ></textarea>
            </div>
          </form>
        </Modal.Body>
        <Modal.Footer>
          <button
            className="btn btn-success"
            disabled={ this.sendable() ? '' : 'disabled' }
            onClick={this.create}>Send</button>
        </Modal.Footer>
      </Modal>
    );
  }
}

ComposeModal.propTypes = {
  onHideHandler: PropTypes.func.isRequired,
  onComposed: PropTypes.func.isRequired,
  show: PropTypes.bool.isRequired,
  enquiryIds: PropTypes.array.isRequired,
  suppliers: PropTypes.array.isRequired,
  postComposedEmailSend: PropTypes.func.isRequired
};
