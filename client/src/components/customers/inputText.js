import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { debounce } from '../../utils/debounce';

export default class InputText extends Component {
  constructor(props) {
    super(props);
    this.onChangeHandler = this.onChangeHandler.bind(this);
    this.state = { value: this.props.value };
    this.deferredChange = debounce(this.deferredChange.bind(this), 2000);
  }
  onChangeHandler(e) {
    const value = e.target.value; 
    this.setState({ value }, this.deferredChange);
  }
  deferredChange() {
    const { onChange, id } = this.props;
    const { value } = this.state;
    onChange({ [id]: value });
  }
  render() {
    const { label, id } = this.props;
    const { value } = this.state;

    return (
      <div className="form-group">
        <label
          htmlFor={id}>
          {label}
        </label>
        <input 
          type="text"
          className="form-control"
          id={id}
          value={value}
          placeholder={label}
          onChange={this.onChangeHandler}></input>
      </div>
    );
  }
}

InputText.propTypes = {
  label: PropTypes.string.isRequired,
  id: PropTypes.string.isRequired,
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired
}
