import React from 'react';
import ReactDOM from 'react-dom';
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { logging } from './middlewares/logging';
import { apiMiddleware } from './middlewares/apiMiddleware';
import { Provider } from 'react-redux';
import { rootReducer } from './reducers';
import { preLoadedState } from './reducers/preLoadedState';
import App from './app';
import 'bootstrap/dist/css/bootstrap.min.css';
import './index.css';

const store = createStore(
	rootReducer,
	preLoadedState(),
	applyMiddleware(logging, apiMiddleware, thunk)
);

ReactDOM.render(
  <Provider store={store}>
  	<App />
  </Provider>,
  document.getElementById('root')
);
