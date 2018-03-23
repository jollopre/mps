import React, { Component } from 'react';
import PropTypes from 'prop-types';
import QuotationListItem from './quotationListItem';

export default class QuotationList extends Component {
	render() {
		const { list } = this.props;
		return (
			<div className="table-responsive">
				<table className="table table-hover">
					<thead>
						<tr>
							<th>#</th>
							<th>Created At</th>
							<th>Updated At</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						{list.map(quotation => (<QuotationListItem key={quotation.id} quotation={quotation} />))}
					</tbody>
				</table>
			</div>
		);
	}
}

QuotationList.propTypes = {
	list: PropTypes.array.isRequired,
};