import { FetchHeaders } from './FetchHeaders';

export default class Fetch {
	static get(URL) {
		return new Promise((resolve, reject) => {
			fetch(URL, {
				method: 'GET',
				headers: FetchHeaders.entries(),
			}).then((onFullfilled) => {
				if(onFullfilled.ok) { // status in the range 200-299
					resolve(onFullfilled.json());
				} else {
					reject({ status: onFullfilled.status,
						statusText: onFullfilled.statusText});
				}
			}, (onRejected) => {
				reject({ status: onRejected.status,
					statusText: onRejected.statusText});
			});
		});
	}
	static post(URL, body){
		return new Promise((resolve, reject) => {
			fetch(URL, {
				method: 'POST',
				headers: FetchHeaders.entries(),
				body: JSON.stringify(body),
			}).then((onFullfilled) => {
				if(onFullfilled.ok) {
					resolve(onFullfilled);
				} else {
					reject({ status: onFullfilled.status,
						statusText: onFullfilled.statusText});
				}
			}, (onRejected) => {
				reject({ status: onRejected.status,
						statusText: onRejected.statusText});
			});
		});
	}
	static put(URL, body){
		return new Promise((resolve, reject) => {
			fetch(URL, {
				method: 'PUT',
				headers: FetchHeaders.entries(),
				body: JSON.stringify(body),
			}).then((onFullfilled) => {
				if(onFullfilled.ok) {
					resolve(onFullfilled);
				} else {
					reject({ status: onFullfilled.status,
						statusText: onFullfilled.statusText});
				}
			}, (onRejected) => {
				reject({ status: onRejected.status,
						statusText: onRejected.statusText});
			});
		});
	}
	static delete(URL){
		return new Promise((resolve, reject) => {
			fetch(URL, {
				method: 'DELETE',
				headers: FetchHeaders.entries(),
			}).then((onFullfilled) => {
				if(onFullfilled.ok) {
					resolve(onFullfilled);
				} else {
					reject({ status: onFullfilled.status,
						statusText: onFullfilled.statusText});
				}
			}, (onRejected) => {
				reject({ status: onRejected.status,
						statusText: onRejected.statusText});
			});
		});
	}
}