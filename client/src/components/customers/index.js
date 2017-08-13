import React, { Component } from 'react';
import PropTypes from 'prop-types';
import List from './list';

export default class Customers extends Component {
	render() {
		const { list } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-12">
						<List list={list} />
					</div>
				</div>
			</div>
		);
	}
}

Customers.propTypes = {
	list: PropTypes.array.isRequired,
};
