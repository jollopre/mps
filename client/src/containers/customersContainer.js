import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getCustomers } from '../actions/customers';
import Customers from '../components/customers';
import { setPage, CUSTOMERS } from '../actions/pagination';

class CustomersContainer extends Component {
    componentDidMount() {
        const { getCustomers } = this.props;
        getCustomers();
    }
    render() {
        const { customers, isFetching } = this.props;
        if (isFetching) {
            return (<p>Fetching customers...</p>);
        }
        else if (customers) {
            return (<Customers list={customers} />);
        }
        return null;    // isFetching is false and customers is null 
    }
    componentWillUnmount() {
        const { setPage } = this.props;
        setPage({ resource: CUSTOMERS });
    }
}
const mapStateToProps = (state) => {
    const { customers, pagination } = state;
    const currentPage = pagination.customers.currentPage;
    const ids = pagination.customers.pages[currentPage] ?
        pagination.customers.pages[currentPage].ids : null;
    const customersFilter = ids ? ids.reduce((acc, id) => {
        return acc.concat(customers.byId[id]);
    }, []) : null;
    return {
        ...customers,
        customers: customersFilter,
    };
};

const dispatchToProps = (dispatch) => {
    return {
        getCustomers: () => {
            dispatch(getCustomers());
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
    }
}

export default connect(mapStateToProps, dispatchToProps)(CustomersContainer);