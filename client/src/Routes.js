import OrdersContainer from './containers/OrdersContainer';
import OrderContainer from './containers/OrderContainer';

export const Routes = [
	{
		path: '/orders',
		exact: true,
		component: OrdersContainer,
		helper: {
			name: 'orders_path',
			func:  function() {
				return '/orders';
			},
		}, 
	},
	{
		path: '/orders/:id',
		exact: true,
		component: OrderContainer,
		helper: {
			name: 'order_path',
			func: function(id) {
				if(typeof id !== 'string')
					throw new Error('order_path expects id as string');
				return `/orders/${id}`;
			},
		},
	},
]

export const RoutesHelper = Routes.reduce((acc, val) => {
	var obj = {}
	obj[val.helper.name] = val.helper.func;
	return Object.assign(acc, obj); 
}, {});