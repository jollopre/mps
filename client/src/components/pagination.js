import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class Pagination extends Component {
	constructor(props) {
		super(props);
		this.pages = Math.ceil(props.count/props.perPage);
		this.state = { currentPage: props.initialPage };
		this.next = this.next.bind(this);
		this.previous = this.previous.bind(this);
	}
	next(e) {
		e.preventDefault();
		const { currentPage } = this.state;
		if (currentPage < this.pages) {
			this.setState({ currentPage: currentPage + 1 },
				() =>{ this.props.onPageChange(this.state.currentPage); });
		}
	}
	previous(e) {
		e.preventDefault();
		const { currentPage } = this.state;
		if (currentPage > 1) {
			this.setState({ currentPage: currentPage - 1},
				() => { this.props.onPageChange(this.state.currentPage); });
		}
	}
	render() {
		const { pages } = this;
		const { currentPage } = this.state;
		return (
			<nav aria-label="Page navigation">
			  <ul className="pager">
			    <li
			    	className={ currentPage === 1 ? 'disabled' : ''}>
			    		<a href="#" onClick={this.previous}>Previous</a>
			    </li>
			    <li
			    	className={ pages === 0 || currentPage === pages ? 'disabled' : ''}>
			    		<a href="#" onClick={this.next}>Next</a>
			    </li>
			  </ul>
			</nav>
		);
	}
}

Pagination.propTypes = {
	count: PropTypes.number.isRequired,	// The total number of records for a model
	perPage: PropTypes.number.isRequired,	// The number of records to display per page
	initialPage: PropTypes.number.isRequired,	// Represents the initialPage selected
	onPageChange: PropTypes.func.isRequired,	// Callback function with currentPage as argument
};