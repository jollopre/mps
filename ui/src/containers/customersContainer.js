import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import queryString from 'query-string';
import { getCustomers, searchCustomers } from '../actions/customers';
import Customers from '../components/customers';
import { setPage, CUSTOMERS } from '../actions/pagination';

class CustomersContainer extends Component {
    componentDidMount() {
        const { getCustomers, searchCustomers, term } = this.props;
        if (term) {
            searchCustomers({ term });
        } else {
            getCustomers();
        }
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
const mapStateToProps = (state, ownProps) => {
    const { customers, pagination } = state;
    const currentPage = pagination.customers.currentPage;
    const ids = pagination.customers.pages[currentPage] ?
        pagination.customers.pages[currentPage].ids : null;
    const queryObject = queryString.parse(ownProps.location.search);
    const customersFilter = ids ? ids.reduce((acc, id) => {
        return acc.concat(customers.byId[id]);
    }, []) : null;
    return {
        ...customers,
        customers: customersFilter,
        term: queryObject.search,
    };
};

const dispatchToProps = (dispatch) => {
    return {
        getCustomers: () => {
            dispatch(getCustomers());
        },
        searchCustomers: (params) => {
            dispatch(searchCustomers(params));
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
    }
}

export default withRouter(connect(mapStateToProps, dispatchToProps)(CustomersContainer));