import React, { Component } from 'react';
import PropTypes from 'prop-types';
import FeatureFloat from './FeatureFloat';
import FeatureInteger from './FeatureInteger';
import FeatureOption from './FeatureOption';
import FeatureString from './FeatureString';
import Quantity from './Quantity';

export default class Edit extends Component {
	render() {
		const list = Object.keys(this.props.orderItem.feature_values).map((key) => {
			const fv = this.props.orderItem.feature_values[key];
			const f = this.props.orderItem.product.features[fv.feature_id];
			let body = null;
			switch (f.feature_type) {
				case 'float':
					body = (<FeatureFloat
						feature={f}
						feature_value={fv}
						onChangeFeatureValue={this.props.onChangeFeatureValue} />);
					break;
				case 'integer':
					body = (<FeatureInteger
						feature={f}
						feature_value={fv}
						onChangeFeatureValue={this.props.onChangeFeatureValue} />);
					break;
				case 'option':
					body = (<FeatureOption
						feature={f}
						feature_value={fv}
						onChangeFeatureValue={this.props.onChangeFeatureValue} />);
					break;
				case 'string':
					body = (<FeatureString
						feature={f}
						feature_value={fv}
						onChangeFeatureValue={this.props.onChangeFeatureValue} />);
					break;
				default: 
					break;
			}
			return (
  					<li key={f.id}>
  						{body}
  					</li>
			);
		});
		return (
			<ul className="list-unstyled">
				<li>
					<Quantity
						id={this.props.orderItem.id}
						quantity={this.props.orderItem.quantity}
						onChangeOrderItemQuantity={this.props.onChangeOrderItemQuantity} />
				</li>
				{list}
			</ul>
		);
	}
}

Edit.propTypes = {
	orderItem: PropTypes.object.isRequired,
	onChangeFeatureValue: PropTypes.func.isRequired,
	onChangeOrderItemQuantity: PropTypes.func.isRequired,
};