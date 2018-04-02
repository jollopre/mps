import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { DropdownButton, MenuItem } from 'react-bootstrap';
import { getProducts } from '../../actions/products';
import { postEnquiry } from '../../actions/enquiries';

class New extends Component {
  constructor(props){
    super(props);
    this.onClickHandler = this.onClickHandler.bind(this);
  }
  componentDidMount() {
    const { getProducts } = this.props;
    getProducts();
  }
  onClickHandler(eventKey) {
    const { quotationId, postEnquiry } = this.props;
    postEnquiry({ quotationId, productId: eventKey });
  }
  _menuItems(products) {
    return products.map((value, i) => {
      return (<MenuItem key={value.id} eventKey={value.id} onSelect={this.onClickHandler}>
        {value.name}
      </MenuItem>);
    });
  } 
  render() {
    const { products } = this.props;
    return (
      <DropdownButton
        bsStyle="success"
        title="New Enquiry"
        id="dropdown-products">
          {this._menuItems(products)}
      </DropdownButton>
    );
  }
}

const mapStateToProps = (state) => {
  const { products } = state;
  return {
    products: Object.keys(products.byId).reduce((acc, id) => {
      return acc.concat(products.byId[id]);
    }, [])
  }
};

const mapDispatchToProps = (dispatch) => {
  return {
    getProducts: () => {
      dispatch(getProducts());
    },
    postEnquiry: ({ quotationId, productId }) => {
      dispatch(postEnquiry({ quotationId, productId }));
    },
  }
};

New.propTypes = {
  quotationId: PropTypes.number.isRequired,
  products: PropTypes.array.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(New);