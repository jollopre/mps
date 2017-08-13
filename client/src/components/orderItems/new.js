import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { DropdownButton, MenuItem } from 'react-bootstrap';
import { getProducts } from '../../actions/products';
import { postOrderItem } from '../../actions/orderItems';

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
    const { orderId, postOrderItem } = this.props;
    postOrderItem({ orderId: orderId, productId: eventKey });
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
        title="New Order Item"
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
    postOrderItem: ({ orderId, productId }) => {
      dispatch(postOrderItem({ orderId, productId }));
    },
  }
};

New.propTypes = {
  orderId: PropTypes.number.isRequired,
  products: PropTypes.array.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(New);