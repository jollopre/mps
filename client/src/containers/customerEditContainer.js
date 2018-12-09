import React, { Component } from 'react';
import { connect } from 'react-redux';
import Edit from '../components/customers/edit';
import { putCustomer } from '../actions/customers';

class CustomerEditContainer extends Component {
  render() {
    const { customer, putCustomer } = this.props;

    return (<Edit customer={customer} putCustomer={putCustomer}/>);
  }
}

const mapStateToProps = (state, ownProps) => {
  const { match: { params: { id } } } = ownProps;
  const { customers: { byId } } = state;

  return {
    customer: byId[id]
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    putCustomer: (id, param) => {
      dispatch(putCustomer(id, param));
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(CustomerEditContainer);
