import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { deleteEnquiry } from '../../actions/enquiries';

class Delete extends Component {
  onClickHandler = () => {
    const { id, deleteEnquiry } = this.props;
    deleteEnquiry(id);
  }
  render() {
    return (
      <button
        type="button"
        className="btn btn-success"
        onClick={this.onClickHandler}>
        Delete 
      </button>
    );
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    deleteEnquiry: (id) => {
      dispatch(deleteEnquiry(id));
    }
  };
};

Delete.propTypes = {
  id: PropTypes.number.isRequired,
};

export default connect(null, mapDispatchToProps)(Delete);
