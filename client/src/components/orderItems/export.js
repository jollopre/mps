import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { getExportOrderItem, clearExportOrderItem } from '../../actions/orderItems';

class Export extends Component {
	constructor() {
		super();
		this.setRef = this.setRef.bind(this);
		this.onClickHandler = this.onClickHandler.bind(this);
	}
	setRef(el) {
		const { objectURL, clearExportOrderItem } = this.props;
		if (el && objectURL) {
			el.click();
			clearExportOrderItem();
		}
	}
	onClickHandler(e) {
		const { id, objectURL, exporting } = this.props;
		if (!objectURL) {
			e.preventDefault();
			exporting(id);
		}
	}
	render() {
		const { objectURL } = this.props;
		return (<a
				href={objectURL ? objectURL : '#'}
				className="btn btn-success"
				role="button"
				ref={this.setRef}
				onClick={this.onClickHandler}
				target="_blank">Export</a>);
	}
}

const mapStateToProps = (state, ownProps) => {
	const { orderItems } = state;
	return {
		objectURL: orderItems.objectURL
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		exporting: (id) => {
			dispatch(getExportOrderItem(id));
		},
		clearExportOrderItem: () => dispatch(clearExportOrderItem()),
	};
};

Export.propTypes = {
	id: PropTypes.number.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(Export);