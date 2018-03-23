import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Redirect, withRouter } from 'react-router-dom';
import { quotations_path } from '../../routes';
import queryString from 'query-string';
import { searchQuotations } from '../../actions/quotations';
import { setPage, QUOTATIONS } from '../../actions/pagination';

class Search extends Component {
    constructor() {
        super();
        this.state = { redirect: false, term: '', tips: false };
        this.onSubmitHandler = this.onSubmitHandler.bind(this);
        this.onChangeHandler = this.onChangeHandler.bind(this);
        this.onChangeHandlerForTips = this.onChangeHandlerForTips.bind(this);
    }
    onSubmitHandler(e) {
        if (e) { e.preventDefault(); }
        this.setState({ redirect: true });
    }
    onChangeHandler(e) {
        this.setState({ redirect: false, term: e.target.value });
    }
    onChangeHandlerForTips() {
        this.setState((prevState) => {
            return { tips: !prevState.tips }; 
        });
    }
    componentDidMount() {
        const queryObject = queryString.parse(this.props.location.search);  // TODO get term from props instead
        if (queryObject.search !== undefined) {
            this.setState({ term: queryObject.search });
        }
    }
    render() {
        const { redirect, term, tips } = this.state;
        const customerId = this.props.match.params.id;  // TODO get customerId from props instead
        return (
            <div>
                <form onSubmit={this.onSubmitHandler}>
                    <div className="input-group">
                        <input
                            type="text"
                            className="form-control"
                            placeholder="Search quotations"
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
                <button
                    type="button"
                    className="btn btn-link"
                    onClick={this.onChangeHandlerForTips}>
                    { !tips ? 'Need search syntax tips?' : 'Hide'}
                </button>
                {tips &&
                    (<div className="panel panel-default">
                      <div className="panel-body">
                        Search by <kbd>YYYY</kbd> (e.g. 2018),&nbsp;
                        or <kbd>YYYY-MM</kbd> (e.g. 2018-02),&nbsp;
                        or <kbd>YYYY-MM-DD</kbd> (e.g. 2018-02-24),&nbsp;
                        or <kbd>YYYY-MM-DD HH</kbd> (e.g. 2018-02-24 01),&nbsp;
                        or <kbd>YYYY-MM-DD HH:MM</kbd> (e.g. 2018-02-24 01:49),&nbsp;
                        or <kbd>YYYY-MM-DD HH:MM:SS</kbd> (e.g. 2018-02-24 01:49:03)
                      </div>
                    </div>)}
                {redirect &&
                    (<Redirect
                        to={{ pathname: quotations_path({ id: customerId }),
                            search: `?search=${term}` }} />)}
            </div>
        );
    }
    componentDidUpdate() {
        const { redirect, term } = this.state;
        const { searchQuotations, setPage, match } = this.props;    // TODO get customerId from props instead
        if (redirect) {
            searchQuotations({ customerId: match.params.id, term });
            setPage({ resource: QUOTATIONS });
        }
    }
}

const dispatchToProps = (dispatch) => {
    return {
        searchQuotations: (params) => {
            dispatch(searchQuotations(params));
        },
        setPage: (params) => {
            dispatch(setPage(params));
        },
    };
}
export default withRouter(connect(null, dispatchToProps)(Search));
