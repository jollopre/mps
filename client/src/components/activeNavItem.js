import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { withRouter } from 'react-router-dom';
import { NavItem } from 'react-bootstrap'; 

class ActiveNavItem extends Component {
	constructor(props){
		super(props);
		this.onClickHandler = this.onClickHandler.bind(this);
	}
	onClickHandler(event){
		event.preventDefault();
		this.props.history.push(this.props.href);
	}
	render(){
		const { eventKey, href, location } = this.props;
		return (
			<NavItem 
				eventKey={eventKey}
				onClick={this.onClickHandler}
				href={href}
				active={location.pathname === href}
			>
				{this.props.children}
			</NavItem>
		);
	}
}
ActiveNavItem.propTypes = {
	eventKey: PropTypes.number.isRequired,
	href: PropTypes.string.isRequired,
	children: PropTypes.string.isRequired,
};

export default withRouter(ActiveNavItem);