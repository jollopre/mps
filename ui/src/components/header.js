import React, { Component } from 'react';
import { Navbar, Nav } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import ActiveNavItem from './activeNavItem';
import logo from '../assets/logo.png';
import {
	CUSTOMERS_URI_PATTERN
} from '../routes';

export default class Header extends Component {
	render() {
		return (
			<Navbar inverse style={{ borderRadius: '0px' }}>
				<Navbar.Header>
					<Navbar.Brand>
						<Link to="/" style={{ paddingTop: '2px'}}>
							<img src={logo} alt="MPS" />
						</Link>
					</Navbar.Brand>
					<Navbar.Toggle />
				</Navbar.Header>
				<Navbar.Collapse>
					<Nav>
						<ActiveNavItem eventKey={1} href={CUSTOMERS_URI_PATTERN}>Customers</ActiveNavItem>
					</Nav>
					<Navbar.Form pullRight>
						{this.props.children}
					</Navbar.Form>
				</Navbar.Collapse>
			</Navbar>
		);
	}
}