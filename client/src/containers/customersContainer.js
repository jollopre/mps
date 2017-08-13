import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getCustomers } from '../actions/customers';
import Customers from '../components/customers';

class CustomersContainer extends Component {
    componentDidMount() {
        const { getCustomers } = this.props;
        getCustomers();
    }
    render() {
        const { customers } = this.props;
        return <Customers list={customers} />
    }
}
const mapStateToProps = (state) => {
    const { customers } = state;
    return {
        customers: Object.keys(customers.byId).reduce((acc, id) => {
            return acc.concat(customers.byId[id]);
        }, [])
    }
};

const dispatchToProps = (dispatch) => {
    return {
        getCustomers: () => {
            dispatch(getCustomers());
        },
    }
}

export default connect(mapStateToProps, dispatchToProps)(CustomersContainer);