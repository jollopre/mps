import React, { Component } from 'react';
import { connect } from 'react-redux';
import Edit from '../components/customers/edit';
import { getCustomer, putCustomer } from '../actions/customers';

class CustomerEditContainer extends Component {
  componentDidMount() {
    const { getCustomer, customer } = this.props;
    if (!customer) {
      const { match: { params: { id }}} = this.props;
      getCustomer(id);
    }
  }
  render() {
    const { customer = null, putCustomer } = this.props;

    return customer && (
      <Edit
        customer={customer}
        putCustomer={putCustomer}
      />);
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
    getCustomer: (id) => {
      dispatch(getCustomer(id));
    },
    putCustomer: (id, param) => {
      dispatch(putCustomer(id, param));
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(CustomerEditContainer);
