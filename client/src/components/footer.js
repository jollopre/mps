import React from 'react';
const style = {
	position: 'absolute',
	right: 0,
	bottom: 0,
	left:0,
	minHeight: '50px',
	padding: '1rem',
	textAlign: 'center',
	backgroundColor: '#222',
	color: '#fff',
	fontSize: 'small',
};

export const Footer = function(){
	return (
		<div style={style}>
			<ul className="list-inline">
				<li>
					&copy; {new Date().getFullYear()} <a 
					className="text-warning"
					href="http://marshallpackaging.com"
					target="_blank">
						Marshall Packaging Ltd
					</a>
				</li>
				<li>|</li>
				<li>
					<a
					className="text-warning"
					href="https://github.com/jollopre"
					target="_blank">
						Powered by jollopre
					</a>
				</li>
			</ul>
		</div>
	);
}