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
		this.setState({ a: el });
	}
	componentWillReceiveProps(nextProps) {
		const { id, objectURL, clearExportOrderItem } = this.props;
		if (nextProps.objectURL && nextProps.objectURL !== objectURL) {
			const link = document.createElement('a');
  		link.href = nextProps.objectURL;
  		link.download=`${id}.pdf`;
  		document.body.appendChild(link);
  		link.click();
  		document.body.removeChild(link);
  		setTimeout(() => { clearExportOrderItem(); }, 1000);
		}
	}
	onClickHandler(e) {
		const { id, exporting } = this.props;
		exporting(id);
	}
	render() {
		return (
			<button
				type="button"
				className="btn btn-success"
				onClick={this.onClickHandler}>
				Export
			</button>)
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