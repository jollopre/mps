import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Redirect, withRouter } from 'react-router-dom';
import { CUSTOMERS_URI_PATTERN } from '../../routes';
import queryString from 'query-string';
import { searchCustomers } from '../../actions/customers';
import { setPage, CUSTOMERS } from '../../actions/pagination';

class Search extends Component {
    constructor() {
        super();
        this.state = { redirect: false, term: '' };
        this.onSubmitHandler = this.onSubmitHandler.bind(this);
        this.onChangeHandler = this.onChangeHandler.bind(this);
    }
    onSubmitHandler(e) {
        if (e) { e.preventDefault(); }
        this.setState({ redirect: true });
    }
    onChangeHandler(e) {
        this.setState({ redirect: false, term: e.target.value });
    }
    componentDidMount() {
        const queryObject = queryString.parse(this.props.location.search);
        if (queryObject.search !== undefined) {
            this.setState({ term: queryObject.search });
        }
    }
    render() {
        const { redirect, term } = this.state;
        return (
            <div>
                <form onSubmit={this.onSubmitHandler}>
                    <div className="input-group">
                        <input
                            type="text"
                            className="form-control"
                            placeholder="Search customers"
                            value={term}
                            onChange={this.onChangeHandler}
                        />
                        <div className="input-group-btn">
                            <button className="btn btn-default" type="submit">
                                <span className="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
                    </div>
                </form>
                {redirect && (<Redirect to={{ pathname: CUSTOMERS_URI_PATTERN, search: `?search=${term}` }} />)}
            </div>
        );
    }
    componentDidUpdate() {
        const { redirect, term } = this.state;
        const { searchCustomers, setPage } = this.props;
        if (redirect) {
            searchCustomers({ term });
            setPage({ resource: CUSTOMERS });
        }
    }
}

const dispatchToProps = (dispatch) => {
    return {
        searchCustomers: (params) => {
            dispatch(searchCustomers(params));
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
    };
}
export default withRouter(connect(null, dispatchToProps)(Search));
