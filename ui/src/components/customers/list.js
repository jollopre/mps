import React, { Component } from 'react';
import PropTypes from 'prop-types';
import ListItem from './listItem';

export default class List extends Component {
	render() {
		const { list } = this.props;
		return (
			<div className="table-responsive">
  				<table className="table table-hover">
    				<thead>
    					<tr>
							<th>REF</th>
							<th>Company Name</th>
							<th>Telephone</th>
							<th>Email</th>
							<th>Contact Name</th>
							<th>Contact Surname</th>
							<th>Actions</th>
						</tr>
    				</thead>
    				<tbody>
    					{list.map(item => (<ListItem key={item.id} item={item} />))}
    				</tbody>
  				</table>
			</div>
		);
	}
}

List.propTypes = {
	list: PropTypes.array.isRequired,
};