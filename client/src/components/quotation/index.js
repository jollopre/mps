import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import QuotationShow from '../quotations/quotationShow';
import CustomerShow from '../customers/customerShow';
import New from '../enquiries/new';
import Compose from '../enquiries/compose';
import EnquiriesContainer from '../../containers/enquiriesContainer';
import { quotations_path } from '../../routes';

export default class Quotation extends Component {
	render() {
		const { quotation, customer } = this.props;
		return (
			<div>
				<div className="row">
					<div className="col-xs-12">
						<div className="pull-right" style={{ marginBottom: '10px' }}>
							<Link
								to={quotations_path({ id: customer.id })}
								className="btn btn-default"
								role="button">
								Back to Quotations
							</Link>
						</div>
					</div>
				</div>
				<div className="row">
					<div className="col-xs-12">
						<div className="panel panel-success">
						  <div className="panel-heading">
						    <h3 className="panel-title">{`Quotation ${quotation.id}`}</h3>
						  </div>
						  <div className="panel-body">
						    <div className="pull-left">
						    	<QuotationShow quotation={quotation} />
						    </div>
						    <div className="pull-right">
						    	<CustomerShow customer={customer} />
						    </div>
						    <div className="row">
									<div className="col-xs-12">
                    <div className="pull-left">
                      {<Compose />}
                    </div>
										<div className="pull-right">
											{<New quotationId={quotation.id} />}
										</div>
                    <div className="clearfix" />
									</div>
								</div>
								<div className="row">
									<div className="col-xs-12">
										{<EnquiriesContainer />}
									</div>
								</div>
						  </div>
						</div>
					</div>
				</div>
			</div>
		);
	}
}

Quotation.PropTypes = {
	quotation: PropTypes.object.isRequired,
	customer: PropTypes.object.isRequired,
};
