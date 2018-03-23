import React, { Component } from 'react';
import PropTypes from 'prop-types';
import QuotationNew from './quotationNew';
import QuotationList from './quotationList';
import Pages from './pages';
import Title from './title';
import Search from './search';

export default class Quotations extends Component {
	render() {
		const { list } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-6">
						<Title />
					</div>
					<div className="col-xs-6">
	        	<div className="pull-right">
	          	<QuotationNew />
	          </div>
	        </div>
	      </div>
	      <div className="row">
	      	<div className="col-xs-6 col-xs-offset-3">
	      		<Search />
	      	</div>
	      </div>
	      <div className="row">
	      	<div className="col-xs-12">
	        	{list.length > 0 ? <QuotationList list={list} /> : null}
	        </div>
	        <div className="col-xs-12">
	        	<Pages />
	        </div>
	      </div>
      </div>
		);
	}
}

Quotations.propTypes = {
	list: PropTypes.array.isRequired,
};

