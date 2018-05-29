import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import { quotation_enquiry_path } from '../../routes';
import { addEnquiry, deleteEnquiry } from '../../actions/ui';

export const QuantityBadge = ({ quantity }) => {
  if (quantity > 0) {
    return (
      <span className="badge">
        {quantity}
      </span>
    );
  }
  return null;
}
class ListItem extends Component {
  constructor(props) {
    super(props);
    this.handleInputChange = this.handleInputChange.bind(this);
  }
  handleInputChange(event) {
    const target = event.target;
    const value = target.checked;
    const id = target.name;
    const { addEnquiry, deleteEnquiry } = this.props;
    if (value) {
      addEnquiry(id*1);
    } else {
      deleteEnquiry(id*1);
    }
  }
  isChecked(id) {
    const { selectedEnquiries } = this.props;
    return selectedEnquiries.includes(id);
  }
  isActive(id) {
    const { active } = this.props;
    return active === id;
  }
  render() {
    const { enquiry, product } = this.props;
    const styles = { backgroundColor: '#dff0d8', borderColor: '#d6e9c6' };
    return (
      <div className="list-group-item" style={this.isActive(enquiry.id) ? styles : {}}>
        <ul className="list-inline">
          <li>
            <div className="checkbox">
              <label>
                <input
                  name={enquiry.id}
                  type="checkbox"
                  checked={this.isChecked(enquiry.id)}
                  onChange={this.handleInputChange}/>
              </label>
            </div>
          </li>
          <li>
            <Link
              to={quotation_enquiry_path({
              id: enquiry.quotation_id,
              enquiry_id: enquiry.id })}>
              {product.name}
            </Link>
          </li>
          <li>
            <QuantityBadge quantity={enquiry.quantity} />
          </li>
          <li>
            <QuantityBadge quantity={enquiry.quantity2} />
          </li>
          <li>
            <QuantityBadge quantity={enquiry.quantity3} />
          </li>
        </ul>
      </div>);
  }
}

ListItem.propTypes = {
  enquiry: PropTypes.object.isRequired,
  product: PropTypes.object.isRequired,
  active: PropTypes.number.isRequired,
};

const mapStateToProps = (state) => {
  const { ui } = state;
  return { selectedEnquiries: ui.selectedEnquiries };
}

const mapDispatchToProps = (dispatch) => {
  return {
    addEnquiry: (enquiryId) => {
      dispatch(addEnquiry(enquiryId));
    },
    deleteEnquiry: (enquiryId) => {
      dispatch(deleteEnquiry(enquiryId));
    }
  };
};
export default connect(mapStateToProps, mapDispatchToProps)(ListItem);
