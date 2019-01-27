import React, { Component } from 'react';
import { connect } from 'react-redux';
import { ComposeModal } from './composeModal';
import { resetEnquiries } from '../../actions/ui';
import {
  postComposedEmail,
  postComposedEmailSend
} from '../../actions/composedEmails';

class Compose extends Component {
  constructor(props) {
    super(props);
    this.state = { showModal: false };
  }
  setModalHandler = (showModal = false) => {
    this.setState({ showModal });
    if (!showModal) {
      const { resetSelectedEnquiries } = this.props;
      resetSelectedEnquiries();
    }
  }
  render() {
    const {
      hasEnquiries,
      postComposedEmail,
      enquiryIds,
      suppliers,
      composedEmailToSendId,
      postComposedEmailSend
    } = this.props;
    const { showModal } = this.state;
    const showModalHandler = () => {
      this.setModalHandler(true);
    };
    if (hasEnquiries) {
      return (
        <div>
          <button className="btn btn-success" onClick={showModalHandler}>Compose</button>
          {showModal && <ComposeModal
            show={showModal}
            onHideHandler={this.setModalHandler}
            onComposed={postComposedEmail}
            enquiryIds={enquiryIds}
            suppliers={suppliers}
            composedEmailToSendId={composedEmailToSendId}
            postComposedEmailSend={postComposedEmailSend} />}
        </div>
      );
    }
    return null;
  }
}

const mapStateToProps = (state) => {
  const { ui:
    { selectedEnquiries, composedEmailToSendId },
    suppliers: { byId }} = state;
  return {
    hasEnquiries: selectedEnquiries.length > 0,
    enquiryIds: selectedEnquiries,
    composedEmailToSendId,
    suppliers: Object.keys(byId).reduce((acc, id) => [...acc, byId[id]], [])
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    postComposedEmail: (composedEmail) => {
      dispatch(postComposedEmail(composedEmail));
    },
    postComposedEmailSend: (id) => {
      dispatch(postComposedEmailSend(id));
    },
    resetSelectedEnquiries: () => {
      dispatch(resetEnquiries());
    }
  };
}
export default connect(mapStateToProps, mapDispatchToProps)(Compose);
