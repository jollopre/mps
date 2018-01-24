import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderNew from './orderNew';
import OrderList from './orderList';
import Pages from './pages';
import Title from './title';

export default class Orders extends Component {
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
	          	<OrderNew />
	          </div>
	        </div>
	      </div>
	      <div className="row">
	      	<div className="col-xs-12">
	        	{list.length > 0 ? <OrderList list={list} /> : null}
	        </div>
	        <div className="col-xs-12">
	        	<Pages />
	        </div>
	      </div>
      </div>
		);
	}
}

Orders.propTypes = {
	list: PropTypes.array.isRequired,
};

