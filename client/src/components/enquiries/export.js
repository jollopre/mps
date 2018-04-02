import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { getExportEnquiry, clearExportEnquiry } from '../../actions/enquiries';

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
		const { id, objectURL, clearExportEnquiry } = this.props;
		if (nextProps.objectURL && nextProps.objectURL !== objectURL) {
			const link = document.createElement('a');
  		link.href = nextProps.objectURL;
  		link.download=`${id}.pdf`;
  		document.body.appendChild(link);
  		link.click();
  		document.body.removeChild(link);
  		setTimeout(() => { clearExportEnquiry(); }, 1000);
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
	const { enquiries } = state;
	return {
		objectURL: enquiries.objectURL
	};
};

const mapDispatchToProps = (dispatch) => {
	return {
		exporting: (id) => {
			dispatch(getExportEnquiry(id));
		},
		clearExportEnquiry: () => dispatch(clearExportEnquiry()),
	};
};

Export.propTypes = {
	id: PropTypes.number.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(Export);