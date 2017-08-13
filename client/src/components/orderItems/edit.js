import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Export from './export';
import Quantity from './quantity';
import NonOption from '../featureValues/nonOption';
import Option from '../featureValues/option';

export default class Edit extends Component {
	featureComponents() {
		const { orderItem, product } = this.props;
		return Object.keys(orderItem.feature_values).map((id) => {
			const fv = orderItem.feature_values[id];
			const feature = product.features[fv.feature_id];
			if (feature.feature_type === "float" ||
				feature.feature_type === "integer" ||
				feature.feature_type === "string") {
				return (<NonOption key={feature.id} feature={feature} featureValue={fv} />);
			} else if (feature.feature_type === "option") {
				return (<Option key={feature.id} feature={feature} featureValue={fv} />);
			} else {
				return null;
			}
		});
	}
	render() {
		const { orderItem } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-12">
						<div className="pull-left">
							<Export id={orderItem.id} />
						</div>
					</div>
				</div>
				<div className="row">
					<div className="col-xs-12">
						{<Quantity id={orderItem.id} value={orderItem.quantity} />}
					</div>
					<div className="col-xs-12">
						{this.featureComponents()}
					</div>
				</div>
			</div>
		);
	}
}

Edit.PropTypes = {
	orderItem: PropTypes.object.isRequired,
	product: PropTypes.object.isRequired,
};