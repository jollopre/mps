import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';


class Search extends Component {
    constructor() {
        super();
        this.onSubmit = this.onSubmit.bind(this);
        this.onChange = this.onChange.bind(this);
        this.state = { customerSearch: '' };
    }
    onSubmit(e) {
        if (e) {
            e.preventDefault();
        }
        const { customerSearch } = this.state;
        const { search } = this.props;
        search(customerSearch || undefined);    // Controller component
        search((this.customerSearch && this.customerSearch.value) || undefined);    // Uncontroller component
    }
    onChange(e) {
        this.setState({ customerSearch: e.target.value });
    }
    onKeyUp(e) {
        if (e.charCode === 13) {
            this.onSubmit();
        }
    }
    render() {
        const { customerSearch } = this.state;
        return (
            <form className="form-inline" onSubmit={this.onSubmit}>
                <div className="form-group">
                    <label className="sr-only" htmlFor="customerSearch">Type to filter customers</label>
                    <input
                        value={customerSearch}
                        id="customerSearch"
                        type="text"
                        className="form-control"placeholder="Type to filter customers"
                        onChange={this.onChange}
                    />
                    {/*
                    <input
                        ref={(input) => { this.customerSearch = input; }}
                        id="customerSearch"
                        type="text"
                        className="form-control"
                    />*/
                    }
                </div>
                <button type="submit" className="btn btn-default">Search</button>
            </form>
        );
    }
}

const dispatchMapToProps = dispatch => {
    return {
        search: (string) => {
            console.log(string);
        }
    };
};

Search.propTypes = {
    search: PropTypes.func.isRequired,
};

export default connect(null, dispatchMapToProps)(Search);
