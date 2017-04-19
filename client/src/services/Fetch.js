export default class Fetch {
	static get(URL) {
		return new Promise((resolve, reject) => {
			fetch(URL, {
				method: 'GET',
				headers: {
					'Accept-Charset': 'utf-8',
				},
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
				headers: {
					'Accept-Charset': 'utf-8',
					'Content-Type': 'application/json',
				},
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
}