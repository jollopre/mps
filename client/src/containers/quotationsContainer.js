import React, { Component } from 'react';
import { connect } from 'react-redux';
import queryString from 'query-string';
import { getQuotations, searchQuotations } from '../actions/quotations';
import Quotations from '../components/quotations';
import { setPage, QUOTATIONS } from '../actions/pagination';

class QuotationsContainer extends Component {
	componentDidMount() {
		const { getQuotations, customerId, searchQuotations, term } = this.props;
        if (term) {
            searchQuotations({ customerId, term });
        } else {
		  getQuotations({ customerId });
        }
	}
	render(){
		const { quotations, isFetching } = this.props;
        if (isFetching) {
            return (<p>Fetching quotations...</p>);
        }
        else if (quotations) {
            return (<Quotations list={quotations} />);
        }
        return null;    // isFetching is false and quotations is null 
	}
    componentWillUnmount() {
        const { setPage } = this.props;
        setPage({ resource: QUOTATIONS });
    }
}

const mapStateToProps = (state, ownProps) => {
    const { quotations, pagination } = state;
    const currentPage = pagination.quotations.currentPage;
    const ids = pagination.quotations.pages[currentPage] ?
        pagination.quotations.pages[currentPage].ids : null;
    const queryObject = queryString.parse(ownProps.location.search);
    const quotationsFilter = ids ? ids.reduce((acc, id) => {
        return acc.concat(quotations.byId[id]);
    }, []) : null;
    return {
    	...quotations,
    	quotations: quotationsFilter,
    	customerId: ownProps.match.params.id,
        term: queryObject.search,
    };
};

const mapDispatchToProps = (dispatch) => {
	return {
		getQuotations: (params) => {
			dispatch(getQuotations(params));
		},
        searchQuotations: (params) => {
            dispatch(searchQuotations(params));
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
	};
};

export default connect(mapStateToProps, mapDispatchToProps)(QuotationsContainer);