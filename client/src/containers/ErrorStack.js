import React, { Component } from 'react';
import WarningMessage from '../components/WarningMessage';

export default class ErrorStack extends Component {
	constructor(props){
		super(props);
		this.counter = 0;
		this.state = { stack: [] };
		this.onDone = this.onDone.bind(this);
	}
	onDone(id){
		const { stack } = this.state;
		const index = stack.findIndex((e) => {
			return e.id === id;
		});
		if(index !== -1){
			const newStack = stack.slice(0, index).concat(stack.slice(index+1));
			this.setState({ stack: newStack });
		}
	}
	render() {
		const warningMessages = this.state.stack.map(e =>
			(<WarningMessage
				key={e.id}
				id={e.id}
				message={e.detail || e.statusText}
				date={e.date}
				onDone={this.onDone}
			/>)
		);
		return (
			<div>
				{warningMessages}
			</div>
		);
	}
	componentWillReceiveProps(nextProps){
		if(nextProps.error !== null && nextProps.error !== this.props.error){
			const error = Object.assign({}, nextProps.error, { id: ++this.counter, date: new Date() });
			const stack = [error].concat(this.state.stack);
			this.setState({ stack });
		}	
	}
}