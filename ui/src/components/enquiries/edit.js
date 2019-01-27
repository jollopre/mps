import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Export from './export';
import Delete from './delete';
import Quantity from './quantity';
import NonOption from '../featureValues/nonOption';
import Option from '../featureValues/option';

export default class Edit extends Component {
  featureComponents() {
    const { enquiry, product } = this.props;
    return Object.keys(enquiry.feature_values).map((id) => {
      const fv = enquiry.feature_values[id];
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
    const { enquiry } = this.props;
    return (
      <div>
        <div className="row">
          <div className="col-xs-12">
            <div className="pull-left">
              <ul className="list-inline">
                <li><Export id={enquiry.id} /></li>
                <li><Delete id={enquiry.id} /></li>
              </ul>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-xs-4">
            {<Quantity id={enquiry.id} name={'quantity'} value={enquiry.quantity} />}
          </div>
          <div className="col-xs-4">
            {<Quantity id={enquiry.id} name={'quantity2'} value={enquiry.quantity2} />}
          </div>
          <div className="col-xs-4">
            {<Quantity id={enquiry.id} name={'quantity3'} value={enquiry.quantity3} />}
          </div>
          <div className="col-xs-12">
            {this.featureComponents()}
          </div>
        </div>
      </div>
    );
  }
}

Edit.propTypes = {
  enquiry: PropTypes.object.isRequired,
  product: PropTypes.object.isRequired,
};
