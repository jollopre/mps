import React, { Component } from 'react';
import PropTypes from 'prop-types';
import OrderNew from './orderNew';
import OrderList from './orderList';

export default class Orders extends Component {
	render() {
		const { list } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-12">
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
	        	{list.length === 0 ? (
	        		<p className="bg-info" style={{marginTop: '1em'}}>
								<strong>Eeeeey!</strong> There are no orders yet.
							</p>) : null}
	        </div>
	      </div>
      </div>
		);
	}
}

Orders.propTypes = {
	list: PropTypes.array.isRequired,
};





