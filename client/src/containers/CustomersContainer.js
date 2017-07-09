import React, { Component } from 'react';
import PropTypes from 'prop-types';
import CustomerService from '../services/CustomerService';
import CustomerList from '../components/CustomerList';
import { Grid, Row, Col } from 'react-bootstrap';

export default class CustomersContainer extends Component {
    constructor(props) {
        super(props);
        this.state = { list: [] }; 
    }
    componentDidMount() {
        CustomerService.index().then(
            data => this.setState({ list:data }),
            this.props.httpErrorHandler);
    }
    render() {
        return (
            <Grid>
                <Row>
                    <Col xs={12}>
                        <CustomerList list={this.state.list} />
                    </Col>
                </Row>
            </Grid>
        );
    }
}
CustomersContainer.propTypes = {
    httpErrorHandler: PropTypes.func.isRequired,
};