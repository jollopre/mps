import Fetch from './Fetch';

export default class FeatureValueService {
	static update(id, value) {
		return Fetch.put(`/api/feature_values/${id}`,
			{feature_value: { value: value }});
	}
}