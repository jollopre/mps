import React, { Component } from 'react';
import { Navbar, Nav } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import ActiveNavItem from './ActiveNavItem';
import logo from '../assets/logo.png';

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
						<ActiveNavItem eventKey={1} href="/customers">Customers</ActiveNavItem>
						<ActiveNavItem eventKey={2} href="/orders">Orders</ActiveNavItem>
					</Nav>
					<Navbar.Form pullRight>
						{this.props.children}
					</Navbar.Form>
				</Navbar.Collapse>
			</Navbar>
		);
	}
}